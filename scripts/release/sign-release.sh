#!/bin/sh
# Sign SHA256SUMS. Create a signed tag only when BLVM_SIGN_TAG is set.
# Never pushes. Exits 2 when no signing key is configured or the file is missing.
set -eu
file="${1:-SHA256SUMS}"
if [ ! -f "$file" ]; then
  echo "missing $file"
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
echo "signed $file"
