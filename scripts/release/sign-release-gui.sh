#!/bin/bash
# Interactive signing for agent-assisted release ceremonies.
#
# Cursor / CI shells are not a tty. pinentry-curses cannot prompt there.
# This wrapper temporarily points gpg-agent at pinentry-gtk (or
# BLVM_PINENTRY), kills the agent so the change takes effect, runs
# sign-release.sh, and ALWAYS restores pinentry-curses afterward.
#
# Usage (from the release artifact directory that holds SHA256SUMS):
#   DISPLAY=:1 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$UID/bus \
#     bash /path/to/blvm/scripts/release/sign-release-gui.sh ./SHA256SUMS
#
# Optional:
#   BLVM_SIGN_TAG=v0.3.0-beta.7   also create a signed git tag (not pushed)
#   BLVM_PINENTRY=/usr/bin/pinentry-qt
#
# Someone must be at the workstation to answer the passphrase dialog.
# Do not put the passphrase in the environment or the chat.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SIGN_SH="${SCRIPT_DIR}/sign-release.sh"
PINENTRY="${BLVM_PINENTRY:-/usr/bin/pinentry-gtk}"
CURSES_PINENTRY="${BLVM_PINENTRY_RESTORE:-/usr/bin/pinentry-curses}"
GNUPG_HOME="${GNUPGHOME:-$HOME/.gnupg}"
AGENT_CONF="${GNUPG_HOME}/gpg-agent.conf"
SUMS="${1:-SHA256SUMS}"

if [ ! -x "$SIGN_SH" ] && [ ! -f "$SIGN_SH" ]; then
  echo "missing $SIGN_SH" >&2
  exit 2
fi
if [ ! -x "$PINENTRY" ]; then
  echo "pinentry not executable: $PINENTRY" >&2
  echo "install pinentry-gtk or set BLVM_PINENTRY" >&2
  exit 2
fi
if [ -z "${DISPLAY:-}" ]; then
  echo "DISPLAY is unset. GUI pinentry needs a display (usually DISPLAY=:1)." >&2
  exit 2
fi
if [ -z "${DBUS_SESSION_BUS_ADDRESS:-}" ]; then
  if [ -S "/run/user/$(id -u)/bus" ]; then
    export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus"
  else
    echo "DBUS_SESSION_BUS_ADDRESS is unset and /run/user/\$UID/bus is missing." >&2
    exit 2
  fi
fi

mkdir -p "$GNUPG_HOME"
chmod 700 "$GNUPG_HOME"
touch "$AGENT_CONF"
chmod 600 "$AGENT_CONF"

# Remember the previous pinentry-program line (if any) for restore.
PREV_LINE=""
if grep -q '^pinentry-program ' "$AGENT_CONF" 2>/dev/null; then
  PREV_LINE="$(grep '^pinentry-program ' "$AGENT_CONF" | tail -n1)"
fi

restore_pinentry() {
  local conf="$AGENT_CONF"
  if [ -n "$PREV_LINE" ]; then
    if grep -q '^pinentry-program ' "$conf" 2>/dev/null; then
      # Replace every pinentry-program line with the previous one.
      tmp="$(mktemp)"
      awk -v line="$PREV_LINE" '
        BEGIN { done=0 }
        /^pinentry-program / {
          if (!done) { print line; done=1 }
          next
        }
        { print }
        END { if (!done) print line }
      ' "$conf" >"$tmp"
      mv "$tmp" "$conf"
    else
      printf '%s\n' "$PREV_LINE" >>"$conf"
    fi
  else
    # Default restore for this host.
    if grep -q '^pinentry-program ' "$conf" 2>/dev/null; then
      tmp="$(mktemp)"
      awk -v line="pinentry-program ${CURSES_PINENTRY}" '
        BEGIN { done=0 }
        /^pinentry-program / {
          if (!done) { print line; done=1 }
          next
        }
        { print }
        END { if (!done) print line }
      ' "$conf" >"$tmp"
      mv "$tmp" "$conf"
    else
      printf 'pinentry-program %s\n' "$CURSES_PINENTRY" >>"$conf"
    fi
  fi
  chmod 600 "$conf"
  gpgconf --kill gpg-agent >/dev/null 2>&1 || true
  echo "restored pinentry to $(grep '^pinentry-program ' "$conf" | tail -n1)"
}
trap restore_pinentry EXIT

# Point the agent at the GUI pinentry for this run only.
tmp="$(mktemp)"
if grep -q '^pinentry-program ' "$AGENT_CONF" 2>/dev/null; then
  awk -v line="pinentry-program ${PINENTRY}" '
    BEGIN { done=0 }
    /^pinentry-program / {
      if (!done) { print line; done=1 }
      next
    }
    { print }
    END { if (!done) print line }
  ' "$AGENT_CONF" >"$tmp"
else
  cat "$AGENT_CONF" >"$tmp"
  printf 'pinentry-program %s\n' "$PINENTRY" >>"$tmp"
fi
mv "$tmp" "$AGENT_CONF"
chmod 600 "$AGENT_CONF"
gpgconf --kill gpg-agent >/dev/null 2>&1 || true
echo "using $(grep '^pinentry-program ' "$AGENT_CONF" | tail -n1)"
echo "answer the passphrase dialog on DISPLAY=${DISPLAY}"

bash "$SIGN_SH" "$SUMS"
