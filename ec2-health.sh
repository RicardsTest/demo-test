#!/bin/bash

echo "=== EC2 Health Check ==="
echo "Date: $(date)"
echo "Hostname: $(hostname)"

echo "--- Uptime ---"
uptime -p

echo "--- Disk ---"
df -h /

echo "--- Memory ---"
free -h

echo "--- CPU Load ---"
cat /proc/loadavg

echo "Health check completed"
