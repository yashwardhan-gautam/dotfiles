#!/usr/bin/env bash
# Comprehensive Dotfiles and System Backup Script

set -euo pipefail

# Configuration
BACKUP_DIR="/home/unalome/backups"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
HOSTNAME=$(hostname)

# Create backup directory if not exists
mkdir -p "$BACKUP_DIR"

# Backup Nix configurations
echo "Backing up Nix configurations..."
cp -r /home/unalome/dotfiles "$BACKUP_DIR/dotfiles_${TIMESTAMP}"
cp -r /etc/nixos/* "$BACKUP_DIR/nixos_${TIMESTAMP}"

# Backup Home Manager configurations
echo "Backing up Home Manager configurations..."
cp -r ~/.config "$BACKUP_DIR/config_${TIMESTAMP}"
cp -r ~/.local/share "$BACKUP_DIR/local_share_${TIMESTAMP}"

# Backup important system files
echo "Backing up system files..."
mkdir -p "$BACKUP_DIR/system_${TIMESTAMP}"
cp /etc/machine-id "$BACKUP_DIR/system_${TIMESTAMP}/"
cp /etc/fstab "$BACKUP_DIR/system_${TIMESTAMP}/"

# Generate backup manifest
echo "Generating backup manifest..."
{
    echo "Backup Timestamp: $TIMESTAMP"
    echo "Hostname: $HOSTNAME"
    echo "Nix Flake Version: $(nix flake show /home/unalome/dotfiles --json | jq -r '.description')"
    echo "Home Manager Generation: $(home-manager generations | head -n 1)"
    echo "NixOS Generation: $(sudo nixos-rebuild list-generations | head -n 1)"
} > "$BACKUP_DIR/backup_manifest_${TIMESTAMP}.txt"

# Optional: Compress backup
echo "Compressing backup..."
tar -czvf "$BACKUP_DIR/dotfiles_backup_${HOSTNAME}_${TIMESTAMP}.tar.gz" \
    "$BACKUP_DIR/dotfiles_${TIMESTAMP}" \
    "$BACKUP_DIR/nixos_${TIMESTAMP}" \
    "$BACKUP_DIR/config_${TIMESTAMP}" \
    "$BACKUP_DIR/local_share_${TIMESTAMP}" \
    "$BACKUP_DIR/system_${TIMESTAMP}" \
    "$BACKUP_DIR/backup_manifest_${TIMESTAMP}.txt"

# Clean up individual backup directories
rm -rf "$BACKUP_DIR/dotfiles_${TIMESTAMP}" \
       "$BACKUP_DIR/nixos_${TIMESTAMP}" \
       "$BACKUP_DIR/config_${TIMESTAMP}" \
       "$BACKUP_DIR/local_share_${TIMESTAMP}" \
       "$BACKUP_DIR/system_${TIMESTAMP}" \
       "$BACKUP_DIR/backup_manifest_${TIMESTAMP}.txt"

# Optional: Keep only last 5 backups
echo "Cleaning up old backups..."
(ls -t "$BACKUP_DIR"/dotfiles_backup_* | head -n 5; ls -t "$BACKUP_DIR"/dotfiles_backup_*) | sort | uniq -u | xargs -r rm

echo "Backup completed successfully: $BACKUP_DIR/dotfiles_backup_${HOSTNAME}_${TIMESTAMP}.tar.gz"