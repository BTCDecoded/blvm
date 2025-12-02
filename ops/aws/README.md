# AWS Spot Instance Runners for Kani Proofs

## Overview

This directory contains shared infrastructure for provisioning AWS EC2 spot instances to run:
- **Medium and slow Kani proof tiers** across `blvm-consensus` and `blvm-node` repositories
- **Performance benchmarks** across `blvm-consensus`, `blvm-node`, and `blvm-bench` repositories

## Architecture

- **Shared AMI**: Single AMI with Rust + Kani pre-installed, used by all repos
- **Reusable Workflow**: `blvm/.github/workflows/provision-spot-runner.yml` provisions spot instances
- **Cost Efficient**: ~70% cost savings vs on-demand instances
- **Automatic Cleanup**: Spot instances terminate after job completion

## Quick Start

### 1. Prerequisites

- AWS account with appropriate IAM permissions
- GitHub organization with required secrets configured
- Packer installed (for AMI creation)
- VPC and security group configured

### 2. Create AMI

```bash
cd blvm/ops/aws/packer
packer build kani-runner-ami.pkr.hcl
```

Note the AMI ID from output and store in GitHub org secret: `KANI_RUNNER_AMI_ID`

### 3. Configure GitHub Secrets

Add these secrets at the organization level:

- `AWS_ACCESS_KEY_ID`: AWS access key
- `AWS_SECRET_ACCESS_KEY`: AWS secret key
- `AWS_SUBNET_ID`: VPC subnet for runners
- `AWS_SECURITY_GROUP_ID`: Security group for runners
- `KANI_RUNNER_AMI_ID`: AMI ID from step 2

### 4. Use in Workflows

Repositories call the reusable workflow:

```yaml
provision-spot-runner:
  uses: BTCDecoded/blvm/.github/workflows/provision-spot-runner.yml@main
  with:
    repo_name: blvm-consensus
    ami_id: ${{ secrets.KANI_RUNNER_AMI_ID }}
  secrets: inherit

verify-medium-slow:
  needs: [provision-spot-runner]
  runs-on: [self-hosted, Linux, X64, spot, kani]
  # ... proof execution ...

# For benchmarks:
provision-benchmark-runner:
  uses: BTCDecoded/blvm/.github/workflows/provision-spot-runner.yml@main
  with:
    repo_name: blvm-bench
    ami_id: ${{ secrets.KANI_RUNNER_AMI_ID }}
    instance_type: c6i.8xlarge
    runner_labels: 'self-hosted, Linux, X64, spot, benchmark'
    workload_type: benchmark
  secrets: inherit

run-benchmarks:
  needs: [provision-benchmark-runner]
  runs-on: [self-hosted, Linux, X64, spot, benchmark]
  steps:
    - uses: actions/checkout@v4
    - name: Run benchmarks
      run: cargo bench --release --features production
```

## Documentation

- **[BENCHMARK_SUPPORT.md](./BENCHMARK_SUPPORT.md)**: Benchmark execution guide
- **[packer/kani-runner-ami.pkr.hcl](./packer/kani-runner-ami.pkr.hcl)**: Packer configuration (to be created)
- **[user-data/kani-runner-userdata.sh](./user-data/kani-runner-userdata.sh)**: User data script (to be created)

**Planning Documents** (not committed, in `docs/aws-spot-runners/`):
- `IMPLEMENTATION_PLAN.md`: Complete implementation plan
- `PLAN_VALIDATION.md`: Validation results and corrections

## Cost Estimates

### Kani Proofs
- **Instance Type**: c6i.4xlarge (16 vCPU, 32GB RAM)
- **On-Demand**: ~$0.68/hour
- **Spot**: ~$0.20/hour (70% savings)
- **Medium Tier**: ~$0.40 per run
- **Slow Tier**: ~$0.80-$1.20 per run

### Benchmarks
- **Instance Type**: c6i.8xlarge (32 vCPU, 64GB RAM) - recommended for better CPU performance
- **On-Demand**: ~$1.36/hour
- **Spot**: ~$0.40/hour (70% savings)
- **Per Run**: ~$0.80-$1.20 per run (2-3 hours typical)

## Security

- Minimal IAM permissions for EC2 provisioning
- Runners in private subnet with security group restrictions
- Automatic cleanup on job completion
- Hardened AMI with security updates

## Troubleshooting

See [IMPLEMENTATION_PLAN.md](./IMPLEMENTATION_PLAN.md) for detailed troubleshooting steps.

## Status

**Current Status**: Planning complete, ready for implementation

See [IMPLEMENTATION_PLAN.md](./IMPLEMENTATION_PLAN.md) for full implementation steps.

