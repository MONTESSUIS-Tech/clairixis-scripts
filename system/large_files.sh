set -u
find "$DIRECTORY" -xdev -type f -size +"${MEGABYTES%.*}"M -exec du -k {} + 2>/dev/null |
    sort -rn | head -n "$COUNT" |
    awk '{ size = $1; $1 = ""; printf "%10.1f MiB %s\n", size / 1024, $0 }'
