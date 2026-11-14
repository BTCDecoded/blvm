#!/bin/sh
# Pack target/release/blvm-minimal into the release artifact directory.
# The archive is the binary, the checksum, and the profile file when the
# resolved blvm-node crate still has it. No governance or SDK tools.
set -eu
cd "$(dirname "$0")/../.."

bin="${1:-target/release/blvm-minimal}"
platform="${BLVM_MINIMAL_PLATFORM:-linux-x86_64}"
if [ ! -f "$bin" ]; then
  echo "missing $bin" >&2
  exit 1
fi

art="artifacts"
stage="${art}/blvm-minimal-${platform}"
mkdir -p "$stage"
cp -f "$bin" "${stage}/blvm-minimal"
chmod 755 "${stage}/blvm-minimal"

profile="$(python3 - <<'PY'
import json, os, subprocess, sys
try:
    raw = subprocess.check_output(
        ["cargo", "metadata", "--format-version", "1", "--locked"],
        stderr=subprocess.DEVNULL,
    )
except subprocess.CalledProcessError:
    sys.exit(0)
meta = json.loads(raw)
for pkg in meta["packages"]:
    if pkg["name"] != "blvm-node":
        continue
    path = os.path.join(os.path.dirname(pkg["manifest_path"]), "config", "minimal-hardened.toml")
    if os.path.isfile(path):
        print(path)
    break
PY
)"
if [ -n "$profile" ]; then
  cp -f "$profile" "${stage}/minimal-hardened.toml"
fi

(
  cd "$stage"
  sha256sum -- * > "../SHA256SUMS-blvm-minimal-${platform}"
)
cp "${art}/SHA256SUMS-blvm-minimal-${platform}" "$stage/"
tar -czf "${art}/blvm-minimal-${platform}.tar.gz" -C "$stage" .
echo "${art}/blvm-minimal-${platform}.tar.gz"
