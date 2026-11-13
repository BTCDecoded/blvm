#!/usr/bin/env python3
"""Write the initial advisory record. Refuses to overwrite an existing id."""

from __future__ import annotations

import json
import subprocess
from pathlib import Path

OUT = Path("/mnt/data/bitcoin/blvm/docs/security/advisories")


def tag_date(repo: str, tag: str) -> str:
    return subprocess.check_output(
        ["git", "-C", repo, "for-each-ref", f"refs/tags/{tag}", "--format=%(creatordate:iso)"],
        text=True,
    ).strip()


def advisory(**kwargs: object) -> dict:
    return kwargs


def main() -> None:
    OUT.mkdir(parents=True, exist_ok=True)
    node = "/mnt/data/bitcoin/blvm/blvm-node"
    consensus = "/mnt/data/bitcoin/blvm/blvm-consensus"
    v80 = tag_date(consensus, "v0.1.80")
    v88 = tag_date(node, "v0.1.88")
    v92 = tag_date(node, "v0.1.92")
    records = [
        base(
            "BLVM-2026-0001",
            "consensus",
            "An overflowing output sum was an internal error instead of an invalid block",
            "connect_block returned an internal error for a block whose output sum overflowed. "
            "The fix classifies that block as invalid. Callers that treated the internal error "
            "as a retry or a crash could disagree with a caller that rejected the block.",
            "blvm-consensus",
            "0.1.80",
            "e58e0ad2003a0474d0bb7d9751af29f6b426d3c1",
            "2026-11-07T19:45:25-05:00",
            v80,
            "https://github.com/BTCDecoded/blvm-consensus/commit/e58e0ad2003a0474d0bb7d9751af29f6b426d3c1",
        ),
        base(
            "BLVM-2026-0002",
            "consensus",
            "A failed reorg left the coin set rewound",
            "A failed attempt to activate a heavier fork left the coin set rewound. "
            "The same fix restores those coins on startup and bounds a package transaction count "
            "that was allocated before it was checked. Peer address selection no longer follows "
            "that peer for outbound queues.",
            "blvm-node",
            "0.1.92",
            "76f2b437ceed005da0d5b26365b06e952e6d4cc8",
            "2026-11-11T02:01:05-05:00",
            v92,
            "https://github.com/BTCDecoded/blvm-node/commit/76f2b437ceed005da0d5b26365b06e952e6d4cc8",
        ),
        base(
            "BLVM-2026-0003",
            "resource exhaustion",
            "Inbound TCP connections were not capped per address",
            "The node now caps inbound TCP connections at three per address. "
            "Before that cap, one address could open more connections than the intake bound.",
            "blvm-node",
            "0.1.88",
            "ca0b77e3e9f016d06113590896a667b55a925efd",
            "2026-11-06T11:10:37-05:00",
            v88,
            "https://github.com/BTCDecoded/blvm-node/commit/ca0b77e3e9f016d06113590896a667b55a925efd",
        ),
        base(
            "BLVM-2026-0004",
            "local-only",
            "Module processes were not confined",
            "The node confines module processes and closes the trust gaps named in the fixing commit. "
            "The public commit message is the description. No reporter notes were available.",
            "blvm-node",
            "0.1.88",
            "6230a225e2592211be4f1a32395441a4844f7808",
            "2026-11-06T12:14:27-05:00",
            v88,
            "https://github.com/BTCDecoded/blvm-node/commit/6230a225e2592211be4f1a32395441a4844f7808",
        ),
    ]
    opens = [
        ("BLVM-2026-0101", "RUSTSEC-2026-0118", "resource exhaustion", "hickory-proto",
         "NSEC3 closest-encloser validation can loop. The edge is iroh 0.95 pulling hickory 0.25. No 0.25 patch is published."),
        ("BLVM-2026-0102", "RUSTSEC-2026-0119", "resource exhaustion", "hickory-proto",
         "Name compression is quadratic during encode. Patched in hickory-proto >= 0.26.1, which the iroh 0.95 pin does not allow."),
        ("BLVM-2026-0103", "RUSTSEC-2026-0338", "remote crash", "quinn-proto",
         "A zero-length STREAM frame can panic during unordered reads. Patched in quinn-proto >= 0.11.18. That line does not resolve next to iroh 0.95."),
        ("BLVM-2026-0104", "RUSTSEC-2026-0339", "resource exhaustion", "quinn-proto",
         "Pending connection-id retirements are unbounded. Patched in quinn-proto >= 0.11.17, which does not resolve next to iroh 0.95."),
        ("BLVM-2026-0105", "RUSTSEC-2026-0340", "remote crash", "quinn-proto",
         "A peer minimum ACK delay can panic with ACK_FREQUENCY. Patched in quinn-proto >= 0.11.18, which does not resolve next to iroh 0.95."),
        ("BLVM-2026-0106", "RUSTSEC-2026-0341", "resource exhaustion", "quinn-proto",
         "A stream reassembly memory guard can be bypassed. Patched in quinn-proto >= 0.11.17, which does not resolve next to iroh 0.95."),
        ("BLVM-2026-0107", "RUSTSEC-2026-0342", "resource exhaustion", "quinn-proto",
         "A zero-length DATAGRAM frame can bypass the receive buffer limit. Patched in quinn-proto >= 0.11.17, which does not resolve next to iroh 0.95."),
        ("BLVM-2026-0108", "RUSTSEC-2026-0424", "remote crash", "wasmtime",
         "wasmtime 36.0.19 is in the tree through blvm-sdk. The published fix is wasmtime >= 36.0.20. The default blvm binary does not enable the wasm-modules feature."),
    ]
    for ident, rustsec, severity, crate, details in opens:
        records.append(
            {
                "schema_version": "1.6.0",
                "id": ident,
                "modified": "2026-11-12T00:00:00Z",
                "published": "2026-11-12T00:00:00Z",
                "summary": f"{rustsec} still applies to the dependency tree",
                "details": details + " Reporter credit is pending consent. This entry was reconstructed from the cargo audit ignore list, not from a private report.",
                "affected": [
                    {
                        "package": {"ecosystem": "crates.io", "name": crate},
                        "ranges": [{"type": "SEMVER", "events": [{"introduced": "0"}]}],
                    }
                ],
                "references": [
                    {"type": "ADVISORY", "url": f"https://rustsec.org/advisories/{rustsec}"}
                ],
                "database_specific": {
                    "blvm_severity": severity,
                    "rustsec": rustsec,
                    "state": "open",
                    "report_date": None,
                    "fix_date": None,
                    "release_date": None,
                    "disclosure_date": None,
                    "fix_commit": None,
                    "fixed_version": None,
                    "reporter": None,
                    "reporter_consent": "pending",
                    "blvm_crates": ["blvm", "blvm-node"],
                },
            }
        )
    for record in records:
        path = OUT / f"{record['id']}.json"
        if path.exists():
            raise SystemExit(f"refusing to overwrite {path}")
        path.write_text(json.dumps(record, indent=2) + "\n")
        print(path)


def base(ident, severity, summary, details, crate, fixed, commit, fix_date, release_date, url):
    return {
        "schema_version": "1.6.0",
        "id": ident,
        "modified": release_date,
        "published": release_date,
        "summary": summary,
        "details": details + " Reporter credit is blank pending consent. The report date was not in the commit or the tag.",
        "affected": [
            {
                "package": {"ecosystem": "crates.io", "name": crate},
                "ranges": [
                    {
                        "type": "SEMVER",
                        "events": [{"introduced": "0"}, {"fixed": fixed}],
                    }
                ],
            }
        ],
        "references": [{"type": "FIX", "url": url}],
        "database_specific": {
            "blvm_severity": severity,
            "state": "closed",
            "report_date": None,
            "fix_date": fix_date,
            "release_date": release_date,
            "disclosure_date": release_date,
            "fix_commit": commit,
            "fixed_version": fixed,
            "release": fixed,
            "reporter": None,
            "reporter_consent": "pending",
            "blvm_crates": [crate],
        },
    }


if __name__ == "__main__":
    main()
