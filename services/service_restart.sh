# Clairixis scripts: ready-made scripts for Clairixis.
# Copyright (C) 2026 MONTESSUIS Tech
# SPDX-License-Identifier: GPL-3.0-or-later

set -eu
systemctl restart "$UNIT"
sleep 2
systemctl status --no-pager --lines=10 "$UNIT"
systemctl is-active --quiet "$UNIT"
