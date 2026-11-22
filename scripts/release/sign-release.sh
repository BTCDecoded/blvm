#!/bin/sh
# Sign SHA256SUMS and SPEC_LOCK_ATTESTATION for a project release.
#
# The attestation binds those checksums to one spec-lock run. Signing it
# attests that the named checker verified the named spec for those bytes.
#
# Order: detach-sign the two files first, then create a signed tag when
# BLVM_SIGN_TAG is set, so one pinentry unlock covers the whole step.
#
# Never pushes. Exits 2 when no signing key is configured or a file is missing.
# Exits 1 when gpg writes an empty .asc (do not upload that).
#
# On a machine with no tty (Cursor agent sessions), use sign-release-gui.sh
# instead so pinentry-gtk can prompt on DISPLAY.
set -eu

file="${1:-SHA256SUMS}"
attestation="$(dirname "$file")/SPEC_LOCK_ATTESTATION"
key="$(git config --get user.signingkey || true)"

if [ ! -f "$file" ]; then
  echo "missing $file" >&2
  exit 2
fi
if [ ! -f "$attestation" ]; then
  echo "missing $attestation. Refusing to sign a release that has no spec-lock attestation." >&2
  exit 2
fi
if [ -z "$key" ]; then
  echo "no user.signingkey is configured. Refusing to sign." >&2
  exit 2
fi

sign_one() {
  src="$1"
  out="$2"
  rm -f "$out"
  gpg --detach-sign --armor --local-user "$key" --output "$out" "$src"
  if [ ! -s "$out" ]; then
    rm -f "$out"
    echo "refusing empty $out" >&2
    exit 1
  fi
  echo "signed $src -> $out"
}

sign_one "$file" "$file.asc"
sign_one "$attestation" "$attestation.asc"

if [ -n "${BLVM_SIGN_TAG:-}" ]; then
  # Tag last: the PIN cache from the detaches should still be warm.
  git tag -s "$BLVM_SIGN_TAG" -u "$key" -m "$BLVM_SIGN_TAG"
  echo "signed tag $BLVM_SIGN_TAG"
fi
