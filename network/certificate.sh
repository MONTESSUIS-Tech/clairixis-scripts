# Clairixis scripts: ready-made scripts for Clairixis.
# Copyright (C) 2026 MONTESSUIS Tech
# SPDX-License-Identifier: GPL-3.0-or-later

set -u
name=${ADDRESS%%:*}
certificate=$(echo | openssl s_client -connect "$ADDRESS" -servername "$name" 2>/dev/null |
    openssl x509 2>/dev/null)
if [ -z "$certificate" ]; then
    echo "No certificate could be read from $ADDRESS."
    exit 1
fi
echo "$certificate" | openssl x509 -noout -subject -issuer -enddate
if echo "$certificate" | openssl x509 -noout -checkend "$((${DAYS%.*} * 86400))" >/dev/null; then
    echo "Valid for more than ${DAYS%.*} days."
else
    echo "Expires within ${DAYS%.*} days."
    exit 1
fi
