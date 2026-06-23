#!/bin/bash

# backup.sh - Directory backup script
# Week 1 - Cloud Accelerator
# Author: Micah Ade Cedar

# Path of the directory we wish to back up
SOURCE=$1

# Path of where we wish to store the directory
DEST=$2

# Timestamp generation, down to the second, to differentiate back ups
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

# Build filename for backup archive
BACKUP_NAME="backup_${TIMESTAMP}.tar.gz"

# Validate if paths were provided
if [ -z "$SOURCE" ] || [ -z "$DEST" ]; then
	echo "Usage: ./backup.sh <source_directory> <destination_directory>"
	exit 1
fi

# Ensure source directory is real
if [ ! -d "$SOURCE" ]; then
	echo "Error: Source diretory '$SOURCE' does not exist"
	exit 1
fi

# Robust destination path creation and validation
mkdir -p "$DEST"

# Backup file creation
tar -czf "$DEST/$BACKUP_NAME" "$SOURCE" && \
echo "$(date): Backed up '$SOURCE' to '$DEST/$BACKUP_NAME'" >> ~/backup.log

echo "Backup complete: $DEST/$BACKUP_NAME"

