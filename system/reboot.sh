# Clairixis scripts: ready-made scripts for Clairixis.
# Copyright (C) 2026 Quentin MONTESSUIS (MONTESSUIS Tech)
# SPDX-License-Identifier: GPL-3.0-or-later

set -eu
shutdown -r "+${MINUTES%.*}" "Restart asked from Clairixis"
echo "The host restarts in ${MINUTES%.*} minute(s). To cancel: shutdown -c"
