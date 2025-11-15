# Self-Hosted Runner Performance Optimization Guide

**Date:** 2025-11-14  
**Status:** Active Recommendations

## Overview

This guide covers optimizations you can install on your self-hosted runner to significantly speed up Rust builds.

## Critical Optimizations (High Impact)

### 1. **mold Linker** ⭐⭐⭐ (Highest Impact)

The `mold` linker is 2-5x faster than the default GNU gold linker for Rust builds.

**Installation (Ubuntu/Debian):**
```bash
sudo apt-get update
sudo apt-get install -y mold
```

**Installation (Arch Linux):**
```bash
sudo pacman -S mold
```

**Configuration:**
Add to `~/.cargo/config.toml` or `$CARGO_HOME/config.toml`:
```toml
[target.x86_64-unknown-linux-gnu]
linker = "clang"
rustflags = ["-C", "link-arg=-fuse-ld=mold"]
```

Or set environment variable in workflow:
```yaml
env:
  RUSTFLAGS: "-C link-arg=-fuse-ld=mold"
```

**Expected Speedup:** 30-50% faster linking phase (especially for release builds with LTO)

### 2. **sccache** ⭐⭐⭐ (High Impact for Repeated Builds)

`sccache` caches compiled Rust code across builds, dramatically speeding up incremental builds.

**Installation:**
```bash
cargo install sccache
```

**Configuration:**
Add to `~/.cargo/config.toml`:
```toml
[build]
rustc-wrapper = "/home/runner/.cargo/bin/sccache"
```

Or set environment variable:
```bash
export RUSTC_WRAPPER=sccache
```

**Storage Backend (Optional - for shared cache):**
```bash
# Use local filesystem (default)
export SCCACHE_DIR=/tmp/sccache

# Or use Redis (for multiple runners)
export SCCACHE_REDIS=redis://localhost:6379
```

**Expected Speedup:** 50-90% faster for incremental builds, 20-40% for clean builds

### 3. **ccache** ⭐⭐ (Medium Impact)

`ccache` caches C/C++ compilation (useful for dependencies with C code like `openssl-sys`, `cc`, etc.)

**Installation:**
```bash
sudo apt-get install -y ccache  # Ubuntu/Debian
sudo pacman -S ccache           # Arch Linux
```

**Configuration:**
```bash
export CC="ccache gcc"
export CXX="ccache g++"
```

**Expected Speedup:** 30-60% faster for C dependencies

## System-Level Optimizations

### 4. **Pre-install Rust Toolchain**

Pre-install the Rust toolchain to avoid downloading on every run:

```bash
rustup toolchain install stable
rustup default stable
rustup component add rustfmt clippy
```

### 5. **Pre-warm Cargo Registry**

Pre-download common dependencies:

```bash
# Create a dummy project with common dependencies
cargo new --bin warmup
cd warmup
# Add common dependencies to Cargo.toml
cargo build --release
# Keep the registry cache
```

### 6. **Increase Cargo Parallel Jobs**

Set in `~/.cargo/config.toml`:
```toml
[build]
jobs = 0  # 0 = use all CPU cores
```

Or set environment variable:
```bash
export CARGO_BUILD_JOBS=0
```

### 7. **Enable Incremental Compilation**

Set in `~/.cargo/config.toml`:
```toml
[build]
incremental = true
```

Or set environment variable:
```bash
export CARGO_INCREMENTAL=1
```

### 8. **Use Faster Storage**

- **SSD**: Essential for fast I/O during compilation
- **tmpfs**: Use RAM disk for `target/` directory (if you have enough RAM)

```bash
# Create tmpfs for target directory (8GB example)
sudo mkdir -p /mnt/ramdisk
sudo mount -t tmpfs -o size=8G tmpfs /mnt/ramdisk
export CARGO_TARGET_DIR=/mnt/ramdisk/target
```

**Warning:** Only use if you have 16GB+ RAM and can spare 8GB for builds

## Network Optimizations

### 9. **Use Cargo Mirror/Proxy**

Set up a local Cargo registry mirror to cache crates:

```bash
# Use crates.io mirror
export CARGO_NET_GIT_FETCH_WITH_CLI=true
```

Or configure in `~/.cargo/config.toml`:
```toml
[source.crates-io]
replace-with = "local-mirror"

[source.local-mirror]
local-registry = "/path/to/local/registry"
```

### 10. **Pre-download Git Dependencies**

For git-based dependencies, pre-clone them:

```bash
# Pre-clone common git dependencies
git clone https://github.com/BTCDecoded/bllvm-consensus.git /tmp/bllvm-consensus
# Cargo will use cached git checkouts
```

## Recommended Installation Script

Create `/opt/setup-runner-optimizations.sh`:

```bash
#!/bin/bash
set -e

echo "🚀 Setting up runner optimizations..."

# Install mold linker
if ! command -v mold &> /dev/null; then
    echo "Installing mold linker..."
    sudo apt-get update
    sudo apt-get install -y mold
fi

# Install sccache
if ! command -v sccache &> /dev/null; then
    echo "Installing sccache..."
    cargo install sccache
fi

# Install ccache
if ! command -v ccache &> /dev/null; then
    echo "Installing ccache..."
    sudo apt-get install -y ccache
fi

# Configure Cargo
mkdir -p ~/.cargo
cat > ~/.cargo/config.toml << 'EOF'
[build]
rustc-wrapper = "/home/runner/.cargo/bin/sccache"
jobs = 0
incremental = true

[target.x86_64-unknown-linux-gnu]
linker = "clang"
rustflags = ["-C", "link-arg=-fuse-ld=mold"]
EOF

# Configure environment
cat >> ~/.bashrc << 'EOF'
export RUSTC_WRAPPER=sccache
export CC="ccache gcc"
export CXX="ccache g++"
export SCCACHE_DIR=/tmp/sccache
export CARGO_BUILD_JOBS=0
export CARGO_INCREMENTAL=1
EOF

echo "✅ Runner optimizations installed!"
echo ""
echo "Restart the runner or source ~/.bashrc to apply changes"
```

## Expected Overall Speedup

With all optimizations:
- **First build:** 20-30% faster
- **Incremental builds:** 60-80% faster
- **Linking phase:** 50-70% faster

## Priority Order

1. **mold linker** - Easiest, highest impact
2. **sccache** - High impact, especially for CI
3. **ccache** - Medium impact, helps with C dependencies
4. **System optimizations** - Lower impact but still valuable

## Monitoring

Check sccache stats:
```bash
sccache --show-stats
```

Check ccache stats:
```bash
ccache -s
```

## Notes

- **mold** requires `clang` to be installed
- **sccache** needs disk space for cache (default: ~10GB)
- **ccache** needs disk space for cache (default: ~5GB)
- Monitor disk space usage regularly
- Clear caches periodically if disk space is limited

