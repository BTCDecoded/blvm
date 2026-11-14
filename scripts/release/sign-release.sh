#!/bin/sh
# Sign SHA256SUMS and SPEC_LOCK_ATTESTATION.
# The attestation binds those checksums to one spec-lock run. Signing it
# attests that the named checker verified the named spec for those bytes.
# Create a signed tag only when BLVM_SIGN_TAG is set.
# Never pushes. Exits 2 when no signing key is configured or a file is missing.
set -eu
file="${1:-SHA256SUMS}"
attestation="$(dirname "$file")/SPEC_LOCK_ATTESTATION"
if [ ! -f "$file" ]; then
  echo "missing $file"
  exit 2
fi
if [ ! -f "$attestation" ]; then
  echo "missing $attestation. Refusing to sign a release that has no spec-lock attestation."
  exit 2
fi
if ! git config --get user.signingkey >/dev/null 2>&1; then
  echo "no user.signingkey is configured. Refusing to sign."
  exit 2
fi
if [ -n "${BLVM_SIGN_TAG:-}" ]; then
  git tag -s "$BLVM_SIGN_TAG" -m "$BLVM_SIGN_TAG"
fi
gpg --detach-sign --armor --output "$file.asc" "$file"
gpg --detach-sign --armor --output "$attestation.asc" "$attestation"
echo "signed $file"
echo "signed $attestation"
