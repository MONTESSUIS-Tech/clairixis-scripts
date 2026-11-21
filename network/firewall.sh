# Clairixis scripts: ready-made scripts for Clairixis.
# Copyright (C) 2026 Quentin MONTESSUIS (MONTESSUIS Tech)
# SPDX-License-Identifier: GPL-3.0-or-later

set -u
if command -v firewall-cmd >/dev/null 2>&1 && firewall-cmd --state >/dev/null 2>&1; then
    firewall-cmd --list-all-zones
elif command -v ufw >/dev/null 2>&1; then
    ufw status verbose
elif command -v nft >/dev/null 2>&1; then
    nft list ruleset
elif command -v iptables >/dev/null 2>&1; then
    iptables -S
else
    echo "No firewall tool found on this host."
fi
