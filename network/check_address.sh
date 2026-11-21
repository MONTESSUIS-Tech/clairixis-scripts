set -u
curl --silent --show-error --location --max-time 15 --output /dev/null \
    --write-out 'HTTP %{http_code} in %{time_total} s, from %{remote_ip}\n' "$ADDRESS"
