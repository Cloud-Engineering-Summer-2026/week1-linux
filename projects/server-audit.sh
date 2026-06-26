#!/bin/bash

# Basic server audit scricpt
# Week 1 Day 4 - Cloud Accelerator
# Author: Micah Ade Cedar

echo "==== SERVER AUDIT ===="
echo "Date: $(date)"
echo ""

echo "==== SYSTEM INFORMATION ===="
echo "Host: $(hostname)"
echo "User: $(whoami)"
echo "Path: $(pwd)"
echo ""

echo "==== DISK USAGE ===="
df -h | grep -E "^/dev/"
echo ""

echo "==== USERS ON SYSTEM ===="
awk -F':' '$3 >= 1000 && $3 != 65534 {print $1}' /etc/passwd
echo ""

echo "==== USERS WITH SUDO ACCESS ===="
getent group sudo | cut -d':' -f4
echo ""

echo "==== SSH KEY PERMISSION CHECK ===="
ls -lA ~/.ssh/ | grep "id_" | awk '{print $1, $9}'
echo ""

echo "==== RECENT LOG ACTIVITY ===="
echo "___AUTH_LOGS___"
sudo tail -50 /var/log/auth.log | grep -Ei "accepted|session opened|invalid"
echo ""
echo "___SYS_LOGS___"
sudo tail -50 /var/log/syslog | grep -Ei "error|fail|warn|critical"
echo ""
