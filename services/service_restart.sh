set -eu
systemctl restart "$UNIT"
sleep 2
systemctl status --no-pager --lines=10 "$UNIT"
systemctl is-active --quiet "$UNIT"
