# Clairixis scripts: ready-made scripts for Clairixis.
# Copyright (C) 2026 MONTESSUIS Tech
# SPDX-License-Identifier: GPL-3.0-or-later

set -u
echo "== Logged in now"
if command -v who >/dev/null 2>&1; then
    who
else
    echo "The command who is not installed on this host."
fi
echo
echo "== Last logins"
if command -v last >/dev/null 2>&1; then
    # A host that keeps no record of logins has nothing to show.
    last -n "${COUNT%.*}" 2>/dev/null || echo "This host keeps no record of logins."
else
    echo "The command last is not installed on this host."
fi
