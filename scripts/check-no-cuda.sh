#!/usr/bin/env bash
# Fail if a release artifact needs the CUDA runtime to load.
#
# Usage: scripts/check-no-cuda.sh FILE...
#   FILE may be an ELF binary, a .deb, or a .tar.gz / .tgz archive. Every ELF inside
#   a package is checked. Non-ELF files are skipped.
#
# blvm 0.1.63 and 0.1.64 shipped x86_64 binaries with libcudart.so.13 in NEEDED and
# no package dependency on it, so they exited 127 on any machine without CUDA.
set -euo pipefail

if [ "$#" -eq 0 ]; then
  echo "usage: $0 FILE..." >&2
  exit 2
fi

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT
bad=0
checked=0

check_elf() {
  local f="$1" label="$2"
  head -c 4 "$f" 2>/dev/null | grep -q $'\x7fELF' || return 0
  checked=$((checked + 1))
  local needed
  needed="$(readelf -d "$f" 2>/dev/null | awk '/\(NEEDED\)/ {print $NF}' | tr -d '[]')"
  if printf '%s\n' "$needed" | grep -Eq '^lib(cudart|cuda|cublas|nvrtc)\.so'; then
    echo "FAIL $label needs: $(printf '%s\n' "$needed" | grep -E '^lib(cudart|cuda|cublas|nvrtc)\.so' | tr '\n' ' ')" >&2
    bad=1
  else
    echo "ok   $label"
  fi
}

for a in "$@"; do
  case "$a" in
    *.deb)
      d="$tmp/$(basename "$a").x"
      mkdir -p "$d"
      dpkg-deb -x "$a" "$d"
      while IFS= read -r -d '' f; do check_elf "$f" "$a:${f#"$d"}"; done < <(find "$d" -type f -print0)
      ;;
    *.tar.gz | *.tgz)
      d="$tmp/$(basename "$a").x"
      mkdir -p "$d"
      tar -xzf "$a" -C "$d"
      while IFS= read -r -d '' f; do check_elf "$f" "$a:${f#"$d"}"; done < <(find "$d" -type f -print0)
      ;;
    *)
      check_elf "$a" "$a"
      ;;
  esac
done

if [ "$checked" -eq 0 ]; then
  echo "FAIL no ELF files found in: $*" >&2
  exit 1
fi
exit "$bad"
