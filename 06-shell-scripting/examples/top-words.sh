#!/bin/bash
#
# top-words.sh - Find the most frequent words in text files
#
# Description: Analyzes text files and displays the most
#              frequently occurring words.
#
# Usage: ./top-words.sh [options] <file>...
#
# Options:
#   -n, --number N     Number of top words to show (default: 10)
#   -m, --min-length N Minimum word length (default: 3)
#   -i, --ignore-case  Case insensitive counting
#   -s, --stopwords    Exclude common stopwords
#   -h, --help         Show this help message
#

set -euo pipefail

# Configuration
TOP_COUNT=10
MIN_LENGTH=3
IGNORE_CASE=false
EXCLUDE_STOPWORDS=false
FILES=()

# Common English stopwords
STOPWORDS="the a an and or but in on at to for of is it that this with as by from are was were be been being have has had do does did will would could should may might must shall can"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

#######################################
# Display usage
#######################################
usage() {
    cat << EOF
Usage: $(basename "$0") [options] <file>...

Find the most frequent words in text files.

Options:
    -n, --number N     Number of top words to show (default: 10)
    -m, --min-length N Minimum word length (default: 3)
    -i, --ignore-case  Case insensitive counting
    -s, --stopwords    Exclude common stopwords
    -h, --help         Show this help message

Examples:
    $(basename "$0") document.txt
    $(basename "$0") -n 20 book.txt
    $(basename "$0") -i -s -n 15 *.txt
    cat file.txt | $(basename "$0") -

EOF
    exit 0
}

#######################################
# Parse command line arguments
#######################################
parse_args() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            -n|--number)
                TOP_COUNT="$2"
                shift 2
                ;;
            -m|--min-length)
                MIN_LENGTH="$2"
                shift 2
                ;;
            -i|--ignore-case)
                IGNORE_CASE=true
                shift
                ;;
            -s|--stopwords)
                EXCLUDE_STOPWORDS=true
                shift
                ;;
            -h|--help)
                usage
                ;;
            -*)
                echo "Unknown option: $1" >&2
                usage
                ;;
            *)
                FILES+=("$1")
                shift
                ;;
        esac
    done
}

#######################################
# Build stopwords pattern for grep
#######################################
get_stopwords_pattern() {
    local pattern=""
    for word in $STOPWORDS; do
        [[ -n "$pattern" ]] && pattern+="|"
        pattern+="^${word}$"
    done
    echo "$pattern"
}

#######################################
# Process text and count words
#######################################
count_words() {
    local input="$1"
    
    # Start building the pipeline
    local cmd="cat"
    
    if [[ "$input" == "-" ]]; then
        cmd="cat -"
    else
        cmd="cat '$input'"
    fi
    
    # Build the pipeline
    local pipeline="$cmd"
    
    # Convert to lowercase if needed
    if $IGNORE_CASE; then
        pipeline+=" | tr '[:upper:]' '[:lower:]'"
    fi
    
    # Extract words (letters only)
    pipeline+=" | tr -cs '[:alpha:]' '\n'"
    
    # Filter by minimum length
    if [[ $MIN_LENGTH -gt 0 ]]; then
        pipeline+=" | grep -E '.{${MIN_LENGTH},}'"
    fi
    
    # Filter out stopwords
    if $EXCLUDE_STOPWORDS; then
        local pattern=$(get_stopwords_pattern)
        if $IGNORE_CASE; then
            pipeline+=" | grep -ivE '$pattern'"
        else
            pipeline+=" | grep -vE '$pattern'"
        fi
    fi
    
    # Sort and count
    pipeline+=" | sort | uniq -c | sort -rn | head -$TOP_COUNT"
    
    # Execute pipeline
    eval "$pipeline" 2>/dev/null || true
}

#######################################
# Print results
#######################################
print_results() {
    local title="$1"
    local results="$2"
    
    echo -e "\n${BLUE}═══════════════════════════════════════${NC}"
    echo -e "${GREEN}  Top $TOP_COUNT Words: $title${NC}"
    echo -e "${BLUE}═══════════════════════════════════════${NC}"
    
    if [[ -z "$results" ]]; then
        echo "  No words found matching criteria"
        return
    fi
    
    echo ""
    printf "  ${YELLOW}%-8s  %-15s${NC}\n" "Count" "Word"
    echo "  ────────────────────────"
    
    local rank=1
    while read -r count word; do
        printf "  %-8s  %-15s\n" "$count" "$word"
        ((rank++))
    done <<< "$results"
    
    echo ""
}

#######################################
# Print statistics
#######################################
print_stats() {
    local input="$1"
    
    local total_words total_unique
    
    if [[ "$input" == "-" ]]; then
        echo "  (Statistics not available for stdin)"
        return
    fi
    
    local text
    if $IGNORE_CASE; then
        text=$(cat "$input" | tr '[:upper:]' '[:lower:]' | tr -cs '[:alpha:]' '\n' | grep -E ".{${MIN_LENGTH},}" 2>/dev/null)
    else
        text=$(cat "$input" | tr -cs '[:alpha:]' '\n' | grep -E ".{${MIN_LENGTH},}" 2>/dev/null)
    fi
    
    total_words=$(echo "$text" | wc -l)
    total_unique=$(echo "$text" | sort -u | wc -l)
    
    echo -e "  ${YELLOW}Statistics:${NC}"
    echo "  Total words (min length $MIN_LENGTH): $total_words"
    echo "  Unique words: $total_unique"
}

#######################################
# Main function
#######################################
main() {
    parse_args "$@"
    
    # Check for input
    if [[ ${#FILES[@]} -eq 0 ]]; then
        # Check if stdin has data
        if [[ -t 0 ]]; then
            echo "No input files specified" >&2
            echo "Use -h for help" >&2
            exit 1
        else
            FILES=("-")
        fi
    fi
    
    echo -e "\n${GREEN}Word Frequency Analysis${NC}"
    echo "Settings: top=$TOP_COUNT, min_length=$MIN_LENGTH, ignore_case=$IGNORE_CASE, stopwords=$EXCLUDE_STOPWORDS"
    
    # Process each file
    for file in "${FILES[@]}"; do
        if [[ "$file" != "-" && ! -f "$file" ]]; then
            echo "File not found: $file" >&2
            continue
        fi
        
        local display_name="$file"
        [[ "$file" == "-" ]] && display_name="stdin"
        
        local results
        results=$(count_words "$file")
        
        print_results "$display_name" "$results"
        print_stats "$file"
    done
}

main "$@"
