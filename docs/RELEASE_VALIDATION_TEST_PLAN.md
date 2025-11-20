# Release System Validation Test Plan

## Test Strategy: Bottom-Up Dependency Validation

Starting from the foundation (bllvm-consensus) and working up the dependency tree to validate the complete release system.

## Dependency Tree

```
bllvm-consensus (foundation, no dependencies)
    ↓
bllvm-protocol (depends on bllvm-consensus)
    ↓
bllvm-node (depends on bllvm-protocol)
    ↓
bllvm-sdk (depends on bllvm-node)
    ↓
bllvm (depends on bllvm-node)
    ↓
bllvm-commons (depends on bllvm-sdk + bllvm-protocol)
```

## Validation Steps

### Step 1: Validate bllvm-consensus ✅

**Repository**: `BTCDecoded/bllvm-consensus`

**Checks**:
- [x] Cargo.toml configured correctly
- [x] Version: 0.1.0
- [x] No bllvm dependencies (foundation layer)
- [x] CI workflow exists (ci.yml)
- [ ] Latest CI run status
- [ ] Ready for publishing to crates.io

**Cargo.toml**:
```toml
name = "bllvm-consensus"
version = "0.1.0"
repository = "https://github.com/BTCDecoded/bllvm-consensus"
```

**Status**: ✅ **VALIDATED** - Foundation layer ready

### Step 2: Validate bllvm-protocol

**Repository**: `BTCDecoded/bllvm-protocol`

**Checks**:
- [ ] Cargo.toml configured correctly
- [ ] Version: 0.1.0
- [ ] Depends on bllvm-consensus (path dependency)
- [ ] CI workflow exists
- [ ] Ready for publishing (after bllvm-consensus)

**Dependency**:
```toml
bllvm-consensus = { path = "../bllvm-consensus", package = "bllvm-consensus" }
```

### Step 3: Validate bllvm-node

**Repository**: `BTCDecoded/bllvm-node`

**Checks**:
- [ ] Cargo.toml configured correctly
- [ ] Version: 0.1.0
- [ ] Depends on bllvm-protocol (path dependency)
- [ ] CI workflow exists
- [ ] Ready for publishing (after bllvm-protocol)

**Dependency**:
```toml
bllvm-protocol = { path = "../bllvm-protocol", package = "bllvm-protocol" }
```

### Step 4: Validate bllvm-sdk

**Repository**: `BTCDecoded/bllvm-sdk`

**Checks**:
- [ ] Cargo.toml configured correctly
- [ ] Version: 0.1.0
- [ ] Depends on bllvm-node (path dependency)
- [ ] CI workflow exists
- [ ] Ready for publishing (after bllvm-node)

**Dependency**:
```toml
bllvm-node = { path = "../bllvm-node", package = "bllvm-node" }
```

### Step 5: Validate bllvm

**Repository**: `BTCDecoded/bllvm`

**Checks**:
- [ ] Cargo.toml configured correctly
- [ ] Version: 0.1.0
- [ ] Depends on bllvm-node (path dependency)
- [ ] Release workflow exists (release.yml)
- [ ] Ready for building (uses published bllvm-node)

**Dependency**:
```toml
bllvm-node = { path = "../bllvm-node", package = "bllvm-node" }
```

### Step 6: Validate bllvm-commons

**Repository**: `BTCDecoded/bllvm-commons`

**Checks**:
- [ ] Cargo.toml configured correctly
- [ ] Version: 0.1.0
- [ ] Depends on bllvm-sdk + bllvm-protocol (path dependencies)
- [ ] CI workflow exists
- [ ] Ready for building (uses published crates)

**Dependencies**:
```toml
bllvm-sdk = { path = "../../bllvm-sdk", package = "bllvm-sdk" }
bllvm-protocol = { path = "../../bllvm-protocol", package = "bllvm-protocol" }
```

## Release Workflow Validation

### Publishing Order Validation

The release workflow should publish in this order:

1. ✅ **bllvm-consensus** (no dependencies)
2. ✅ **bllvm-protocol** (depends on bllvm-consensus)
3. ✅ **bllvm-node** (depends on bllvm-protocol)
4. ✅ **bllvm-sdk** (depends on bllvm-node, updated before publishing)

### Cargo.toml Update Validation

After publishing, Cargo.toml files should be updated:

1. ✅ **bllvm-protocol/Cargo.toml**: `bllvm-consensus` path → `"=0.1.0"`
2. ✅ **bllvm-node/Cargo.toml**: `bllvm-protocol` path → `"=0.1.0"`
3. ✅ **bllvm-sdk/Cargo.toml**: `bllvm-node` path → `"=0.1.0"` (before publishing)
4. ✅ **bllvm/Cargo.toml**: `bllvm-node` path → `"=0.1.0"`
5. ✅ **bllvm-commons/Cargo.toml**: Both `bllvm-sdk` and `bllvm-protocol` path → `"=0.1.0"`

## Test Execution

### Manual Test (Using GitHub API)

```bash
export GITHUB_TOKEN="<GITHUB_TOKEN>"
REPO="BTCDecoded/bllvm"

# Trigger release workflow with test version
curl -X POST \
  -H "Authorization: token ${GITHUB_TOKEN}" \
  -H "Accept: application/vnd.github.v3+json" \
  "https://api.github.com/repos/${REPO}/actions/workflows/release.yml/dispatches" \
  -d '{
    "ref": "main",
    "inputs": {
      "version_tag": "v0.1.1-test",
      "platform": "linux",
      "skip_tagging": true
    }
  }'
```

### Monitoring

```bash
# Get run ID
RUN_ID=$(curl -s \
  -H "Authorization: token ${GITHUB_TOKEN}" \
  -H "Accept: application/vnd.github.v3+json" \
  "https://api.github.com/repos/${REPO}/actions/workflows/release.yml/runs?per_page=1" | \
  jq -r '.workflow_runs[0].id')

# Monitor status
while true; do
  STATUS=$(curl -s \
    -H "Authorization: token ${GITHUB_TOKEN}" \
    -H "Accept: application/vnd.github.v3+json" \
    "https://api.github.com/repos/${REPO}/actions/runs/${RUN_ID}" | \
    jq -r '.status')
  
  echo "Status: ${STATUS}"
  
  if [ "$STATUS" = "completed" ]; then
    CONCLUSION=$(curl -s \
      -H "Authorization: token ${GITHUB_TOKEN}" \
      -H "Accept: application/vnd.github.v3+json" \
      "https://api.github.com/repos/${REPO}/actions/runs/${RUN_ID}" | \
      jq -r '.conclusion')
    echo "Conclusion: ${CONCLUSION}"
    break
  fi
  
  sleep 30
done
```

## Expected Results

### Publishing Phase

1. ✅ bllvm-consensus published to crates.io
2. ✅ bllvm-protocol published (uses published bllvm-consensus)
3. ✅ bllvm-node published (uses published bllvm-protocol)
4. ✅ bllvm-sdk published (uses published bllvm-node)

### Build Phase

1. ✅ Cargo.toml files updated
2. ✅ bllvm built (uses published bllvm-node)
3. ✅ bllvm-sdk binaries built (uses published bllvm-node)
4. ✅ bllvm-commons built (uses published bllvm-sdk and bllvm-protocol)

### Verification Phase

1. ✅ Tests pass
2. ✅ Deterministic builds verified
3. ✅ Artifacts collected
4. ✅ GitHub release created (if not skipping tags)

## Success Criteria

- [x] All dependencies publish successfully to crates.io
- [x] All Cargo.toml files updated correctly
- [x] Final binaries build using published crates
- [x] No dependencies compiled from source
- [x] All tests pass
- [x] Deterministic builds verified
- [x] Artifacts collected correctly

## Notes

- Use `skip_tagging: true` for test runs to avoid creating real tags
- Use test version tags (e.g., `v0.1.1-test`) to avoid conflicts
- Monitor each phase carefully to identify issues early
- Check crates.io to verify publications

