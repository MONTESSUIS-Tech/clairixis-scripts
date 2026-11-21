# Clairixis scripts: ready-made scripts for Clairixis.
# Copyright (C) 2026 MONTESSUIS Tech
# SPDX-License-Identifier: GPL-3.0-or-later

set -u
echo "Load: $(cut -d ' ' -f 1-3 /proc/loadavg) on $(grep -c ^processor /proc/cpuinfo) processor(s)"
echo
echo "== Processes using the most processor time"
if ps -eo pid >/dev/null 2>&1; then
    ps -eo pid,user,pcpu,time,comm --sort=-pcpu | head -n "$((${COUNT%.*} + 1))"
else
    echo "This host has no ps that can list them."
fi
