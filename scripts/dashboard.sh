#!/bin/bash
# scripts/dashboard.sh - CLI summary of LIADS logs
BASEDIR="$(dirname "$(readlink -f "$0")")"
LOGDIR="$BASEDIR/../logs"

echo "===== LIADS Dashboard ====="
echo

echo "-- Recent File Changes (/etc, /boot) --"
tail -n 5 "$LOGDIR/file_changes.log"
echo

echo "-- Recent SSH Authentication (/ssh.log) --"
tail -n 5 "$LOGDIR/ssh.log"
echo

echo "-- Recent sudo Commands (/sudo.log) --"
tail -n 5 "$LOGDIR/sudo.log"
echo

echo "-- Recent Failed Logins (/failed.log) --"
tail -n 5 "$LOGDIR/failed.log"
echo

echo "-- Suspicious Processes (/process_alerts.log) --"
tail -n 5 "$LOGDIR/process_alerts.log"
echo

echo "-- Recently Loaded Kernel Modules (/kernel_modules.log) --"
tail -n 5 "$LOGDIR/kernel_modules.log"
echo

echo "-- Network Connections (/network.log) --"
tail -n 5 "$LOGDIR/network.log"
echo

