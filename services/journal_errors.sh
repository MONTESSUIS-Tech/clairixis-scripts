set -u
if [ ! -d /run/systemd/system ] || ! command -v journalctl >/dev/null 2>&1; then
    echo "This host has no systemd journal."
    exit 0
fi
journalctl --priority=err --since "-${HOURS%.*}h" --no-pager --lines=200
