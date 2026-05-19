# Develop channel — go-live checklist

Operator steps to turn on the **`develop`** integration channel after merging CI/scripts to **`main`** (then sync **`develop`**).

Full design: [DEVELOP_CHANNEL_PLAN.md](DEVELOP_CHANNEL_PLAN.md).

---

## 1. GitHub branches

Create **`develop`** from **`main`** on each repo that participates in publish/nightly:

| Repo | Required for |
|------|----------------|
| [BTCDecoded/blvm](https://github.com/BTCDecoded/blvm) | `publish-develop-set`, `nightly-release`, GHCR `:nightly` |
| [BTCDecoded/blvm-consensus](https://github.com/BTCDecoded/blvm-consensus) | `publish-dev` (chain start) |
| [BTCDecoded/blvm-protocol](https://github.com/BTCDecoded/blvm-protocol) | `publish-dev` |
| [BTCDecoded/blvm-node](https://github.com/BTCDecoded/blvm-node) | `publish-dev` |
| [BTCDecoded/blvm-sdk](https://github.com/BTCDecoded/blvm-sdk) | `publish-dev` (macros + sdk) |

**Workspace helper** (from multi-repo checkout root):

```bash
chmod +x scripts/bootstrap-develop-branches.sh
./scripts/bootstrap-develop-branches.sh --dry-run   # preview
./scripts/bootstrap-develop-branches.sh           # create + push develop
```

Manual loop:

```bash
for repo in blvm blvm-consensus blvm-protocol blvm-node blvm-sdk; do
  git -C "$repo" checkout main && git pull
  git -C "$repo" checkout -b develop 2>/dev/null || git -C "$repo" checkout develop
  git -C "$repo" merge main   # or rebase policy
  git -C "$repo" push -u origin develop
done
```

## 2. Secrets (org or per-repo)

| Secret | Used for |
|--------|----------|
| `CARGO_REGISTRY_TOKEN` | `publish-dev`, `publish-develop-set` |
| `REPO_ACCESS_TOKEN` | `develop-chain` `repository_dispatch` between repos |
| `GITHUB_TOKEN` | Nightly GitHub Release (automatic) |

## 3. Branch protection (recommended)

| Branch | Required checks |
|--------|-----------------|
| `develop` | CI gates (`test`, `clippy`, `verify`, …) — **not** `publish-dev` / `nightly-release` on PRs |
| `main` | Same + stable `release` policy per team |

## 4. First push smoke test

1. Push an empty commit to **`develop`** on **`blvm-consensus`** (or merge a small PR).
2. Confirm **`publish-dev`** publishes `blvm-consensus` at **`V`** = `0.1.(patch+1)-dev.1` (see Actions log).
3. Confirm chain: protocol → node → sdk → **`blvm`** `develop-chain` dispatch.
4. On **`blvm`**, confirm **`publish-develop-set`** → **`nightly-release`** → **`docker-ghcr-nightly`**.
5. Verify:
   - `curl -sfI https://github.com/BTCDecoded/blvm/releases/download/nightly/blvm-nightly-linux-x86_64`
   - `docker pull ghcr.io/btcdecoded/blvm:nightly`
   - `cargo search blvm-consensus --limit 1` shows latest **`-dev.`** build

## 5. Manual recovery

**Actions → CI → Run workflow** on **`blvm`** (`workflow_dispatch`):

| Input | Purpose |
|-------|---------|
| `force_version` | Pin coordinated **V** (e.g. `0.1.22-dev.3`) instead of computing |
| `skip_publish_dev` | Skip crates.io publish; only wait for **V** on index + nightly |
| `skip_tests` | Skip gates (emergency only) |

Or dispatch from API:

```bash
gh api repos/BTCDecoded/blvm/dispatches -f event_type=develop-chain \
  -f client_payload[version]=0.1.22-dev.3
```

## 6. Skip tokens (push commits)

| Token | Effect |
|-------|--------|
| `[skip_release]` | No stable `release` (main) or develop publish/nightly |
| `[skip_publish_dev]` | No crates.io develop publish; nightly still waits for index **V** |
| `[skip_docker]` | No GHCR push |
| `[skip ci]` | Skip entire workflow |

## 7. Local scripts

From workspace root:

```bash
./scripts/develop-channel-smoke-local.sh
```

From `blvm/` checkout:

```bash
./scripts/compute-develop-version.sh
./scripts/compute-develop-version.sh --force-version 0.1.22-dev.2
./scripts/resolve-develop-registry-deps.sh --mode resolve Cargo.toml
```

## 8. Metadata

After a successful **`publish-develop-set`**, CI may commit **`versions.toml`** `[versions.develop]` (when `REPO_ACCESS_TOKEN` is set). Informational only; crates.io index is authoritative at build time.

---

## Troubleshooting

| Symptom | Likely cause |
|---------|----------------|
| `publish-develop-set` fails at wait | Prior crate not published; check upstream `publish-dev` job |
| Nightly builds stable deps | `publish-develop-set` failed or `CARGO_REGISTRY_TOKEN` missing |
| PR to `develop` publishes | Should not — check job `if:` includes `github.event_name == 'push'` |
| Script checkout fails | **`develop`** on `blvm` missing; scripts fall back to **`main`** |
