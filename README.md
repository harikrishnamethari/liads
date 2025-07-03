# LIADS: Linux Intrusion Detection and Audit System

**LIADS** is a Bash-based host intrusion detection system for Arch Linux. It monitors critical directories (`/etc`, `/boot`), authentication events (SSH logins, `sudo` usage), suspicious processes (reverse-shell patterns), kernel modules, and network connections. All events are logged, and a CLI dashboard summarizes recent activity.

## Architecture

- **File Integrity:** Uses `inotifywait` (inotify-tools) to watch `/etc`, `/boot` for changes:contentReference[oaicite:18]{index=18}. Logs create/modify/delete events.
- **Auth Logging:** Parses `journalctl` for SSH (`sshd`) and `sudo` logs:contentReference[oaicite:19]{index=19}:contentReference[oaicite:20]{index=20}. Records logins, `sudo` commands, and failed attempts.
- **Process Watch:** Periodically scans running processes for indicators like `nc -e`, `bash -i`, etc. (common reverse-shell signatures):contentReference[oaicite:21]{index=21}:contentReference[oaicite:22]{index=22}.
- **Kernel Modules:** Captures `lsmod` output snapshots to detect new modules.
- **Network:** Logs active TCP connections (`ss`/`netstat`) every minute:contentReference[oaicite:23]{index=23}.
- **Dashboard:** Provides a friendly CLI (`scripts/dashboard.sh`) that shows recent logs and summaries.

## Installation

1. **Clone LIADS** to a system directory (e.g. `/opt/liads`):
   ```bash
   git clone https://github.com/youruser/liads.git /opt/liads
