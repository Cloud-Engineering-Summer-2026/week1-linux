#!/bin/bash/

#checking root account to avoid script failure
if [ "$EUID" -ne 0 ]; then
	echo "Run with sudo"
	exit 1
fi

# Arguement passing
USERNAME=$1

# Username existence validation
if [ -z "$USERNAME" ]; then
	echo "Usage: sudo /mnt/c/Users/user/Documents/summer2026/summer-cloud-engineering/projects/create-user.sh username"
	exit 1
fi

# Checking if user already exists
if id "$USERNAME" &>/dev/null; then
	echo "User already exists"
	exit 1
fi

# Create user,give them home directory and default their shell to bash
useradd -m -s /bin/bash "$USERNAME"

# Ask for password
passwd "$USERNAME"

#Add user to sudo group
usermod -aG sudo "$USERNAME"

# Confirmation
echo "User created successfully with administrative privileges"
id "$USERNAME"

