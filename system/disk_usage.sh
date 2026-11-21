set -u
echo "== Filesystems"
df -hP -x tmpfs -x devtmpfs 2>/dev/null || df -hP
echo
echo "== Largest directories under $DIRECTORY"
du -xk -d 2 "$DIRECTORY" 2>/dev/null | sort -rn | head -n "$COUNT" |
    awk '{ size = $1; $1 = ""; printf "%10.1f MiB %s\n", size / 1024, $0 }'
