# Clairixis scripts: ready-made scripts for Clairixis.
# Copyright (C) 2026 Quentin MONTESSUIS (MONTESSUIS Tech)
# SPDX-License-Identifier: GPL-3.0-or-later

set -u
echo "Running kernel: $(uname -r)"
if [ -e /var/run/reboot-required ]; then
    echo "A restart is needed:"
    cat /var/run/reboot-required.pkgs 2>/dev/null || true
elif command -v needs-restarting >/dev/null 2>&1; then
    needs-restarting -r || true
elif command -v zypper >/dev/null 2>&1; then
    zypper needs-rebooting || true
else
    echo "Nothing on this host says that a restart is needed."
fi
