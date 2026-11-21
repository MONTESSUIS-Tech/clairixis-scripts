# Clairixis scripts: ready-made scripts for Clairixis.
# Copyright (C) 2026 MONTESSUIS Tech
# SPDX-License-Identifier: GPL-3.0-or-later

set -u
curl --silent --show-error --location --max-time 15 --output /dev/null \
    --write-out 'HTTP %{http_code} in %{time_total} s, from %{remote_ip}\n' "$ADDRESS"
