set -u
date
if [ -d /run/systemd/system ] && command -v timedatectl >/dev/null 2>&1; then
    timedatectl status || true
fi
if command -v chronyc >/dev/null 2>&1; then
    echo
    chronyc tracking || true
fi
true
