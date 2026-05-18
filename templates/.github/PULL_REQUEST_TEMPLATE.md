## Summary

- What changed and why

## Checks

- [ ] Tests pass locally
- [ ] Deterministic build hashes recorded (if binaries)
- [ ] Version pins unchanged or updated intentionally
- [ ] Docs updated (RELEASE.md/SECURITY.md if relevant)
- [ ] If touching **`iroh`**, **`quinn`**, **`hickory`**, **`time`**, or related networking stacks: attach raw **`cargo audit`** output and **`cargo tree -i <crate>`** snippets for any remaining **`RUSTSEC-*`** (see **`blvm-node`** **`docs/AUDIT_SUPPRESSIONS.md`** / **`CONTRIBUTING.md`**)

## Risks

- Impact area and mitigation

## Linked issues

- Closes #
