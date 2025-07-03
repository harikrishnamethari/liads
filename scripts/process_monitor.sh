#!/bin/bash
# scripts/process_monitor.sh - Detect suspicious processes
BASEDIR="$(dirname "$(readlink -f "$0")")"
LOGFILE="$BASEDIR/../logs/process_alerts.log"
PATTERN='bash -i|nc (-e|-c)|python -c|perl -e|php -r|sh -c'

while true; do
  # Check for suspicious patterns in process list
  suspicious=$(ps aux | grep -E "$PATTERN" | grep -v grep)
  if [ -n "$suspicious" ]; then
    echo "$(date '+%F %T') Suspicious process(es) detected:" >> "$LOGFILE"
    echo "$suspicious" >> "$LOGFILE"
    echo >> "$LOGFILE"
  fi
  sleep 10
done

