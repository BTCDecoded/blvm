#!/usr/bin/env python3
"""Check that an AI summary only restates the aggregate.

Every bullet in the summary must contain a commit prefix that appears in the
release notes. The summary is rejected when it adds a number that the notes
do not contain.
"""

from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path

COMMIT = re.compile(r"\b[0-9a-f]{7,12}\b")
NUMBER = re.compile(r"\b\d+(?:\.\d+)?\b")


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--notes", required=True, type=Path)
    parser.add_argument("--summary", required=True, type=Path)
    args = parser.parse_args()
    notes = args.notes.read_text()
    summary = args.summary.read_text()
    if "AI-drafted" not in summary and "AI summary" not in summary:
        print("summary must say it is AI-drafted and awaiting human review")
        return 1
    failed = False
    for line in summary.splitlines():
        if not line.startswith("- "):
            continue
        shas = COMMIT.findall(line)
        if not shas:
            print(f"summary bullet has no commit id: {line}")
            failed = True
            continue
        for sha in shas:
            if sha not in notes:
                print(f"summary mentions {sha}, which is not in the notes")
                failed = True
        for number in NUMBER.findall(line):
            if number not in notes and number not in sha:
                print(f"summary number {number} is not in the notes: {line}")
                failed = True
    if failed:
        return 1
    print("summary maps onto the aggregate")
    return 0


if __name__ == "__main__":
    sys.exit(main())
