#!/bin/bash

SOURCE_DIR="${ZETTELKASTEN_PATH}"
BACKUP_DIR="$HOME/backups"
DATE=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="zk_backup_$DATE.tar.gz"

if [ ! -d "$SOURCE_DIR" ]; then
  echo "Dir $SOURCE_DIR not found!"
  exit 1
fi

mkdir -p "$BACKUP_DIR"

tar -czf "$BACKUP_DIR/$BACKUP_FILE" -C "$(dirname "$SOURCE_DIR")" "$(basename "$SOURCE_DIR")"

if [ $? -eq 0 ]; then
  echo "Backup created: $BACKUP_DIR/$BACKUP_FILE"
else
  echo "Backup failed!"
  exit 1
fi
