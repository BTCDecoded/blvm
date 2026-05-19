#!/usr/bin/env bash
# Create and push `develop` from `main` for coordinated develop-channel repos.
# Run from the multi-repo workspace root (parent of blvm/, blvm-consensus/, …).
set -euo pipefail

ORG="${BLVM_GITHUB_ORG:-BTCDecoded}"
REPOS=(blvm blvm-consensus blvm-protocol blvm-node blvm-sdk)
DRY_RUN=0
PUSH=1
USE_GH_API=0

usage() {
  echo "Usage: $0 [--dry-run] [--no-push] [--github-api] [REPO ...]" >&2
  echo "  --github-api  Create/update origin/develop via gh API from remote main (no local git)." >&2
  echo "Default repos: ${REPOS[*]}" >&2
  exit 1
}

while [ $# -gt 0 ]; do
  case "$1" in
    --dry-run) DRY_RUN=1; shift ;;
    --no-push) PUSH=0; shift ;;
    --github-api) USE_GH_API=1; shift ;;
    -h|--help) usage ;;
    -*) usage ;;
    *) REPOS=("$@"); break ;;
  esac
done

create_remote_develop() {
  local repo="$1"
  local sha base
  base="main"
  if ! gh api "repos/${ORG}/${repo}/git/ref/heads/main" --jq .object.sha &>/dev/null; then
    base="master"
  fi
  sha="$(gh api "repos/${ORG}/${repo}/git/ref/heads/${base}" --jq .object.sha)"
  if gh api "repos/${ORG}/${repo}/git/ref/heads/develop" &>/dev/null; then
    echo "  update develop → ${sha:0:7} (was behind ${base})"
    if [ "${DRY_RUN}" -eq 1 ]; then
      echo "  [dry-run] would PATCH refs/heads/develop"
      return 0
    fi
    gh api -X PATCH "repos/${ORG}/${repo}/git/refs/heads/develop" \
      -f sha="${sha}" >/dev/null
  else
    echo "  create develop @ ${sha:0:7} from ${base}"
    if [ "${DRY_RUN}" -eq 1 ]; then
      echo "  [dry-run] would POST refs/heads/develop"
      return 0
    fi
    gh api "repos/${ORG}/${repo}/git/refs" \
      -f ref="refs/heads/develop" \
      -f sha="${sha}" >/dev/null
  fi
  echo "  ✅ ${ORG}/${repo} develop"
}

if [ "${USE_GH_API}" -eq 1 ]; then
  command -v gh >/dev/null || { echo "gh required"; exit 1; }
  for repo in "${REPOS[@]}"; do
    echo "── ${ORG}/${repo} (GitHub API) ──"
    create_remote_develop "${repo}" || echo "  ⚠️  failed ${repo}"
  done
  echo "Done (GitHub API). Merge develop-channel work into develop on each repo."
  exit 0
fi

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

for repo in "${REPOS[@]}"; do
  dir="${ROOT}/${repo}"
  if [ ! -d "${dir}/.git" ]; then
    echo "⚠️  skip ${repo}: no git checkout at ${dir}"
    continue
  fi
  echo "── ${ORG}/${repo} ──"
  (
    cd "${dir}"
    git fetch origin main 2>/dev/null || git fetch origin master 2>/dev/null || true
    base="main"
    git show-ref --verify --quiet refs/remotes/origin/main || base="master"
    if git show-ref --verify --quiet refs/heads/develop; then
      echo "  local develop exists"
      git checkout develop
      git merge "origin/${base}" -m "merge: sync develop with ${base}" || true
    else
      echo "  create develop from origin/${base}"
    git checkout "${base}"
    if [ -z "$(git status --porcelain)" ]; then
      git pull origin "${base}" || true
    else
      echo "  (skip pull: working tree dirty — commit or stash first)"
    fi
    git checkout -b develop 2>/dev/null || git checkout develop
    fi
    if [ "${PUSH}" -eq 1 ]; then
      if [ "${DRY_RUN}" -eq 1 ]; then
        echo "  [dry-run] would: git push -u origin develop"
      else
        git push -u origin develop
        echo "  ✅ pushed develop"
      fi
    fi
  )
done

echo "Done. Next: set CARGO_REGISTRY_TOKEN + REPO_ACCESS_TOKEN; see docs/DEVELOP_CHANNEL_GO_LIVE.md"
