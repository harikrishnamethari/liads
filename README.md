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
2. **Install dependencies** on Arch Linux:
    sudo pacman -S inotify-tools net-tools
    (`iproute2` and `bash` are already installed by default.)
3. **Enable and start** the LIADS service:
    ```bash
    sudo cp /opt/liads/systemd/liads.service /etc/systemd/system/
    sudo systemctl daemon-reload
    sudo systemctl enable liads.service
    sudo systemctl start liads.service
4. **Verify** by checking logs in `/opt/liads/logs/` and running `liads/scripts/dashboard.sh`.

## Logs

All event logs are under the `logs/` directory:
- `file_changes.log`: filesystem events in `/etc` and `/boot`.
- `ssh.log`: SSH authentication messages.
- `sudo.log`: `sudo` command usage.
- `failed.log`: failed SSH login attempts.
- `process_alerts.log`: detected suspicious processes.
- `kernel_modules.log`: new kernel modules detected.
- `network.log`: snapshots of active network connections.

## Usage

- **Start/Stop Service:** Use `systemctl start|stop liads`.
- **View Dashboard:** Run `/opt/liads/scripts/dashboard.sh` to see recent events.
- **Inspect Logs:** Check files in `/opt/liads/logs` for detailed records.

LIADS is intended as a lightweight HIDS for Arch Linux, providing continuous monitoring via pure Bash scripts and system tools.
