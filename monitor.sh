#!/bin/bash

# System Monitor Script for Linux

echo "========== System Monitoring Script =========="

# Date and Time
echo "Date and Time: $(date)"

# Uptime
echo -e "\nSystem Uptime:"
uptime

# CPU Usage
echo -e "\nCPU Usage:"
top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print "CPU Load: "100 - $1"%"}'

# Memory Usage
echo -e "\nMemory Usage:"
free -h | awk '/Mem/ {printf "Used/Total: %s/%s (%.2f%%)\n", $3, $2, $3/$2 * 100.0}'

# Disk Usage
echo -e "\nDisk Usage:"
df -h | awk '$NF=="/"{printf "Disk Usage: %d/%dGB (%s)\n", $3, $2, $5}'

# Network Traffic
echo -e "\nNetwork Statistics:"
echo "Received Data: $(cat /sys/class/net/eth0/statistics/rx_bytes) bytes"
echo "Transmitted Data: $(cat /sys/class/net/eth0/statistics/tx_bytes) bytes"

# Process Information
echo -e "\nTop 5 Memory Consuming Processes:"
ps aux --sort=-%mem | awk 'NR<=5{printf "%-10s %-10s %-10s %s\n", $1, $2, $3, $11}'

echo "==============================================="
