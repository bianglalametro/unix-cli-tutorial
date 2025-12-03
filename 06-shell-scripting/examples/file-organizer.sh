#!/bin/bash
#
# file-organizer.sh - Organize files by extension
#
# Description: Sorts files in a directory into subdirectories
#              based on their file extensions.
#
# Usage: ./file-organizer.sh [options] <directory>
#
# Options:
#   -d, --dry-run    Show what would be done without moving files
#   -v, --verbose    Show detailed output
#   -h, --help       Show this help message
#

set -euo pipefail

# Configuration
DRY_RUN=false
VERBOSE=false
TARGET_DIR=""

# File type categories
declare -A CATEGORIES=(
    # Images
    ["jpg"]="Images"
    ["jpeg"]="Images"
    ["png"]="Images"
    ["gif"]="Images"
    ["bmp"]="Images"
    ["svg"]="Images"
    ["webp"]="Images"
    ["ico"]="Images"
    
    # Documents
    ["pdf"]="Documents"
    ["doc"]="Documents"
    ["docx"]="Documents"
    ["txt"]="Documents"
    ["rtf"]="Documents"
    ["odt"]="Documents"
    ["md"]="Documents"
    
    # Spreadsheets
    ["xls"]="Spreadsheets"
    ["xlsx"]="Spreadsheets"
    ["csv"]="Spreadsheets"
    ["ods"]="Spreadsheets"
    
    # Presentations
    ["ppt"]="Presentations"
    ["pptx"]="Presentations"
    ["odp"]="Presentations"
    
    # Archives
    ["zip"]="Archives"
    ["tar"]="Archives"
    ["gz"]="Archives"
    ["rar"]="Archives"
    ["7z"]="Archives"
    ["bz2"]="Archives"
    ["xz"]="Archives"
    
    # Audio
    ["mp3"]="Audio"
    ["wav"]="Audio"
    ["flac"]="Audio"
    ["aac"]="Audio"
    ["ogg"]="Audio"
    ["wma"]="Audio"
    
    # Video
    ["mp4"]="Video"
    ["avi"]="Video"
    ["mkv"]="Video"
    ["mov"]="Video"
    ["wmv"]="Video"
    ["flv"]="Video"
    ["webm"]="Video"
    
    # Code
    ["py"]="Code"
    ["js"]="Code"
    ["html"]="Code"
    ["css"]="Code"
    ["java"]="Code"
    ["c"]="Code"
    ["cpp"]="Code"
    ["h"]="Code"
    ["sh"]="Code"
    ["rb"]="Code"
    ["php"]="Code"
    ["go"]="Code"
    ["rs"]="Code"
    
    # Data
    ["json"]="Data"
    ["xml"]="Data"
    ["yaml"]="Data"
    ["yml"]="Data"
    ["sql"]="Data"
    
    # Executables
    ["exe"]="Executables"
    ["msi"]="Executables"
    ["dmg"]="Executables"
    ["deb"]="Executables"
    ["rpm"]="Executables"
    ["AppImage"]="Executables"
)

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

#######################################
# Print messages
#######################################
info() { echo -e "${GREEN}[INFO]${NC} $*"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $*"; }
error() { echo -e "${RED}[ERROR]${NC} $*" >&2; }
verbose() { $VERBOSE && echo -e "${BLUE}[DEBUG]${NC} $*" || true; }

#######################################
# Display usage
#######################################
usage() {
    cat << EOF
Usage: $(basename "$0") [options] <directory>

Organize files into subdirectories by file extension.

Options:
    -d, --dry-run    Show what would be done without moving files
    -v, --verbose    Show detailed output
    -h, --help       Show this help message

Supported Categories:
    Images:        jpg, jpeg, png, gif, bmp, svg, webp
    Documents:     pdf, doc, docx, txt, rtf, odt, md
    Spreadsheets:  xls, xlsx, csv, ods
    Presentations: ppt, pptx, odp
    Archives:      zip, tar, gz, rar, 7z
    Audio:         mp3, wav, flac, aac, ogg
    Video:         mp4, avi, mkv, mov, wmv
    Code:          py, js, html, css, java, c, cpp, sh
    Data:          json, xml, yaml, yml, sql
    Executables:   exe, msi, dmg, deb, rpm

Examples:
    $(basename "$0") ~/Downloads
    $(basename "$0") -d ~/Downloads    # Dry run
    $(basename "$0") -v ~/Downloads    # Verbose

EOF
    exit 0
}

#######################################
# Parse command line arguments
#######################################
parse_args() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            -d|--dry-run)
                DRY_RUN=true
                shift
                ;;
            -v|--verbose)
                VERBOSE=true
                shift
                ;;
            -h|--help)
                usage
                ;;
            -*)
                error "Unknown option: $1"
                usage
                ;;
            *)
                TARGET_DIR="$1"
                shift
                ;;
        esac
    done
}

#######################################
# Get category for file extension
#######################################
get_category() {
    local ext="${1,,}"  # lowercase
    echo "${CATEGORIES[$ext]:-Other}"
}

#######################################
# Organize files
#######################################
organize_files() {
    local dir="$1"
    local moved=0
    local skipped=0
    local errors=0
    
    info "Organizing files in: $dir"
    $DRY_RUN && warn "DRY RUN MODE - No files will be moved"
    
    # Process each file
    for file in "$dir"/*; do
        # Skip if not a regular file
        [[ -f "$file" ]] || continue
        
        local filename=$(basename "$file")
        local extension="${filename##*.}"
        
        # Skip files without extension
        if [[ "$filename" == "$extension" ]]; then
            verbose "Skipping (no extension): $filename"
            ((skipped++))
            continue
        fi
        
        # Get category
        local category=$(get_category "$extension")
        local dest_dir="$dir/$category"
        local dest_file="$dest_dir/$filename"
        
        verbose "File: $filename -> $category/"
        
        # Handle duplicates
        if [[ -f "$dest_file" ]]; then
            local base="${filename%.*}"
            local counter=1
            while [[ -f "$dest_dir/${base}_${counter}.${extension}" ]]; do
                ((counter++))
            done
            dest_file="$dest_dir/${base}_${counter}.${extension}"
            verbose "Renamed to avoid conflict: ${base}_${counter}.${extension}"
        fi
        
        # Move or simulate
        if $DRY_RUN; then
            echo "Would move: $filename -> $category/"
        else
            # Create directory if needed
            if [[ ! -d "$dest_dir" ]]; then
                mkdir -p "$dest_dir"
                info "Created directory: $category/"
            fi
            
            if mv "$file" "$dest_file" 2>/dev/null; then
                $VERBOSE && info "Moved: $filename -> $category/"
                ((moved++))
            else
                error "Failed to move: $filename"
                ((errors++))
            fi
        fi
    done
    
    # Summary
    echo ""
    info "Organization complete!"
    info "  Files moved: $moved"
    info "  Files skipped: $skipped"
    [[ $errors -gt 0 ]] && error "  Errors: $errors"
    
    return $errors
}

#######################################
# Show current organization
#######################################
show_summary() {
    local dir="$1"
    
    echo ""
    info "Directory summary:"
    for category_dir in "$dir"/*/; do
        [[ -d "$category_dir" ]] || continue
        local name=$(basename "$category_dir")
        local count=$(find "$category_dir" -maxdepth 1 -type f | wc -l)
        [[ $count -gt 0 ]] && echo "  $name: $count files"
    done
}

#######################################
# Main function
#######################################
main() {
    parse_args "$@"
    
    # Validate target directory
    if [[ -z "$TARGET_DIR" ]]; then
        error "Directory is required"
        echo "Use -h for help"
        exit 1
    fi
    
    if [[ ! -d "$TARGET_DIR" ]]; then
        error "Directory does not exist: $TARGET_DIR"
        exit 1
    fi
    
    # Organize files
    organize_files "$TARGET_DIR"
    
    # Show summary (not in dry run)
    $DRY_RUN || show_summary "$TARGET_DIR"
}

main "$@"
