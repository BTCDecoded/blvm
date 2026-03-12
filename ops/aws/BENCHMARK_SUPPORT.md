# Benchmark Support

## Overview

Benchmarks run on self-hosted runners. No AWS spot provisioning is used.

## Usage

```yaml
benchmark:
  name: Run Benchmarks
  runs-on: [self-hosted, Linux, X64, builds]
  if: github.event_name == 'schedule' || github.event_name == 'workflow_dispatch'
  steps:
    - uses: actions/checkout@v4
    - name: Run benchmarks
      run: cargo bench --release --features production
```

## Configuration

### Environment Variables

```yaml
env:
  BENCH_ITERATIONS: 1000
  BENCH_WARMUP_SECS: 5
  BENCH_MEASUREMENT_SECS: 10
  RUSTFLAGS: "-C target-cpu=native"
```

### Cargo Bench Options

```bash
cargo bench --release --features production -- \
  --output-format json \
  --save-baseline baseline \
  --sample-size 100 \
  --warm-up-time 5 \
  --measurement-time 10
```
