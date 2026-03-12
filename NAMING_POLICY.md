# Naming and Tags Policy

## Repo Tags
- Use semantic versions: `vX.Y.Z` (e.g., `v0.1.0`).
- Tags must be immutable once referenced by a release set.

## Release Set ID
- Add a human-friendly set ID in `commons/versions.toml`, e.g., `set-2025-01A`.
- Reference this ID in release notes and attestations.

## Example
```
[release_set]
id = "set-2025-01A"

[versions]
blvm-consensus = "v0.1.0-locked"
blvm-protocol  = "v0.1.0"
blvm-node   = "v0.1.0"
blvm-sdk    = "v0.1.0"
blvm-commons   = "v0.1.0"
```
