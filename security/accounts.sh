# Clairixis scripts: ready-made scripts for Clairixis.
# Copyright (C) 2026 Quentin MONTESSUIS (MONTESSUIS Tech)
# SPDX-License-Identifier: GPL-3.0-or-later

set -u
echo "== Accounts with a login shell"
awk -F: '$7 !~ /(nologin|false|sync|shutdown|halt)$/ { printf "%-20s uid %-6s %s\n", $1, $3, $7 }' /etc/passwd
echo
echo "== Administrator groups"
for group in sudo wheel admin; do
    getent group "$group" 2>/dev/null || true
done
