#!/bin/bash
#
# backup.sh - Automated backup script with timestamps
#
# Description: Creates compressed backups of specified directories
#              with automatic timestamp naming and optional rotation.
#
# Usage: ./backup.sh [options] <source_directory>
#
# Options:
#   -d, --dest    Destination directory (default: ./backups)
#   -n, --name    Backup name prefix (default: backup)
#   -k, --keep    Number of backups to keep (default: 5)
#   -h, --help    Show this help message
#

set -euo pipefail

# Default configuration
DEST_DIR="./backups"
BACKUP_NAME="backup"
KEEP_COUNT=5
SOURCE_DIR=""

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

#######################################
# Print colored status messages
#######################################
info() { echo -e "${GREEN}[INFO]${NC} $*"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $*"; }
error() { echo -e "${RED}[ERROR]${NC} $*" >&2; }

#######################################
# Display usage information
#######################################
usage() {
    cat << EOF
Usage: $(basename "$0") [options] <source_directory>

Creates compressed backups with timestamps.

Options:
    -d, --dest DIR     Destination directory (default: ./backups)
    -n, --name NAME    Backup name prefix (default: backup)
    -k, --keep N       Number of backups to keep (default: 5)
    -h, --help         Show this help message

Examples:
    $(basename "$0") /home/user/documents
    $(basename "$0") -d /mnt/backups -n mybackup /home/user
    $(basename "$0") -k 10 /var/www

EOF
    exit 0
}

#######################################
# Parse command line arguments
#######################################
parse_args() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            -d|--dest)
                DEST_DIR="$2"
                shift 2
                ;;
            -n|--name)
                BACKUP_NAME="$2"
                shift 2
                ;;
            -k|--keep)
                KEEP_COUNT="$2"
                shift 2
                ;;
            -h|--help)
                usage
                ;;
            -*)
                error "Unknown option: $1"
                usage
                ;;
            *)
                SOURCE_DIR="$1"
                shift
                ;;
        esac
    done
}

#######################################
# Validate inputs
#######################################
validate() {
    if [[ -z "$SOURCE_DIR" ]]; then
        error "Source directory is required"
        echo "Use -h for help"
        exit 1
    fi

    if [[ ! -d "$SOURCE_DIR" ]]; then
        error "Source directory does not exist: $SOURCE_DIR"
        exit 1
    fi

    if ! [[ "$KEEP_COUNT" =~ ^[0-9]+$ ]]; then
        error "Keep count must be a number: $KEEP_COUNT"
        exit 1
    fi
}

#######################################
# Create backup
#######################################
create_backup() {
    local timestamp=$(date +%Y%m%d_%H%M%S)
    local backup_file="${DEST_DIR}/${BACKUP_NAME}_${timestamp}.tar.gz"
    
    # Create destination directory if needed
    if [[ ! -d "$DEST_DIR" ]]; then
        info "Creating backup directory: $DEST_DIR"
        mkdir -p "$DEST_DIR"
    fi

    info "Creating backup of: $SOURCE_DIR"
    info "Backup file: $backup_file"
    
    # Create the backup
    if tar -czf "$backup_file" -C "$(dirname "$SOURCE_DIR")" "$(basename "$SOURCE_DIR")"; then
        local size=$(du -h "$backup_file" | cut -f1)
        info "Backup created successfully ($size)"
        echo "$backup_file"
        return 0
    else
        error "Backup failed!"
        return 1
    fi
}

#######################################
# Rotate old backups
#######################################
rotate_backups() {
    info "Checking for old backups to remove (keeping last $KEEP_COUNT)"
    
    # Get list of backups, sorted by date (oldest first)
    local backups
    backups=$(ls -1t "${DEST_DIR}/${BACKUP_NAME}"_*.tar.gz 2>/dev/null || true)
    
    if [[ -z "$backups" ]]; then
        info "No existing backups found"
        return 0
    fi
    
    local count=$(echo "$backups" | wc -l)
    local to_delete=$((count - KEEP_COUNT))
    
    if [[ $to_delete -gt 0 ]]; then
        info "Removing $to_delete old backup(s)"
        echo "$backups" | tail -n "$to_delete" | while read -r old_backup; do
            info "  Deleting: $(basename "$old_backup")"
            rm -f "$old_backup"
        done
    else
        info "No old backups to remove"
    fi
}

#######################################
# Main function
#######################################
main() {
    parse_args "$@"
    validate
    
    info "Starting backup process..."
    info "Source: $SOURCE_DIR"
    info "Destination: $DEST_DIR"
    
    if create_backup; then
        rotate_backups
        info "Backup process completed successfully!"
    else
        error "Backup process failed!"
        exit 1
    fi
}

# Run main
main "$@"
