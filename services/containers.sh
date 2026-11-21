set -u
if command -v docker >/dev/null 2>&1; then
    tool=docker
elif command -v podman >/dev/null 2>&1; then
    tool=podman
else
    echo "Neither Docker nor Podman is installed on this host."
    exit 0
fi
"$tool" ps --all --format 'table {{.Names}}\t{{.Image}}\t{{.Status}}'
echo
"$tool" system df
