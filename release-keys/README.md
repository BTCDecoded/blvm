# Release keys

Maintainers sign each release's verification bundle after rebuilding the static musl binaries from the tag and getting the same hashes as CI. `policy.json` lists whose signatures count and how many are required. `scripts/verify-release.sh` reads this file from your local checkout, not from the release, so the trust root is the copy you already have.

## Enroll a maintainer

1. Generate a key with `blvm-keygen` (blvm-sdk). Keep the secret key file offline.
2. Write the public half to `release-keys/<name>.pub.json`.

   ```bash
   jq '{public_key}' my-key.json > release-keys/<name>.pub.json
   ```

3. Add `{"name": "<name>", "public_key_file": "<name>.pub.json"}` to `maintainers` in `policy.json` and set `threshold`.
4. Merge through the normal review process. A change to this directory changes who can approve releases.

## What a signature covers

`blvm-sign-binary bundle` signs this message.

```
bundle:<sha256 of blvm-<tag>-verification-bundle.tar.gz>:<source_hash>:<build_config_hash>:<spec_hash>
```

The bundle holds `attestation.json` (every release file's sha256, the commit, the CI gate results), `build-config.json`, `checksums.sha256`, and the spec-lock report for the linked `blvm-consensus`. The `spec_hash` pins the exact spec text that report was checked against. A signature therefore says that this maintainer rebuilt the musl binaries from that source with that build config, got matching hashes, and accepts the recorded spec-lock result. A passing spec-lock result is not a proof of conformance, so read the counts in `attestation.json`.
