#!/usr/bin/env python3
"""Update [versions.develop] in blvm/versions.toml after a successful develop publish."""
from __future__ import annotations

import argparse
import re
from datetime import datetime, timezone
from pathlib import Path

DEPS = ("blvm-consensus", "blvm-protocol", "blvm-node", "blvm-sdk")


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--version", required=True)
    parser.add_argument("--based-on-stable", required=True)
    parser.add_argument("--versions-toml", type=Path, required=True)
    parser.add_argument("--git-sha", default="")
    args = parser.parse_args()

    v = args.version
    m = re.fullmatch(r"(\d+\.\d+\.\d+-dev)\.\d+", v)
    if not m:
        raise SystemExit(f"invalid develop version: {v}")
    prefix = m.group(1)
    now = datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")

    dep_lines = "\n".join(f'{c} = "={v}"' for c in DEPS)
    block = f"""[versions.develop]
version = "{v}"
based_on_stable = "{args.based_on_stable}"
dev_prefix = "{prefix}"
published_at = "{now}"
git_sha = "{args.git_sha}"

[versions.develop.dependencies]
{dep_lines}
"""

    path = args.versions_toml
    text = path.read_text(encoding="utf-8")
    pattern = r"\[versions\.develop\].*?(?=\n\[metadata\])"
    if not re.search(pattern, text, flags=re.DOTALL):
        raise SystemExit(f"could not find [versions.develop] before [metadata] in {path}")
    new_text = re.sub(pattern, block.rstrip() + "\n", text, count=1, flags=re.DOTALL)
    path.write_text(new_text, encoding="utf-8")
    print(f"updated {path} → develop {v}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
