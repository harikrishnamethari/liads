#!/bin/bash
# scripts/log_monitor.sh - Monitor SSH and sudo logs via journalctl
BASEDIR="$(dirname "$(readlink -f "$0")")"
LOGDIR="$BASEDIR/../logs"

# Ensure journalctl is available
if ! command -v journalctl >/dev/null 2>&1; then
  echo "ERROR: journalctl not found."
  exit 1
fi

# Monitor SSHD log (authentication messages)
journalctl -f -u sshd -o short-iso | tee -a "$LOGDIR/ssh.log" | \
    grep --line-buffered -i "fail" >> "$LOGDIR/failed.log" &

# Monitor sudo usage (identifier "sudo")
journalctl -f -t sudo -o short-iso >> "$LOGDIR/sudo.log" &

