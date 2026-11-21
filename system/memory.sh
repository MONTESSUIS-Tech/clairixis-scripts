# Clairixis scripts: ready-made scripts for Clairixis.
# Copyright (C) 2026 MONTESSUIS Tech
# SPDX-License-Identifier: GPL-3.0-or-later

set -u
free -m 2>/dev/null || grep -E '^(MemTotal|MemAvailable|SwapTotal|SwapFree):' /proc/meminfo
echo
echo "== Processes holding the most memory"
if ! ps -eo pid,user,rss,pmem,comm --sort=-rss 2>/dev/null | head -n "$((${COUNT%.*} + 1))"; then
    true
fi
if ! ps -eo pid >/dev/null 2>&1; then
    # Without a full ps: what the kernel says of each process.
    for status in /proc/[0-9]*/status; do
        awk '/^Name:/ { name = $2 } /^Pid:/ { pid = $2 } /^VmRSS:/ { rss = $2 }
             END { if (rss > 0) printf "%10.1f MiB %7s %s\n", rss / 1024, pid, name }' \
            "$status" 2>/dev/null
    done | sort -rn | head -n "${COUNT%.*}"
fi
