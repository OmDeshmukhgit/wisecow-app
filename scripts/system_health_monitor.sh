#!/bin/bash

CPU_LIMIT=80
MEM_LIMIT=80
DISK_LIMIT=80
LOG_FILE="system_health.log"

echo "System health check - $(date)" | tee -a "$LOG_FILE"

cpu=$(top -bn1 | awk '/Cpu\(s\)/ {print 100 - $8}' | cut -d. -f1)
mem=$(free | awk '/Mem:/ {printf "%.0f", ($3/$2)*100}')
disk=$(df / | awk 'NR==2 {print $5}' | tr -d '%')
processes=$(ps -e --no-headers | wc -l)

echo "CPU: $cpu%" | tee -a "$LOG_FILE"
if [ "$cpu" -gt "$CPU_LIMIT" ]; then
    echo "ALERT: CPU usage is high" | tee -a "$LOG_FILE"
fi

echo "Memory: $mem%" | tee -a "$LOG_FILE"
if [ "$mem" -gt "$MEM_LIMIT" ]; then
    echo "ALERT: Memory usage is high" | tee -a "$LOG_FILE"
fi

echo "Disk: $disk%" | tee -a "$LOG_FILE"
if [ "$disk" -gt "$DISK_LIMIT" ]; then
    echo "ALERT: Disk usage is high" | tee -a "$LOG_FILE"
fi

echo "Running processes: $processes" | tee -a "$LOG_FILE"
