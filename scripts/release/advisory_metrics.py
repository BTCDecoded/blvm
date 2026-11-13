#!/usr/bin/env python3
"""Build the advisory index and the public metrics summary.

Corrections are new files. This script only reads the directory.
"""

from __future__ import annotations

import json
import statistics
from datetime import datetime
from pathlib import Path

ROOT = Path("/mnt/data/bitcoin/blvm/docs/security")
ADVISORIES = ROOT / "advisories"


def parse_time(value: str | None) -> datetime | None:
    if not value:
        return None
    text = value.replace("Z", "+00:00")
    return datetime.fromisoformat(text)


def hours(start: datetime | None, end: datetime | None) -> float | None:
    if start is None or end is None:
        return None
    return (end - start).total_seconds() / 3600


def main() -> None:
    records = []
    for path in sorted(ADVISORIES.glob("BLVM-*.json")):
        records.append(json.loads(path.read_text()))
    by_severity: dict[str, int] = {}
    report_to_fix = []
    fix_to_release = []
    open_count = 0
    closed_count = 0
    index = [
        "# Advisory index",
        "",
        "This directory is append-only. A correction is a new file that names the",
        "earlier id. Do not edit a published advisory. Files are not signed yet:",
        "this machine has no `user.signingkey`.",
        "",
        "| ID | Severity | State | Crate | Fixed | Fix commit |",
        "| --- | --- | --- | --- | --- | --- |",
    ]
    for record in records:
        extra = record["database_specific"]
        severity = extra["blvm_severity"]
        by_severity[severity] = by_severity.get(severity, 0) + 1
        state = extra["state"]
        if state == "open":
            open_count += 1
        else:
            closed_count += 1
        report_to_fix.append(hours(parse_time(extra.get("report_date")), parse_time(extra.get("fix_date"))))
        fix_to_release.append(hours(parse_time(extra.get("fix_date")), parse_time(extra.get("release_date"))))
        crate = extra["blvm_crates"][0]
        fixed = extra.get("fixed_version") or ""
        commit = (extra.get("fix_commit") or "")[:12]
        index.append(
            f"| [{record['id']}]({record['id']}.json) | {severity} | {state} | {crate} | {fixed} | {commit} |"
        )

    def median(values: list[float | None]) -> str:
        usable = [value for value in values if value is not None]
        if not usable:
            return "not computed (report dates are unset)"
        return f"{statistics.median(usable):.1f} hours (n={len(usable)})"

    index.append("")
    (ADVISORIES / "INDEX.md").write_text("\n".join(index) + "\n")
    summary = [
        "# Security metrics",
        "",
        "Generated from `docs/security/advisories`. A report date is set only when",
        "the discovery time was recorded. Fix-to-release uses the commit timestamp",
        "and the tag timestamp. An entry with no release date stays out of that median.",
        "",
        f"- Advisories: {len(records)}",
        f"- Open: {open_count}",
        f"- Closed: {closed_count}",
        "- By severity:",
    ]
    for name in sorted(by_severity):
        summary.append(f"  - {name}: {by_severity[name]}")
    summary.append(f"- Median report to fix: {median(report_to_fix)}")
    summary.append(f"- Median fix to release: {median(fix_to_release)}")
    summary.append("")
    (ROOT / "METRICS.md").write_text("\n".join(summary) + "\n")
    print(ADVISORIES / "INDEX.md")
    print(ROOT / "METRICS.md")


if __name__ == "__main__":
    main()
