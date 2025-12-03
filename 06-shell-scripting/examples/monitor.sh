#!/bin/bash
#
# monitor.sh - Simple system monitoring script
#
# Description: Monitors system resources and optionally alerts
#              when thresholds are exceeded.
#
# Usage: ./monitor.sh [options]
#
# Options:
#   -i, --interval N   Update interval in seconds (default: 5)
#   -c, --cpu N        CPU usage alert threshold (default: 80)
#   -m, --memory N     Memory usage alert threshold (default: 80)
#   -d, --disk N       Disk usage alert threshold (default: 90)
#   -o, --once         Run once and exit
#   -h, --help         Show this help message
#

set -euo pipefail

# Configuration
INTERVAL=5
CPU_THRESHOLD=80
MEM_THRESHOLD=80
DISK_THRESHOLD=90
RUN_ONCE=false

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

#######################################
# Display usage
#######################################
usage() {
    cat << EOF
Usage: $(basename "$0") [options]

Monitor system resources in real-time.

Options:
    -i, --interval N   Update interval in seconds (default: 5)
    -c, --cpu N        CPU usage alert threshold % (default: 80)
    -m, --memory N     Memory usage alert threshold % (default: 80)
    -d, --disk N       Disk usage alert threshold % (default: 90)
    -o, --once         Run once and exit
    -h, --help         Show this help message

Press Ctrl+C to exit.

Examples:
    $(basename "$0")
    $(basename "$0") -i 2 -c 90
    $(basename "$0") -o

EOF
    exit 0
}

#######################################
# Parse command line arguments
#######################################
parse_args() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            -i|--interval)
                INTERVAL="$2"
                shift 2
                ;;
            -c|--cpu)
                CPU_THRESHOLD="$2"
                shift 2
                ;;
            -m|--memory)
                MEM_THRESHOLD="$2"
                shift 2
                ;;
            -d|--disk)
                DISK_THRESHOLD="$2"
                shift 2
                ;;
            -o|--once)
                RUN_ONCE=true
                shift
                ;;
            -h|--help)
                usage
                ;;
            *)
                echo "Unknown option: $1" >&2
                usage
                ;;
        esac
    done
}

#######################################
# Get CPU usage
#######################################
get_cpu_usage() {
    # Get CPU usage from /proc/stat
    local cpu_line=$(head -1 /proc/stat)
    local cpu_values=($cpu_line)
    
    local user=${cpu_values[1]}
    local nice=${cpu_values[2]}
    local system=${cpu_values[3]}
    local idle=${cpu_values[4]}
    local iowait=${cpu_values[5]:-0}
    
    local total=$((user + nice + system + idle + iowait))
    local used=$((user + nice + system))
    
    # We need two samples to calculate usage
    # This is a simplified version - for better accuracy, compare two samples
    if command -v top &>/dev/null; then
        # Try to get from top (more accurate)
        top -bn1 | grep "Cpu(s)" | awk '{print int($2)}' 2>/dev/null || echo "0"
    else
        echo "0"
    fi
}

#######################################
# Get memory usage
#######################################
get_memory_usage() {
    if command -v free &>/dev/null; then
        free | awk '/^Mem:/ {printf "%.0f", $3/$2 * 100}'
    else
        echo "0"
    fi
}

#######################################
# Get disk usage
#######################################
get_disk_usage() {
    df / | awk 'NR==2 {gsub(/%/,"",$5); print $5}'
}

#######################################
# Get load average
#######################################
get_load_average() {
    awk '{print $1, $2, $3}' /proc/loadavg
}

#######################################
# Get top processes
#######################################
get_top_processes() {
    local type=$1
    local count=${2:-5}
    
    case $type in
        cpu)
            ps aux --sort=-%cpu | awk 'NR>1 && NR<='$((count+1))' {printf "%-15s %5.1f%%\n", $11, $3}'
            ;;
        mem)
            ps aux --sort=-%mem | awk 'NR>1 && NR<='$((count+1))' {printf "%-15s %5.1f%%\n", $11, $4}'
            ;;
    esac
}

#######################################
# Display colored percentage
#######################################
color_percent() {
    local value=$1
    local threshold=$2
    local warning=$((threshold - 10))
    
    if [[ $value -ge $threshold ]]; then
        echo -e "${RED}${value}%${NC}"
    elif [[ $value -ge $warning ]]; then
        echo -e "${YELLOW}${value}%${NC}"
    else
        echo -e "${GREEN}${value}%${NC}"
    fi
}

#######################################
# Create progress bar
#######################################
progress_bar() {
    local value=$1
    local threshold=$2
    local width=30
    local filled=$((value * width / 100))
    local empty=$((width - filled))
    
    local color=$GREEN
    [[ $value -ge $((threshold - 10)) ]] && color=$YELLOW
    [[ $value -ge $threshold ]] && color=$RED
    
    printf "${color}["
    printf '%*s' "$filled" | tr ' ' '█'
    printf '%*s' "$empty" | tr ' ' '░'
    printf "]${NC}"
}

#######################################
# Check for alerts
#######################################
check_alerts() {
    local cpu=$1
    local mem=$2
    local disk=$3
    local alerts=()
    
    [[ $cpu -ge $CPU_THRESHOLD ]] && alerts+=("CPU usage at ${cpu}%")
    [[ $mem -ge $MEM_THRESHOLD ]] && alerts+=("Memory usage at ${mem}%")
    [[ $disk -ge $DISK_THRESHOLD ]] && alerts+=("Disk usage at ${disk}%")
    
    if [[ ${#alerts[@]} -gt 0 ]]; then
        echo -e "\n${RED}${BOLD}⚠ ALERTS:${NC}"
        for alert in "${alerts[@]}"; do
            echo -e "  ${RED}• $alert${NC}"
        done
    fi
}

#######################################
# Display monitor
#######################################
display_monitor() {
    # Clear screen (only in continuous mode)
    $RUN_ONCE || clear
    
    # Header
    echo -e "${BOLD}${CYAN}"
    echo "╔════════════════════════════════════════════════════════════╗"
    echo "║              SYSTEM RESOURCE MONITOR                        ║"
    echo "╚════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
    
    # Timestamp
    echo -e "  ${BLUE}Time:${NC} $(date '+%Y-%m-%d %H:%M:%S')"
    echo -e "  ${BLUE}Host:${NC} $(hostname)"
    echo ""
    
    # Get values
    local cpu=$(get_cpu_usage)
    local mem=$(get_memory_usage)
    local disk=$(get_disk_usage)
    local load=$(get_load_average)
    
    # Display metrics
    echo -e "${BOLD}  RESOURCE USAGE${NC}"
    echo "  ────────────────────────────────────────────────"
    
    printf "  CPU:    "
    progress_bar "$cpu" "$CPU_THRESHOLD"
    printf " %s\n" "$(color_percent $cpu $CPU_THRESHOLD)"
    
    printf "  Memory: "
    progress_bar "$mem" "$MEM_THRESHOLD"
    printf " %s\n" "$(color_percent $mem $MEM_THRESHOLD)"
    
    printf "  Disk:   "
    progress_bar "$disk" "$DISK_THRESHOLD"
    printf " %s\n" "$(color_percent $disk $DISK_THRESHOLD)"
    
    echo ""
    echo -e "  ${BLUE}Load Average:${NC} $load"
    
    # Top processes
    echo ""
    echo -e "${BOLD}  TOP CPU CONSUMERS${NC}"
    echo "  ────────────────────────────────────────────────"
    get_top_processes cpu 5 | while read line; do
        echo "  $line"
    done
    
    echo ""
    echo -e "${BOLD}  TOP MEMORY CONSUMERS${NC}"
    echo "  ────────────────────────────────────────────────"
    get_top_processes mem 5 | while read line; do
        echo "  $line"
    done
    
    # Check for alerts
    check_alerts "$cpu" "$mem" "$disk"
    
    # Footer
    echo ""
    $RUN_ONCE || echo -e "  ${YELLOW}Press Ctrl+C to exit | Updating every ${INTERVAL}s${NC}"
}

#######################################
# Main function
#######################################
main() {
    parse_args "$@"
    
    # Trap Ctrl+C for clean exit
    trap 'echo -e "\n${GREEN}Monitoring stopped.${NC}"; exit 0' INT
    
    if $RUN_ONCE; then
        display_monitor
    else
        while true; do
            display_monitor
            sleep "$INTERVAL"
        done
    fi
}

main "$@"
