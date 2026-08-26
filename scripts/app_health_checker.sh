#!/bin/bash

URL=${1:-https://localhost:32685/}

status=$(curl -k -s -o /dev/null -w "%{http_code}" \
    -H "Host: wisecow.local" \
    --max-time 10 "$URL")

if [[ "$status" =~ ^2[0-9][0-9]$ ]]; then
    echo "Application is UP"
    echo "HTTP status: $status"
else
    echo "Application is DOWN"
    echo "HTTP status: $status"
fi
