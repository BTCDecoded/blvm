# AWS Spot Instance Runner Implementation Plan

## Overview

This plan implements shared AWS spot instance infrastructure for running:
- **Medium and slow Kani proof tiers** across `blvm-consensus` and `blvm-node` repositories
- **Performance benchmarks** across `blvm-consensus`, `blvm-node`, and `blvm-bench` repositories

The infrastructure is centralized in the `blvm/` (commons) repository for reuse across all repos.

## Goals

1. **Shared Infrastructure**: Single AMI and reusable workflow in `blvm/` used by all repos
2. **Cost Efficiency**: Use AWS spot instances for memory-intensive proof tiers and CPU-intensive benchmarks
3. **Flexibility**: Support different instance types for different workloads (proofs vs benchmarks)
4. **Consistency**: All repos use the same runner configuration
5. **Maintainability**: Update once in `blvm/`, all repos benefit

## Architecture

```
blvm/ (commons)
├── ops/aws/                    # Shared AWS infrastructure
│   ├── README.md               # Setup and usage guide
│   ├── packer/
│   │   └── kani-runner-ami.pkr.hcl
│   └── user-data/
│       └── kani-runner-userdata.sh
├── .github/workflows/
│   └── provision-spot-runner.yml  # Reusable workflow
└── tools/
    └── prepare-kani-ami.sh     # Helper script for AMI prep

blvm-consensus/.github/workflows/ci.yml
└── Calls provision-spot-runner.yml

blvm-node/.github/workflows/ci.yml
└── Calls provision-spot-runner.yml

blvm-bench/.github/workflows/ci.yml
└── Calls provision-spot-runner.yml
```

## Implementation Steps

### Phase 1: Infrastructure Setup (blvm/)

#### 1.1 Create Directory Structure
- [ ] Create `blvm/ops/aws/` directory
- [ ] Create `blvm/ops/aws/packer/` subdirectory
- [ ] Create `blvm/ops/aws/user-data/` subdirectory

#### 1.2 Create Packer Configuration
**File**: `blvm/ops/aws/packer/kani-runner-ami.pkr.hcl`

**Purpose**: Define AMI build configuration with:
- Base image: Ubuntu 22.04 LTS (or latest)
- Pre-installed: Rust toolchain, Kani, GitHub Actions runner binary
- Instance type: c6i.4xlarge (16 vCPU, 32GB RAM) for building
- Region: us-east-1 (configurable)

**Key Components**:
- Source block for AWS AMI builder
- Build block with provisioners:
  - Shell provisioner to download and run `bootstrap_runner.sh` with `--rust --kani` flags
  - Install GitHub Actions runner application binary (don't configure)
  - Create runner user and directories
  - Cleanup and optimize image

#### 1.3 Create User Data Script
**File**: `blvm/ops/aws/user-data/kani-runner-userdata.sh`

**Purpose**: Script run on instance launch to:
- Register GitHub Actions runner with provided token
- Configure runner labels: `self-hosted,Linux,X64,spot,kani`
- Start runner service
- Handle spot instance interruption gracefully

**Key Features**:
- Idempotent (safe to re-run)
- Error handling and logging
- Cleanup on termination

#### 1.4 Create Reusable Workflow
**File**: `blvm/.github/workflows/provision-spot-runner.yml`

**Purpose**: Reusable workflow that:
- Provisions EC2 spot instance using `machulav/ec2-github-runner@v2`
- Configures runner with appropriate labels
- Returns runner label for dependent jobs
- Handles cleanup on job completion

**Inputs**:
- `repo_name`: Repository name (blvm-consensus, blvm-node, blvm-bench)
- `runner_labels`: Comma-separated labels (default: `self-hosted, Linux, X64, spot, kani`)
- `instance_type`: EC2 instance type (default: `c6i.4xlarge` for proofs, `c6i.8xlarge` for benchmarks)
- `ami_id`: AMI ID with Rust + Kani (required, from org secret)
- `workload_type`: Type of workload (`kani` or `benchmark`, default: `kani`)

**Secrets** (org-level):
- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `AWS_SUBNET_ID` (VPC subnet for instances)
- `AWS_SECURITY_GROUP_ID` (security group for runners)
- `KANI_RUNNER_AMI_ID` (shared AMI ID)

**Outputs**:
- `runner_label`: Label to use in `runs-on` (e.g., `self-hosted, Linux, X64, spot, kani`)

#### 1.5 Create Documentation
**File**: `blvm/ops/aws/README.md`

**Contents**:
- Overview and architecture
- Prerequisites (AWS account, IAM permissions, GitHub secrets)
- AMI creation steps (using Packer)
- Manual AMI creation (alternative to Packer)
- Workflow usage examples
- Troubleshooting
- Cost estimates

#### 1.6 Create Helper Script (Optional)
**File**: `blvm/tools/prepare-kani-ami.sh`

**Purpose**: Wrapper script to:
- Validate Packer installation
- Build AMI using Packer config
- Output AMI ID for manual secret configuration
- Provide instructions for next steps

### Phase 2: Repository Integration

#### 2.1 Update blvm-consensus CI
**File**: `blvm-consensus/.github/workflows/ci.yml`

**Changes**:
1. Add new job `provision-spot-runner` that calls reusable workflow
2. Modify `verify` job to:
   - Add conditional job for medium/slow tiers: `verify-medium-slow`
   - Make it depend on `provision-spot-runner`
   - Use spot runner labels: `runs-on: [self-hosted, Linux, X64, spot, kani]`
   - Run only when `run_proof_tier` is `fast_medium` or `all`
   - Keep existing strong tier on regular runners
3. Add cleanup job to ensure spot instance is terminated

**Job Structure**:
```yaml
provision-spot-runner:
  name: Provision Spot Runner
  uses: BTCDecoded/blvm/.github/workflows/provision-spot-runner.yml@main
  with:
    repo_name: blvm-consensus
    ami_id: ${{ secrets.KANI_RUNNER_AMI_ID }}
    instance_type: c6i.4xlarge
  secrets: inherit

verify-medium-slow:
  name: Verify (Medium + Slow Proofs)
  needs: [provision-spot-runner]
  runs-on: [self-hosted, Linux, X64, spot, kani]
  if: |
    steps.proof_tier.outputs.tier == 'fast_medium' ||
    steps.proof_tier.outputs.tier == 'all'
  # ... existing proof execution logic ...

cleanup-spot-runner:
  name: Cleanup Spot Runner
  needs: [verify-medium-slow]
  if: always()
  runs-on: ubuntu-latest
  steps:
    - name: Stop EC2 Runner
      uses: machulav/ec2-github-runner@v2
      with:
        mode: stop
        github-token: ${{ secrets.GITHUB_TOKEN }}
        label: ${{ needs.provision-spot-runner.outputs.runner_label }}
```

#### 2.2 Update blvm-node CI
**File**: `blvm-node/.github/workflows/ci.yml`

**Changes**: Same as blvm-consensus, but:
- `repo_name: blvm-node`
- Use same AMI ID (shared)

#### 2.3 Update blvm-bench CI (Benchmarks)
**File**: `blvm-bench/.github/workflows/ci.yml`

**Changes**: Similar pattern but for benchmarks:
1. Add new job `provision-benchmark-runner` that calls reusable workflow
2. Configure for benchmark execution:
   - Use larger instance type: `c6i.8xlarge` (32 vCPU, 64GB RAM) for better CPU performance
   - Use benchmark-specific labels: `self-hosted, Linux, X64, spot, benchmark`
   - Set `workload_type: benchmark`
3. Add benchmark execution job:
   - Depends on `provision-benchmark-runner`
   - Runs `cargo bench --release` with appropriate features
   - Uploads benchmark results as artifacts
4. Add cleanup job

**Job Structure**:
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
  timeout-minutes: 180  # Benchmarks can take 2-3 hours
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
  # ... cleanup steps ...
```

#### 2.4 Add Benchmark Support to Individual Repos (Optional)
**Files**: `blvm-consensus/.github/workflows/ci.yml`, `blvm-node/.github/workflows/ci.yml`

**Changes**: Add optional benchmark jobs that can run on spot instances:
- Use same reusable workflow
- Configure with benchmark labels and larger instance type
- Run `cargo bench` as part of CI (on schedule or manual trigger)

### Phase 3: Testing & Validation

#### 3.1 AMI Validation
- [ ] Build AMI using Packer
- [ ] Manually launch test instance from AMI
- [ ] Verify Rust toolchain installed
- [ ] Verify Kani installed and functional
- [ ] Verify GitHub Actions runner can register
- [ ] Test spot instance interruption handling

#### 3.2 Workflow Validation
- [ ] Test reusable workflow in isolation (workflow_dispatch)
- [ ] Verify spot instance provisions correctly
- [ ] Verify runner registers with correct labels
- [ ] Test job execution on spot runner
- [ ] Verify cleanup on job completion (explicit cleanup job)
- [ ] Verify `machulav/ec2-github-runner@v2` action parameters match documentation

#### 3.3 Integration Testing
- [ ] Test blvm-consensus medium/slow proofs on spot runner
- [ ] Test blvm-node medium/slow proofs on spot runner
- [ ] Test blvm-bench benchmarks on spot runner (c6i.8xlarge)
- [ ] Verify benchmark results are consistent and reproducible
- [ ] Verify cost savings vs on-demand instances
- [ ] Test interruption handling (simulate spot termination)
- [ ] Test concurrent job execution from multiple repos
- [ ] Test different instance types for different workloads

### Phase 4: Documentation & Rollout

#### 4.1 Update Existing Documentation
- [ ] Update `blvm/ops/RUNNER_FLEET.md` to mention spot runners
- [ ] Update `blvm/ops/SELF_HOSTED_RUNNER.md` if needed
- [ ] Add spot runner section to workflow methodology docs

#### 4.2 Create Migration Guide
- [ ] Document how to migrate from manual runners to spot instances
- [ ] Provide rollback procedures
- [ ] Document monitoring and alerting setup

## File Specifications

### Packer Configuration (`kani-runner-ami.pkr.hcl`)

```hcl
packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1"
    }
  }
}

variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "instance_type" {
  type    = string
  default = "c6i.4xlarge"
}

source "amazon-ebs" "kani-runner" {
  ami_name      = "kani-runner-${formatdate("YYYY-MM-DD-hhmm", timestamp())}"
  instance_type = var.instance_type
  region        = var.aws_region
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"] # Canonical
  }
  ssh_username = "ubuntu"
  tags = {
    Name        = "Kani Runner AMI"
    Purpose     = "GitHub Actions Runner for Kani Proofs"
    ManagedBy   = "Packer"
    Repository  = "BTCDecoded/blvm"
  }
}

build {
  name = "kani-runner"
  sources = ["source.amazon-ebs.kani-runner"]

  provisioner "shell" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y curl jq",
      "curl -fsSL https://raw.githubusercontent.com/BTCDecoded/blvm/main/tools/bootstrap_runner.sh -o /tmp/bootstrap_runner.sh",
      "sudo chmod +x /tmp/bootstrap_runner.sh",
      "sudo /tmp/bootstrap_runner.sh --rust --kani --cache-dir /tmp/runner-cache || true"
    ]
  }

  provisioner "shell" {
    inline = [
      "sudo useradd -m -s /bin/bash actions-runner || true",
      "sudo mkdir -p /opt/actions-runner",
      "cd /tmp",
      "RUNNER_VERSION=$(curl -s https://api.github.com/repos/actions/runner/releases/latest | jq -r .tag_name | sed 's/v//')",
      "curl -o actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz",
      "sudo tar xzf actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz -C /opt/actions-runner",
      "sudo chown -R actions-runner:actions-runner /opt/actions-runner",
      "rm -f actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz"
    ]
  }

  provisioner "shell" {
    inline = [
      "sudo rm -rf /tmp/*",
      "sudo apt-get clean",
      "sudo rm -rf /var/lib/apt/lists/*",
      "sudo truncate -s 0 /var/log/*.log",
      "sudo find /var/log -type f -name '*.log' -exec truncate -s 0 {} \\;"
    ]
  }
}
```

### User Data Script (`kani-runner-userdata.sh`)

```bash
#!/bin/bash
set -euo pipefail

# Log everything
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

RUNNER_USER="actions-runner"
RUNNER_DIR="/opt/actions-runner"
GITHUB_TOKEN="${GITHUB_TOKEN:-}"
GITHUB_REPO="${GITHUB_REPO:-}"
RUNNER_LABELS="${RUNNER_LABELS:-self-hosted,Linux,X64,spot,kani}"

# Wait for metadata service
until curl -s http://169.254.169.254/latest/meta-data/instance-id; do
  sleep 1
done

# Download and install runner (if not already installed)
if [ ! -f "$RUNNER_DIR/bin/Runner.Listener" ]; then
  cd /tmp
  RUNNER_VERSION=$(curl -s https://api.github.com/repos/actions/runner/releases/latest | jq -r .tag_name | sed 's/v//')
  curl -o actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz
  sudo tar xzf actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz -C "$RUNNER_DIR"
  sudo chown -R $RUNNER_USER:$RUNNER_USER "$RUNNER_DIR"
fi

# Configure runner (if token provided)
if [ -n "$GITHUB_TOKEN" ] && [ -n "$GITHUB_REPO" ]; then
  cd "$RUNNER_DIR"
  sudo -u $RUNNER_USER ./config.sh \
    --url "https://github.com/$GITHUB_REPO" \
    --token "$GITHUB_TOKEN" \
    --labels "$RUNNER_LABELS" \
    --replace \
    --unattended || true
fi

# Install and start service
sudo "$RUNNER_DIR/svc.sh" install "$RUNNER_USER" || true
sudo "$RUNNER_DIR/svc.sh" start || true

# Handle spot interruption
trap 'sudo "$RUNNER_DIR/svc.sh" stop; sudo "$RUNNER_DIR/svc.sh" uninstall; exit 0' SIGTERM

# Keep script running
while true; do
  sleep 60
done
```

### Reusable Workflow (`provision-spot-runner.yml`)

```yaml
name: Provision Spot Runner

on:
  workflow_call:
    inputs:
      repo_name:
        required: true
        type: string
        description: 'Repository name (e.g., blvm-consensus)'
      runner_labels:
        required: false
        type: string
        default: 'self-hosted, Linux, X64, spot, kani'
        description: 'Comma-separated runner labels'
      instance_type:
        required: false
        type: string
        default: 'c6i.4xlarge'
        description: 'EC2 instance type (c6i.4xlarge for proofs, c6i.8xlarge for benchmarks)'
      ami_id:
        required: true
        type: string
        description: 'AMI ID with Rust + Kani pre-installed'
      workload_type:
        required: false
        type: string
        default: 'kani'
        description: 'Type of workload (kani or benchmark)'
    secrets:
      AWS_ACCESS_KEY_ID:
        required: true
      AWS_SECRET_ACCESS_KEY:
        required: true
      GITHUB_TOKEN:
        required: true
      AWS_SUBNET_ID:
        required: true
      AWS_SECURITY_GROUP_ID:
        required: true

permissions:
  contents: read
  actions: write

jobs:
  provision:
    name: Provision Spot Runner
    runs-on: ubuntu-latest
    timeout-minutes: 10
    outputs:
      runner_label: ${{ steps.runner.outputs.label }}
    steps:
      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v4
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws-region: us-east-1

      - name: Start EC2 Spot Runner
        uses: machulav/ec2-github-runner@v2
        id: runner
        with:
          mode: start
          github-token: ${{ secrets.GITHUB_TOKEN }}
          ec2-image-id: ${{ inputs.ami_id }}
          ec2-instance-type: ${{ inputs.instance_type }}
          ec2-region: us-east-1
          market-type: spot
          subnet-id: ${{ secrets.AWS_SUBNET_ID }}
          security-group-id: ${{ secrets.AWS_SECURITY_GROUP_ID }}
          runner-labels: ${{ inputs.runner_labels }}
          runner-group: Default
          disable-auto-update: true
          # Note: user-data script should be embedded in AMI or provided via launch template
          # Check machulav/ec2-github-runner@v2 documentation for user-data parameter format
          # For benchmarks, consider using larger instance types (c6i.8xlarge or c6i.16xlarge)
          aws-resource-tags: |
            [
              {
                "Key": "Purpose",
                "Value": "${{ inputs.workload_type == 'benchmark' && 'Benchmark Runner' || 'Kani Proof Runner' }}"
              },
              {
                "Key": "Repository",
                "Value": "${{ inputs.repo_name }}"
              },
              {
                "Key": "WorkloadType",
                "Value": "${{ inputs.workload_type }}"
              },
              {
                "Key": "ManagedBy",
                "Value": "GitHub Actions"
              }
            ]
```

## Validation Checklist

### Pre-Implementation
- [ ] AWS account configured with appropriate IAM permissions
- [ ] GitHub organization has required secrets configured
- [ ] VPC and security group configured for runners
- [ ] Packer installed locally (for AMI creation)
- [ ] Access to test repositories for validation

### Post-Implementation
- [ ] AMI builds successfully with Packer
- [ ] AMI ID stored in org-level secret `KANI_RUNNER_AMI_ID`
- [ ] Reusable workflow validates successfully
- [ ] Spot instance provisions correctly
- [ ] Runner registers with correct labels
- [ ] Kani proofs execute successfully on spot runner
- [ ] Cleanup works on job completion
- [ ] Cost monitoring shows expected savings
- [ ] Documentation is complete and accurate

## Cost Estimates

**Assumptions**:
- c6i.4xlarge (proofs): ~$0.68/hour on-demand, ~$0.20/hour spot (70% savings)
- c6i.8xlarge (benchmarks): ~$1.36/hour on-demand, ~$0.40/hour spot (70% savings)
- Medium tier proofs: ~2 hours runtime
- Slow tier proofs: ~4-6 hours runtime
- Benchmarks: ~2-3 hours runtime
- Frequency: Manual trigger (workflow_dispatch) for proofs, scheduled for benchmarks

**Estimated Costs**:
- Medium tier proof run: ~$0.40 per run
- Slow tier proof run: ~$0.80-$1.20 per run
- Benchmark run: ~$0.80-$1.20 per run
- Monthly (10 proof runs + 30 benchmark runs): ~$30-40/month

**Comparison**:
- On-demand equivalent: ~$100-140/month
- **Savings: ~70%**

## Security Considerations

1. **IAM Permissions**: Minimal permissions for EC2 provisioning only
2. **Secrets Management**: All secrets stored in GitHub org-level secrets
3. **Network Isolation**: Runners in private subnet with security group restrictions
4. **Runner Cleanup**: Automatic cleanup on job completion
5. **AMI Hardening**: Base Ubuntu image with security updates

## Rollback Plan

If issues arise:
1. Disable spot runner jobs in CI workflows (comment out)
2. Revert to existing runner infrastructure
3. Update documentation with known issues
4. Investigate and fix issues
5. Re-enable after validation

## Dependencies

- `machulav/ec2-github-runner@v2` action (GitHub Marketplace)
- `aws-actions/configure-aws-credentials@v4` action
- Packer (for AMI creation)
- AWS CLI (for manual operations)
- Existing `blvm/tools/bootstrap_runner.sh` script

## Timeline Estimate

- **Phase 1** (Infrastructure): 2-3 hours
- **Phase 2** (Integration): 1-2 hours
- **Phase 3** (Testing): 2-3 hours
- **Phase 4** (Documentation): 1 hour

**Total**: ~6-9 hours

## Next Steps After Implementation

1. Monitor spot instance interruption rates
2. Optimize instance type based on actual usage:
   - Proofs: May benefit from memory-optimized instances (r6i) if OOM issues occur
   - Benchmarks: May benefit from compute-optimized instances (c6i) with more cores
3. Consider auto-scaling for multiple concurrent jobs
4. Set up CloudWatch alarms for cost monitoring
5. Benchmark performance comparison: Compare spot vs on-demand benchmark results
6. Document lessons learned and best practices
7. Consider separate AMIs for benchmarks if additional tools needed (e.g., profiling tools)

