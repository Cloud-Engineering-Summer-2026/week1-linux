#!/bin/bash

# monitor.sh - System Health Monitor
# Week 1 Linux Automation Toolkit
# Author: Micah Ade Cedar

set -euo pipefail

SEPARATOR="========================================================================================================="

echo "$SEPARATOR"
echo "SYSTEM HEALTH REPORT"
echo "Generated: $(date)"
echo "Host: $(hostname) | User: $(whoami)"
echo "$SEPARATOR"

#----System info---------------------------------------------------------
echo ""
echo "===== SYSTEM INFO ====="
echo "OS: $(grep PRETTY_NAME /etc/os-release | cut -d'"' -f2)"
echo "Kernel: $(uname -r)"
echo "Uptime: $(uptime -p)"

#----CPU-----------------------------------------------------------------
echo ""
echo "===== CPU ======"
echo "Cores: $(nproc)"
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'%' -f1)
echo "Usage: '$CPU_USAGE'"

#----Memory--------------------------------------------------------------
echo ""
echo "===== MEMORY ======"
free -h | awk 'NR==2{printf "Total: %s\nUsed: %s\nFree: %s\n", $2, $3, $4}'

#----Disk----------------------------------------------------------------
echo ""
echo "===== TOP 5 PROCESSES BY MEMORY ====="
df -h | grep -E "^/dev/|//" || df -h | grep -E "^[/]" | awk '{printf "%-20s %s used of %s (%s)\n", $6, $3, $2, $5}'

#----Top Processes-------------------------------------------------------
echo ""
echo "===== TOP 5 PROCESSES BY MEMORY ====="
ps aux --sort=-%mem | awk 'NR<=6{printf "%-10s %-8s %s\n", $1, $4"%", $11}' | tail -5

#----Users----------------------------------------------------------------
echo ""
echo "===== LOGGED IN USERS ====="
who

# ── SSH Keys ───────────────────────────────────────────────
echo ""
echo "[ SSH KEY PERMISSIONS ]"
ls -lA ~/.ssh/ 2>/dev/null | grep "id_" | awk '{print $1, $9}' || echo "No SSH keys found."

# ── Recent Auth Activity ───────────────────────────────────
echo ""
echo "[ RECENT AUTH ACTIVITY ]"
if [ -f /var/log/auth.log ]; then
    sudo tail -20 /var/log/auth.log | grep -Ei "accepted|invalid|failed" || echo "No notable auth events."
else
    echo "auth.log not available on this system."
fi

echo ""
echo "$SEPARATOR"
echo " END OF REPORT"
echo "$SEPARATOR"
