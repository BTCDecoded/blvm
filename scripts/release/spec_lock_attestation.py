#!/usr/bin/env python3
"""Write the spec-lock attestation that a release signature covers.

The consensus spec-lock job records the checker version, the spec revision,
and the verify JSON. This script binds that record to the release checksums.
``sign-release.sh`` signs the result. The signature is the statement that
this checker verified this spec for these bytes.

The script does not sign anything and does not claim a signature exists.
"""

from __future__ import annotations

import argparse
import hashlib
import re
import sys
import tempfile
from pathlib import Path

REQUIRED = (
    "spec_lock_tool_version",
    "spec_meta_json_version",
    "spec_lock_spec_git_sha",
    "spec_content_sha256",
)
CHECKSUM_LINE = re.compile(r"^[0-9a-fA-F]{64}\s+\S+$")


def read_meta(path: Path) -> dict[str, str]:
    values: dict[str, str] = {}
    for raw in path.read_text(encoding="utf-8").splitlines():
        line = raw.strip()
        if not line or line.startswith("#") or "=" not in line:
            continue
        key, value = line.split("=", 1)
        if "\n" in value or "\r" in value:
            raise ValueError(f"{key} contains a newline")
        values[key.strip()] = value.strip()
    missing = [key for key in REQUIRED if not values.get(key)]
    if missing:
        raise ValueError("meta env is missing " + ", ".join(missing))
    return values


def read_checksums(path: Path) -> list[str]:
    lines = []
    for raw in path.read_text(encoding="utf-8").splitlines():
        line = raw.strip()
        if not line or line.startswith("#"):
            continue
        if not CHECKSUM_LINE.match(line):
            raise ValueError(f"checksum line is not a sha256 record: {line}")
        lines.append(line)
    if not lines:
        raise ValueError(f"{path} has no checksums")
    return lines


def render(meta: dict[str, str], verify_json: Path, checksums: list[str]) -> str:
    digest = hashlib.sha256(verify_json.read_bytes()).hexdigest()
    content = meta["spec_content_sha256"]
    if len(content) != 64 or any(ch not in "0123456789abcdef" for ch in content.lower()):
        raise ValueError("spec_content_sha256 is not a sha256 hex digest")
    body = [
        "# BLVM spec-lock attestation",
        "# A signature over this file attests that the named checker verified",
        "# the named spec bytes for the binaries listed below.",
        f"spec_lock_tool_version={meta['spec_lock_tool_version']}",
        f"spec_version={meta['spec_meta_json_version']}",
        f"spec_lock_spec_git_sha={meta['spec_lock_spec_git_sha']}",
        f"spec_content_sha256={content.lower()}",
        f"spec_lock_verify_json_sha256={digest}",
        "# checksums",
        *checksums,
        "",
    ]
    return "\n".join(body)


def write_attestation(meta_path: Path, verify_json: Path, checksums: Path, output: Path) -> None:
    if not meta_path.is_file():
        raise ValueError(f"missing {meta_path}")
    if not verify_json.is_file():
        raise ValueError(f"missing {verify_json}")
    if not checksums.is_file():
        raise ValueError(f"missing {checksums}")
    text = render(read_meta(meta_path), verify_json, read_checksums(checksums))
    output.write_text(text, encoding="utf-8")


def self_test() -> int:
    with tempfile.TemporaryDirectory(prefix="blvm-spec-lock-attestation-") as temporary:
        root = Path(temporary)
        meta = root / "spec_lock_verify_meta.env"
        verify = root / "spec_lock_verify.json"
        sums = root / "SHA256SUMS"
        output = root / "SPEC_LOCK_ATTESTATION"
        meta.write_text(
            "\n".join(
                [
                    "spec_lock_tool_version=0.1.57",
                    "spec_lock_spec_git_sha=afc5b491282ce2da12e5c177745711bcd5c118a0",
                    "spec_meta_json_version=0.0.0-dev+afc5b49",
                    "spec_content_sha256=a9a3df922f1910d6ffc547166bc522a33720b4823bc34e28f95edd004dec3ba2",
                    "",
                ]
            ),
            encoding="utf-8",
        )
        verify.write_text('{"summary":{"passed":1}}\n', encoding="utf-8")
        binary_line = "720564b0728826b2a15367be7ab91c81425e6265c9800453be2c990c71a739dc  blvm-minimal"
        sums.write_text(binary_line + "\n", encoding="utf-8")
        write_attestation(meta, verify, sums, output)
        text = output.read_text(encoding="utf-8")
        expected = hashlib.sha256(verify.read_bytes()).hexdigest()
        assert "spec_lock_tool_version=0.1.57" in text
        assert "spec_version=0.0.0-dev+afc5b49" in text
        assert "spec_lock_spec_git_sha=afc5b491282ce2da12e5c177745711bcd5c118a0" in text
        assert (
            "spec_content_sha256=a9a3df922f1910d6ffc547166bc522a33720b4823bc34e28f95edd004dec3ba2"
            in text
        )
        assert f"spec_lock_verify_json_sha256={expected}" in text
        assert binary_line in text
        assert not output.with_suffix(output.suffix + ".asc").exists()
        broken = root / "broken.env"
        broken.write_text("spec_lock_tool_version=0.1.57\n", encoding="utf-8")
        try:
            write_attestation(broken, verify, sums, output)
        except ValueError as err:
            assert "spec_lock_spec_git_sha" in str(err)
        else:
            raise AssertionError("missing spec sha was accepted")
    print("spec-lock attestation self-test passed")
    return 0


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--meta", type=Path, default=Path("spec_lock_verify_meta.env"))
    parser.add_argument("--verify-json", type=Path, default=Path("spec_lock_verify.json"))
    parser.add_argument("--checksums", type=Path, default=Path("SHA256SUMS"))
    parser.add_argument("--output", type=Path, default=Path("SPEC_LOCK_ATTESTATION"))
    parser.add_argument("--self-test", action="store_true")
    args = parser.parse_args()
    if args.self_test:
        return self_test()
    try:
        write_attestation(args.meta, args.verify_json, args.checksums, args.output)
    except ValueError as err:
        print(f"spec-lock attestation: {err}", file=sys.stderr)
        return 2
    print(f"wrote {args.output}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
