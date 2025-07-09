#!/bin/bash
# scripts/file_monitor.sh - Watch /etc and /boot for changes
BASEDIR="~/liads"
LOGS="$BASEDIR/logs"

mkdir -p "$LOGS"

LOGFILE="$LOGS/file_changes.log"

# Ensure inotifywait is available
if ! command -v inotifywait >/dev/null 2>&1; then
  echo "ERROR: inotifywait not found. Install inotify-tools."
  exit 1
fi

# Directories to monitor
DIRS="/etc /boot"

# Run inotifywait continuously (-m), recursively (-r), logging create/modify/delete/attrib events
inotifywait -m -r -e create,delete,modify,attrib --format '%T %w%f %e' \
            --timefmt '%F %T' $DIRS >> "$LOGFILE"
