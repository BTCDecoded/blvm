# Remove sccache from GitHub Runner

If you're getting `sccache: incremental compilation is prohibited` errors, sccache is configured on the runner and needs to be removed.

## Quick Fix

Run these commands on the runner server:

```bash
# 1. Remove RUSTC_WRAPPER from shell profiles
sed -i '/RUSTC_WRAPPER/d' ~/.bashrc ~/.profile ~/.bash_profile 2>/dev/null || true

# 2. Remove sccache from ~/.cargo/config.toml
if [ -f ~/.cargo/config.toml ]; then
  sed -i '/rustc-wrapper.*sccache/d' ~/.cargo/config.toml
  sed -i '/\[build\]/,/^\[/ { /rustc-wrapper/d; }' ~/.cargo/config.toml
fi

# 3. Unset in current session
unset RUSTC_WRAPPER

# 4. Verify it's removed
echo "RUSTC_WRAPPER: [${RUSTC_WRAPPER:-unset}]"
grep -i "sccache\|RUSTC_WRAPPER" ~/.cargo/config.toml ~/.bashrc ~/.profile ~/.bash_profile 2>/dev/null || echo "✅ All sccache references removed"
```

## Verify

After running the above, verify sccache is not being used:

```bash
# This should NOT show sccache
rustc --version

# Check if RUSTC_WRAPPER is set (should be empty)
echo "RUSTC_WRAPPER: [${RUSTC_WRAPPER:-unset}]"
```

If `rustc --version` still shows sccache, restart the runner service:

```bash
# Restart GitHub Actions runner
sudo systemctl restart actions.runner.*  # Adjust service name as needed
# OR if running manually, stop and restart the runner
```

