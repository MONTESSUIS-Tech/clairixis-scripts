# Clairixis scripts: ready-made scripts for Clairixis.
# Copyright (C) 2026 Quentin MONTESSUIS (MONTESSUIS Tech)
# SPDX-License-Identifier: GPL-3.0-or-later

set -u
find "$DIRECTORY" -xdev -type f -size +"${MEGABYTES%.*}"M -exec du -k {} + 2>/dev/null |
    sort -rn | head -n "$COUNT" |
    awk '{ size = $1; $1 = ""; printf "%10.1f MiB %s\n", size / 1024, $0 }'
