# Benchmark Support on Spot Runners

## Overview

The AWS spot runner infrastructure supports running performance benchmarks in addition to Kani proofs. Benchmarks benefit from larger instance types with more CPU cores for better performance.

## Instance Type Recommendations

### Kani Proofs
- **Recommended**: `c6i.4xlarge` (16 vCPU, 32GB RAM)
- **Rationale**: Memory-intensive workloads, 32GB RAM sufficient for most proofs
- **Cost**: ~$0.20/hour spot (~$0.68/hour on-demand)

### Benchmarks
- **Recommended**: `c6i.8xlarge` (32 vCPU, 64GB RAM)
- **Alternative**: `c6i.16xlarge` (64 vCPU, 128GB RAM) for very large benchmark suites
- **Rationale**: CPU-intensive workloads, more cores = faster benchmark execution
- **Cost**: ~$0.40/hour spot (~$1.36/hour on-demand) for c6i.8xlarge

## Usage Examples

### blvm-bench Repository

```yaml
provision-benchmark-runner:
  name: Provision Benchmark Spot Runner
  uses: BTCDecoded/blvm/.github/workflows/provision-spot-runner.yml@main
  with:
    repo_name: blvm-bench
    ami_id: ${{ secrets.KANI_RUNNER_AMI_ID }}
    instance_type: c6i.8xlarge
    runner_labels: 'self-hosted, Linux, X64, spot, benchmark'
    workload_type: benchmark
  secrets: inherit

run-benchmarks:
  name: Run Performance Benchmarks
  needs: [provision-benchmark-runner]
  runs-on: [self-hosted, Linux, X64, spot, benchmark]
  timeout-minutes: 180
  steps:
    - uses: actions/checkout@v4
    
    - name: Setup Rust
      uses: dtolnay/rust-toolchain@stable
    
    - name: Run benchmarks
      run: |
        cargo bench --release --features production -- \
          --output-format json \
          --save-baseline spot-runner-baseline
    
    - name: Upload benchmark results
      uses: actions/upload-artifact@v4
      with:
        name: benchmark-results
        path: target/criterion/**/*.json
        retention-days: 90

cleanup-benchmark-runner:
  name: Cleanup Benchmark Runner
  needs: [run-benchmarks]
  if: always()
  runs-on: ubuntu-latest
  steps:
    - name: Stop EC2 Runner
      uses: machulav/ec2-github-runner@v2
      with:
        mode: stop
        github-token: ${{ secrets.GITHUB_TOKEN }}
        label: ${{ needs.provision-benchmark-runner.outputs.runner_label }}
```

### Individual Repos (Optional)

Repos like `blvm-consensus` and `blvm-node` can also run benchmarks on spot instances:

```yaml
benchmark:
  name: Run Benchmarks
  if: github.event_name == 'schedule' || github.event_name == 'workflow_dispatch'
  uses: BTCDecoded/blvm/.github/workflows/provision-spot-runner.yml@main
  with:
    repo_name: blvm-consensus
    ami_id: ${{ secrets.KANI_RUNNER_AMI_ID }}
    instance_type: c6i.8xlarge
    runner_labels: 'self-hosted, Linux, X64, spot, benchmark'
    workload_type: benchmark
  secrets: inherit
```

## Benchmark Configuration

### Environment Variables

Benchmarks can be configured via environment variables:

```yaml
env:
  BENCH_ITERATIONS: 1000
  BENCH_WARMUP_SECS: 5
  BENCH_MEASUREMENT_SECS: 10
  RUSTFLAGS: "-C target-cpu=native"  # Optimize for instance CPU
```

### Cargo Bench Options

Recommended options for spot runner benchmarks:

```bash
cargo bench --release --features production -- \
  --output-format json \
  --save-baseline spot-runner-baseline \
  --sample-size 100 \
  --warm-up-time 5 \
  --measurement-time 10
```

## Performance Considerations

### Spot Instance Interruptions

Benchmarks are long-running (2-3 hours), so spot interruptions are a concern:

1. **Checkpointing**: Criterion automatically saves progress, but consider:
   - Running smaller benchmark suites separately
   - Using `--save-baseline` to save intermediate results
   - Uploading results as artifacts periodically

2. **Retry Logic**: Consider adding retry logic for interrupted benchmarks:
   ```yaml
   - name: Run benchmarks with retry
     run: |
       MAX_RETRIES=3
       for i in $(seq 1 $MAX_RETRIES); do
         cargo bench --release || {
           if [ $i -eq $MAX_RETRIES ]; then
             exit 1
           fi
           echo "Benchmark interrupted, retrying..."
           sleep 60
         }
       done
   ```

### Reproducibility

Benchmarks on spot instances should be reproducible:

1. **Same Instance Type**: Always use the same instance type for consistency
2. **CPU Affinity**: Consider pinning benchmarks to specific CPU cores
3. **Baseline Comparison**: Compare results against on-demand baselines
4. **Statistical Analysis**: Criterion handles statistical analysis automatically

## Cost Optimization

### Instance Type Selection

- **Small benchmark suites**: `c6i.4xlarge` may be sufficient
- **Large benchmark suites**: `c6i.8xlarge` or `c6i.16xlarge` for faster execution
- **Memory-intensive benchmarks**: Consider `r6i` instances if memory is the bottleneck

### Scheduling

- Run benchmarks on schedule (e.g., daily) rather than on every push
- Use `workflow_dispatch` for manual benchmark runs
- Consider running benchmarks only on main branch or release branches

## Monitoring

### Benchmark Results

Monitor benchmark results for:
- Performance regressions
- Spot instance performance vs on-demand
- Interruption rates and impact on results

### Cost Tracking

Track costs for:
- Spot instance usage
- Interruption-related re-runs
- Comparison with on-demand costs

## Troubleshooting

### Slow Benchmark Execution

- Increase instance size (c6i.8xlarge → c6i.16xlarge)
- Check CPU utilization (may need more cores)
- Verify Rust optimizations are enabled (`--release`)

### Memory Issues

- Switch to memory-optimized instances (r6i family)
- Reduce benchmark sample size
- Run benchmarks in smaller batches

### Spot Interruptions

- Use on-demand instances for critical benchmark runs
- Implement checkpointing and resume logic
- Run benchmarks during off-peak hours (lower interruption risk)

