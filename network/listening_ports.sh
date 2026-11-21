set -u
if command -v ss >/dev/null 2>&1; then
    ss -tulnp
elif command -v netstat >/dev/null 2>&1; then
    netstat -tulnp
else
    echo "Neither ss nor netstat is installed on this host."
fi
