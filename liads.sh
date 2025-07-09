#!/bin/bash
# liads.sh - Main LIADS launcher
BASEDIR="$HOME/liads"
LOGDIR="$BASEDIR/logs"

# Create logs directory if missing
mkdir -p "$LOGDIR"

# Launch monitors in background
bash "$BASEDIR/scripts/file_monitor.sh" &
bash "$BASEDIR/scripts/log_monitor.sh" &
bash "$BASEDIR/scripts/process_monitor.sh" &
bash "$BASEDIR/scripts/network_monitor.sh" &

# Optional: start kernel module watcher
# (simple baseline comparison of lsmod, run every 30 seconds)
(
  last=""
  while true; do
    current=$(lsmod | awk '{print $1}' | tr '\n' ',' )
    if [ -n "$last" ] && [ "$current" != "$last" ]; then
      # find new modules
      echo "$(date '+%F %T') Kernel modules changed:" >> "$LOGDIR/kernel_modules.log"
      diff <(echo "$last" | tr ',' '\n') <(echo "$current" | tr ',' '\n') | \
        grep "^>" | awk '{print $2}' >> "$LOGDIR/kernel_modules.log"
      echo >> "$LOGDIR/kernel_modules.log"
    fi
    last="$current"
    sleep 30
  done
) &

# Trap signals to kill all children on exit
trap "echo 'Shutting down LIADS...'; kill 0" SIGINT SIGTERM

# Keep script running to maintain service
wait

