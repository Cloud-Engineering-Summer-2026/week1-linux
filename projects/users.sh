#!/bin/bash

# users.sh - User Management Script
# Week 1 Linux Automation Toolkit
# Author: Micah Ade Cedar

# Strict Mode
set -euo pipefail

#----Root check---------------------------------
if [ $EUID -ne 0 ]; then
	echo "Run with sudo: sudo ./users.sh"
	exit 1
fi

#----Menu---------------------------------------
echo "===== User Management ====="
echo "1. Create user"
echo "2. Delete user"
echo "3. List human users."
echo "4. List sudo users."
echo "5. Check if users exists"
echo ""

read -rp "Select option [1-5]: " OPTION

case $OPTION in
     1) 
	read -rp "Enter username to create: " USERNAME
	if id "$USERNAME" >&/dev/null; then
		echo "User '$USERNAME' already exists"
		exit 1
	fi
	useradd -m -s /bin/bash "$USERNAME"
	passwd "$USERNAME"

	read -rp "Grant sudo access? [y/n]: " SUDO
	if [ "$SUDO" = "y" ]; then
		usermod -aG sudo "$USERNAME"
		echo "✓ Sudo access granted"
	fi
	
	echo "✓ User '$USERNAME' created."
	id "$USERNAME"
	;;
      2)
	read -rp "Enter username to delete: " USERNAME
	if ! id "$USERNAME" >&/dev/null; then
		echo "User '$USERNAME' does not exist."
		exit 1
	fi
	
	read -rp "Delete home directory too? [y/n]: " DELHOME
	if [ "$DELHOME" = "y" ]; then
		userdel -r "$USERNAME"
	else
		userdel "$USERNAME"
	fi

	echo "✓ User '$USERNAME' deleted."
	;;
       3)
	echo "===== Human Users ====="
	awk -F':' '$3 >= 1000 && $3 != 65534 {print $1, "|UID: " $3}' /etc/passwd
	;;
       4)
	echo "===== Sudo Users ====="
	getent group sudo | cut -d':' -f4 | tr ',' '\n'
	;;
       5)
	read -rp "Enter user to check: " USERNAME
	if id "$USERNAME" >&/dev/null; then
		echo "✓ User '$USERNAME' exists."
		id "$USERNAME"
	else
		echo "✗ User '$USERNAME' does not exist."
		exit 1
	fi
	;;
       *)
	echo "Invalid option."
	exit 1
	;;
esac

	
	
