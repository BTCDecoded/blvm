#!/bin/sh
# Pack one minimal binary into artifacts/.
# Linux platforms are .tar.gz. Windows is .zip. One archive per platform.
# The archive contains the binary, minimal-hardened.toml, and SHA256SUMS.
# No governance or SDK tools.
#
# Usage: package-minimal.sh [binary] [platform]
#   platform: linux-x86_64 | linux-aarch64 | windows-x86_64
# Env:
#   VERSION_TAG            when set, the archive name includes it
#   BLVM_MINIMAL_PLATFORM  used when the platform argument is omitted
#   BLVM_MINIMAL_PROFILE   path to minimal-hardened.toml; otherwise the
#                          resolved blvm-node crate must ship that file
set -eu
cd "$(dirname "$0")/../.."

if [ "${1:-}" = "--self-test" ]; then
  tmp=$(mktemp -d)
  trap 'rm -rf "$tmp"' EXIT
  printf 'linux-bin\n' > "$tmp/linux"
  printf 'win-bin\n' > "$tmp/win"
  printf 'profile = "minimal-hardened"\n' > "$tmp/minimal-hardened.toml"
  BLVM_MINIMAL_PROFILE="$tmp/minimal-hardened.toml" \
    VERSION_TAG="v0.self-test" \
    sh "$0" "$tmp/linux" linux-x86_64 >/dev/null
  BLVM_MINIMAL_PROFILE="$tmp/minimal-hardened.toml" \
    VERSION_TAG="v0.self-test" \
    sh "$0" "$tmp/linux" linux-aarch64 >/dev/null
  BLVM_MINIMAL_PROFILE="$tmp/minimal-hardened.toml" \
    VERSION_TAG="v0.self-test" \
    sh "$0" "$tmp/win" windows-x86_64 >/dev/null
  python3 - <<'PY'
import hashlib, os, tarfile, zipfile
root = "artifacts"
tag = "v0.self-test"
checks = {
    f"{root}/blvm-minimal-{tag}-linux-x86_64.tar.gz": ["SHA256SUMS", "blvm-minimal", "minimal-hardened.toml"],
    f"{root}/blvm-minimal-{tag}-linux-aarch64.tar.gz": ["SHA256SUMS", "blvm-minimal", "minimal-hardened.toml"],
    f"{root}/blvm-minimal-{tag}-windows-x86_64.zip": ["SHA256SUMS", "blvm-minimal.exe", "minimal-hardened.toml"],
}
for path, expected in checks.items():
    if path.endswith(".tar.gz"):
        with tarfile.open(path) as arc:
            names = sorted(n.lstrip("./") for n in arc.getnames() if n not in (".", "./"))
            files = {n.lstrip("./"): arc.extractfile(n).read() for n in arc.getnames() if arc.getmember(n).isfile()}
    else:
        with zipfile.ZipFile(path) as arc:
            names = sorted(n.rstrip("/") for n in arc.namelist() if n not in (".", "./"))
            files = {n.rstrip("/"): arc.read(n) for n in arc.namelist() if not n.endswith("/")}
    if names != expected:
        raise SystemExit(f"{path} contains {names}, expected {expected}")
    lines = files["SHA256SUMS"].decode().splitlines()
    seen = []
    for line in lines:
        digest, name = line.split(None, 1)
        body = files[name]
        if hashlib.sha256(body).hexdigest() != digest:
            raise SystemExit(f"{path} checksum mismatch for {name}")
        seen.append(name)
    if sorted(seen) != [n for n in expected if n != "SHA256SUMS"]:
        raise SystemExit(f"{path} SHA256SUMS lists {seen}")
print("package-minimal self-test ok")
PY
  rm -rf artifacts/blvm-minimal-linux-x86_64 \
    artifacts/blvm-minimal-linux-aarch64 \
    artifacts/blvm-minimal-windows-x86_64
  rm -f artifacts/blvm-minimal-v0.self-test-linux-x86_64.tar.gz \
    artifacts/blvm-minimal-v0.self-test-linux-aarch64.tar.gz \
    artifacts/blvm-minimal-v0.self-test-windows-x86_64.zip \
    artifacts/SHA256SUMS-blvm-minimal-linux-x86_64 \
    artifacts/SHA256SUMS-blvm-minimal-linux-aarch64 \
    artifacts/SHA256SUMS-blvm-minimal-windows-x86_64
  exit 0
fi

bin="${1:-target/release/blvm-minimal}"
if [ -n "${2:-}" ]; then
  platform="$2"
else
  platform="${BLVM_MINIMAL_PLATFORM:-linux-x86_64}"
fi
case "$platform" in
  linux-x86_64|linux-aarch64)
    ext="tar.gz"
    packed_name="blvm-minimal"
    ;;
  windows-x86_64)
    ext="zip"
    packed_name="blvm-minimal.exe"
    ;;
  *)
    echo "unknown platform: $platform" >&2
    exit 1
    ;;
esac
if [ ! -f "$bin" ]; then
  echo "missing $bin" >&2
  exit 1
fi

art="artifacts"
stage="${art}/blvm-minimal-${platform}"
rm -rf "$stage"
mkdir -p "$stage"
cp -f "$bin" "${stage}/${packed_name}"
if [ "$ext" = "tar.gz" ]; then
  chmod 755 "${stage}/${packed_name}"
fi

if [ -n "${BLVM_MINIMAL_PROFILE:-}" ]; then
  profile="$BLVM_MINIMAL_PROFILE"
else
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
fi
if [ ! -f "$profile" ]; then
  echo "minimal-hardened.toml is missing. The resolved blvm-node crate must ship config/minimal-hardened.toml." >&2
  exit 1
fi
cp -f "$profile" "${stage}/minimal-hardened.toml"

(
  cd "$stage"
  sha256sum -- * > SHA256SUMS
)
cp "${stage}/SHA256SUMS" "${art}/SHA256SUMS-blvm-minimal-${platform}"

if [ -n "${VERSION_TAG:-}" ]; then
  archive="${art}/blvm-minimal-${VERSION_TAG}-${platform}.${ext}"
else
  archive="${art}/blvm-minimal-${platform}.${ext}"
fi
rm -f "$archive"
if [ "$ext" = "tar.gz" ]; then
  tar -czf "$archive" -C "$stage" .
else
  command -v zip >/dev/null 2>&1 || {
    echo "zip is required for the Windows minimal archive" >&2
    exit 1
  }
  (
    cd "$stage"
    zip -X -r -q "../$(basename "$archive")" .
  )
fi
echo "$archive"
