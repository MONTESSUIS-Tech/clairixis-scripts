set -u
space() { df -hP / | awk 'NR == 2 { print $4 " free on /" }'; }
echo "Before: $(space)"
if command -v apt-get >/dev/null 2>&1; then
    apt-get clean
elif command -v dnf >/dev/null 2>&1; then
    dnf clean all
elif command -v yum >/dev/null 2>&1; then
    yum clean all
elif command -v zypper >/dev/null 2>&1; then
    zypper --non-interactive clean --all
elif command -v apk >/dev/null 2>&1; then
    apk cache clean
else
    echo "No package manager that Clairixis knows on this host."
    exit 1
fi
echo "After: $(space)"
