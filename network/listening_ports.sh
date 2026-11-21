# Clairixis scripts: ready-made scripts for Clairixis.
# Copyright (C) 2026 Quentin MONTESSUIS (MONTESSUIS Tech)
# SPDX-License-Identifier: GPL-3.0-or-later

set -u
if command -v ss >/dev/null 2>&1; then
    ss -tulnp
elif command -v netstat >/dev/null 2>&1; then
    netstat -tulnp
else
    echo "Neither ss nor netstat is installed on this host."
fi
