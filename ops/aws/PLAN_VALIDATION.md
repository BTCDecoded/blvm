# Implementation Plan Validation

## Validation Summary

✅ **Overall Plan Status**: **VALID** with minor corrections needed

## Validation Results

### ✅ Strengths

1. **Architecture Alignment**: Plan correctly follows existing patterns:
   - Reusable workflows in `blvm/.github/workflows/`
   - Shared infrastructure in `blvm/ops/`
   - Consistent with `blvm/ops/RUNNER_FLEET.md` patterns
   - Follows `WORKFLOW_METHODOLOGY.md` principles

2. **Repository Structure**: Correctly identifies:
   - `blvm/` as commons/orchestration repo
   - Pattern matches existing `build-single.yml` reusable workflow
   - Correct repository naming: `BTCDecoded/blvm`

3. **Security Considerations**: Appropriate:
   - Org-level secrets for shared AMI
   - Minimal IAM permissions
   - Network isolation considerations

### ⚠️ Issues Found & Corrections Needed

#### 1. Bootstrap Script Usage (CRITICAL)

**Issue**: Plan shows environment variables for `bootstrap_runner.sh`, but script uses command-line flags.

**Current Plan**:
```hcl
environment_vars = [
  "INSTALL_RUST=1",
  "INSTALL_KANI=1",
  ...
]
```

**Correction**: Use command-line flags instead:
```hcl
provisioner "shell" {
  script = "../../tools/bootstrap_runner.sh"
  environment_vars = [
    "RUNNER_USER=ubuntu"
  ]
  inline_before = [
    "chmod +x ../../tools/bootstrap_runner.sh"
  ]
}
```

**Better Approach**: Modify Packer to call script with flags:
```hcl
provisioner "shell" {
  inline = [
    "sudo bash -c 'cd /tmp && curl -fsSL https://raw.githubusercontent.com/BTCDecoded/blvm/main/tools/bootstrap_runner.sh -o bootstrap_runner.sh && chmod +x bootstrap_runner.sh'",
    "sudo bash /tmp/bootstrap_runner.sh --rust --kani --cache-dir /tmp/runner-cache || true"
  ]
}
```

**OR** use inline script that calls bootstrap with flags:
```hcl
provisioner "shell" {
  inline = [
    "sudo bash -c 'INSTALL_RUST=1 INSTALL_KANI=1 bash <(curl -fsSL https://raw.githubusercontent.com/BTCDecoded/blvm/main/tools/bootstrap_runner.sh) || true'"
  ]
}
```

**Recommended Fix**: Update bootstrap script to accept environment variables OR use inline script in Packer.

#### 2. User Data Script Path (NEEDS VERIFICATION)

**Issue**: `machulav/ec2-github-runner` action may not support `user-data-path` parameter directly.

**Current Plan**:
```yaml
user-data-path: 'blvm/ops/aws/user-data/kani-runner-userdata.sh'
```

**Correction Options**:
1. **Option A**: Use `user-data` parameter with base64-encoded content
2. **Option B**: Store user data script in S3 and reference via URL
3. **Option C**: Use action's built-in user data handling

**Recommended**: Check `machulav/ec2-github-runner@v2` documentation for correct parameter name. Likely needs to be:
- `user-data` (inline)
- `user-data-file` (file path)
- Or handled via AMI's launch template

**Action Required**: Verify action documentation before implementation.

#### 3. Repository Naming Inconsistency

**Issue**: Plan incorrectly used `bllvm-consensus`, `bllvm-node`, but actual codebase uses `blvm-consensus`, `blvm-node`.

**Current Plan**: Was using `bllvm-*` naming (incorrect)
**Actual Codebase**: Uses `blvm-*` naming (single 'l')

**Correction**: Update all references:
- `bllvm-consensus` → `blvm-consensus`
- `bllvm-node` → `blvm-node`
- `bllvm-bench` → `blvm-bench`

**Note**: `blvm/` (commons) is correct - it's the orchestration repo.

#### 4. GitHub Actions Runner Installation

**Issue**: User data script downloads runner, but Packer should pre-install it.

**Current Plan**: Runner installation in both Packer and user data.

**Correction**: 
- **Packer**: Install runner application (binary only, don't configure)
- **User Data**: Configure and register runner with token

**Recommended**: Pre-install runner in AMI, configure on launch.

#### 5. Missing Cleanup Job

**Issue**: Plan doesn't explicitly handle cleanup of spot instances.

**Current Plan**: Relies on `machulav/ec2-github-runner` action's cleanup.

**Correction**: Add explicit cleanup job or verify action handles it:
```yaml
cleanup:
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

**Action Required**: Verify if `machulav/ec2-github-runner` handles cleanup automatically or needs explicit step.

#### 6. Runner Label Consistency

**Issue**: Plan uses mixed case labels: `Linux, X64` vs existing `linux, x64`.

**Current Plan**: `self-hosted,Linux,X64,spot,kani`
**Existing Pattern**: `self-hosted, Linux, X64, builds` (with spaces)

**Correction**: Match existing pattern:
- `self-hosted, Linux, X64, spot, kani` (with spaces, title case)

#### 7. Missing blvm-bench Repository

**Issue**: Plan references `blvm-bench` but repository doesn't exist in codebase.

**Correction**: 
- Remove `blvm-bench` from plan OR
- Add note that it's optional/future

**Recommended**: Keep as optional, note it's for future use.

### 📝 Additional Recommendations

#### 1. AMI Versioning Strategy

**Recommendation**: Add AMI versioning/tagging strategy:
- Tag AMIs with date and version
- Keep last 3 AMIs for rollback
- Document AMI update process

#### 2. Cost Monitoring

**Recommendation**: Add CloudWatch cost monitoring:
- Set up billing alerts
- Track spot instance interruption rates
- Monitor actual vs estimated costs

#### 3. Testing Strategy

**Recommendation**: Expand testing:
- Test spot interruption handling
- Test concurrent job execution
- Test cleanup on various failure scenarios
- Load test with multiple repos

#### 4. Documentation Updates

**Recommendation**: Update existing docs:
- `blvm/ops/RUNNER_FLEET.md`: Add spot runner section
- `blvm/docs/workflows/WORKFLOW_METHODOLOGY.md`: Document spot runner usage
- Create troubleshooting guide

## Corrected Implementation Checklist

### Phase 1 Corrections
- [ ] Fix bootstrap script invocation in Packer (use flags or update script)
- [ ] Verify `machulav/ec2-github-runner` action parameters
- [ ] Update repository names to `blvm-*` format
- [ ] Pre-install GitHub Actions runner in AMI
- [ ] Fix runner label format (spaces, title case)
- [ ] Add cleanup job or verify automatic cleanup

### Phase 2 Corrections
- [ ] Update all `bllvm-*` references to `blvm-*`
- [ ] Remove or mark `blvm-bench` as optional
- [ ] Verify workflow call syntax matches existing patterns

### Phase 3 Additions
- [ ] Add AMI versioning strategy
- [ ] Add cost monitoring setup
- [ ] Expand testing to include interruption scenarios
- [ ] Update existing documentation

## Validation Conclusion

**Status**: ✅ **APPROVED WITH CORRECTIONS**

The plan is fundamentally sound and follows existing patterns correctly. The identified issues are minor and easily corrected. The architecture is appropriate for the project's needs.

**Next Steps**:
1. Apply corrections listed above
2. Verify `machulav/ec2-github-runner` action documentation
3. Test bootstrap script invocation method
4. Proceed with implementation

