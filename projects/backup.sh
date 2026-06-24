#!/bin/bash

# backup.sh - Directory backup script
# Week 1 - Cloud Accelerator
# Author: Micah Ade Cedar

# Setting strict mode
set -euo pipefail
# set -e -> exit immediately if any command fails
# set -u -> treat unset variables as errors
# set -o pipefail -> catch errors on both sides of pipes not just end

LOG_FILE="$HOME/backup.log"
# Timestamp generation, down to the second, to differentiate back ups
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

# Build filename for backup archive
BACKUP_NAME="backup_${TIMESTAMP}.tar.gz"

#-----Guard clauses---------------------------------------------------
# Check if root user
if [ $EUID -eq 0 ]; then
	echo "Do not run backup as root."
	exit 1
fi

#Validate arguements, with fallback modifier to avoid ugly error
if [ -z "${1:-}" ] || [ -z "${2:-}" ]; then
	echo "Usage: ./backup.sh <source_directory> <destination_directory>"
	exit 1
fi

# Arguement passing
SOURCE=$1
DEST=$2

# Ensure source directory is real
if [ ! -d "$SOURCE" ]; then
	echo "Error: Source diretory '$SOURCE' does not exist"
	exit 1
fi

#------Backup-----------------------------------------------------------
# Robust destination directory creation
mkdir -p "$DEST"

# Backup file creation
tar -czf "$DEST/$BACKUP_NAME" "$SOURCE" && \
echo "$(date): Backed up '$SOURCE' to '$DEST/$BACKUP_NAME'" >> "$LOG_FILE"

echo "✓ Backup complete: $DEST/$BACKUP_NAME"
echo "✓ Logged to $LOG_FILE"

