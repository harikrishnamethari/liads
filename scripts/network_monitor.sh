#!/bin/bash
# scripts/network_monitor.sh - Log active network connections
BASEDIR="$(dirname "$(readlink -f "$0")")"
LOGFILE="$BASEDIR/../logs/network.log"

# Determine command for listing connections
if command -v ss >/dev/null 2>&1; then
  CONN_CMD="ss -t -a -p"
elif command -v netstat >/dev/null 2>&1; then
  CONN_CMD="netstat -antp"
else
  echo "ERROR: Neither ss nor netstat found."
  exit 1
fi

# Loop: log every minute
while true; do
  echo "===== $(date '+%F %T') Active Connections =====" >> "$LOGFILE"
  $CONN_CMD >> "$LOGFILE"
  echo -e "\n" >> "$LOGFILE"
  sleep 60
done

