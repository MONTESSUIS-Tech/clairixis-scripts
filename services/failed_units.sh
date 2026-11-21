# Clairixis scripts: ready-made scripts for Clairixis.
# Copyright (C) 2026 Quentin MONTESSUIS (MONTESSUIS Tech)
# SPDX-License-Identifier: GPL-3.0-or-later

set -u
if [ ! -d /run/systemd/system ]; then
    echo "This host does not run systemd."
    exit 0
fi
failed=$(systemctl list-units --state=failed --no-legend --no-pager --plain)
if [ -z "$failed" ]; then
    echo "No failed unit."
    exit 0
fi
echo "$failed"
exit 1
