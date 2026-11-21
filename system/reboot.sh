set -eu
shutdown -r "+${MINUTES%.*}" "Restart asked from Clairixis"
echo "The host restarts in ${MINUTES%.*} minute(s). To cancel: shutdown -c"
