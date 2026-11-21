# Clairixis scripts: ready-made scripts for Clairixis.
# Copyright (C) 2026 Quentin MONTESSUIS (MONTESSUIS Tech)
# SPDX-License-Identifier: GPL-3.0-or-later

set -u
date
if [ -d /run/systemd/system ] && command -v timedatectl >/dev/null 2>&1; then
    timedatectl status || true
fi
if command -v chronyc >/dev/null 2>&1; then
    echo
    chronyc tracking || true
fi
true
