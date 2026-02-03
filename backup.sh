#!/bin/bash

# Конфігурація
BACKUP_DIR="$HOME/devops-learning/backups"
SOURCE_DIR="$HOME/devops-learning"
DATE=$(date +"%Y%m%d_%H%M%S")
BACKUP_NAME="backup_$DATE.tar.gz"

echo "================================"
echo "🗄️  Backup Script"
echo "================================"
echo ""

# Створити папку для бекапів якщо не існує
if [ ! -d "$BACKUP_DIR" ]; then
    echo "📁 Creating backup directory..."
    mkdir -p "$BACKUP_DIR"
fi

echo "📦 Creating backup..."
echo "Source: $SOURCE_DIR"
echo "Destination: $BACKUP_DIR/$BACKUP_NAME"
echo ""

# Створити архів (виключаючи папку backups)
tar -czf "$BACKUP_DIR/$BACKUP_NAME" \
    --exclude="backups" \
    --exclude="*.tar.gz" \
    -C "$SOURCE_DIR" \
    .

# Перевірка чи вдалося створити бекап
if [ $? -eq 0 ]; then
    BACKUP_SIZE=$(du -h "$BACKUP_DIR/$BACKUP_NAME" | awk '{print $1}')
    echo "✅ Backup created successfully!"
    echo "📊 Size: $BACKUP_SIZE"
else
    echo "❌ Backup failed!"
    exit 1
fi

echo ""
echo "🗂️  All backups:"
ls -lh "$BACKUP_DIR"

echo ""
echo "================================"

# Очистка старих бекапів (залишити тільки останні 5)
BACKUP_COUNT=$(ls "$BACKUP_DIR"/backup_*.tar.gz 2>/dev/null | wc -l)

if [ "$BACKUP_COUNT" -gt 5 ]; then
    echo "🧹 Cleaning old backups (keeping last 5)..."
    cd "$BACKUP_DIR"
    ls -t backup_*.tar.gz | tail -n +6 | while read file; do
        rm "$file"
        echo "   Deleted: $file"
    done
    echo "✅ Cleanup complete!"
else
    echo "📋 Total backups: $BACKUP_COUNT (no cleanup needed)"
fi

echo "================================"

