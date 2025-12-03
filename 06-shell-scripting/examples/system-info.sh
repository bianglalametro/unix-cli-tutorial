#!/bin/bash
#
# system-info.sh - Display system information
#
# Description: Gathers and displays useful system information
#              including hardware, OS, network, and resource usage.
#
# Usage: ./system-info.sh [section]
#
# Sections: all, os, hardware, memory, disk, network, users
#

set -euo pipefail

# Colors for output
BOLD='\033[1m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

#######################################
# Print section header
#######################################
header() {
    echo -e "\n${BOLD}${BLUE}═══════════════════════════════════════${NC}"
    echo -e "${BOLD}${CYAN}  $1${NC}"
    echo -e "${BOLD}${BLUE}═══════════════════════════════════════${NC}"
}

#######################################
# Print key-value pair
#######################################
info_line() {
    local key="$1"
    local value="$2"
    printf "${GREEN}%-20s${NC} : %s\n" "$key" "$value"
}

#######################################
# Operating System Information
#######################################
show_os() {
    header "Operating System"
    
    # Get OS info
    if [[ -f /etc/os-release ]]; then
        source /etc/os-release
        info_line "Distribution" "${NAME:-Unknown}"
        info_line "Version" "${VERSION:-Unknown}"
    fi
    
    info_line "Kernel" "$(uname -r)"
    info_line "Architecture" "$(uname -m)"
    info_line "Hostname" "$(hostname)"
    info_line "Uptime" "$(uptime -p 2>/dev/null || uptime)"
    
    # Boot time
    if command -v who &>/dev/null; then
        info_line "Boot Time" "$(who -b | awk '{print $3, $4}')"
    fi
}

#######################################
# Hardware Information
#######################################
show_hardware() {
    header "Hardware Information"
    
    # CPU
    if [[ -f /proc/cpuinfo ]]; then
        local cpu_model=$(grep "model name" /proc/cpuinfo | head -1 | cut -d: -f2 | xargs)
        local cpu_cores=$(grep -c "processor" /proc/cpuinfo)
        info_line "CPU Model" "$cpu_model"
        info_line "CPU Cores" "$cpu_cores"
    fi
    
    # Load average
    info_line "Load Average" "$(cat /proc/loadavg | awk '{print $1, $2, $3}')"
    
    # RAM
    if command -v free &>/dev/null; then
        local total_ram=$(free -h | awk '/^Mem:/ {print $2}')
        info_line "Total RAM" "$total_ram"
    fi
    
    # GPU (if available)
    if command -v lspci &>/dev/null; then
        local gpu=$(lspci 2>/dev/null | grep -i 'vga\|3d' | head -1 | cut -d: -f3 | xargs)
        if [[ -n "$gpu" ]]; then
            info_line "GPU" "$gpu"
        fi
    fi
}

#######################################
# Memory Information
#######################################
show_memory() {
    header "Memory Usage"
    
    if command -v free &>/dev/null; then
        echo ""
        free -h
        echo ""
        
        # Memory usage percentage
        local mem_info=$(free | awk '/^Mem:/ {printf "%.1f%%", $3/$2 * 100}')
        info_line "Memory Used" "$mem_info"
        
        # Swap usage
        local swap_info=$(free | awk '/^Swap:/ {if($2>0) printf "%.1f%%", $3/$2 * 100; else print "N/A"}')
        info_line "Swap Used" "$swap_info"
    fi
    
    # Top memory consumers
    echo -e "\n${YELLOW}Top 5 Memory Consumers:${NC}"
    ps aux --sort=-%mem 2>/dev/null | head -6 | awk 'NR==1 {print; next} {printf "%-10s %5s%% %s\n", $1, $4, $11}'
}

#######################################
# Disk Information
#######################################
show_disk() {
    header "Disk Usage"
    
    if command -v df &>/dev/null; then
        echo ""
        df -h --type=ext4 --type=xfs --type=btrfs 2>/dev/null || df -h | grep -E '^/dev/'
        echo ""
    fi
    
    # Largest directories (if in home)
    if [[ -d "$HOME" ]]; then
        echo -e "${YELLOW}Largest directories in $HOME:${NC}"
        du -h "$HOME" --max-depth=1 2>/dev/null | sort -rh | head -5
    fi
}

#######################################
# Network Information
#######################################
show_network() {
    header "Network Information"
    
    info_line "Hostname" "$(hostname)"
    
    # Get IP addresses
    if command -v ip &>/dev/null; then
        local ips=$(ip -4 addr show | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | grep -v '127.0.0.1' | tr '\n' ' ')
        info_line "IP Address(es)" "$ips"
    elif command -v hostname &>/dev/null; then
        info_line "IP Address" "$(hostname -I 2>/dev/null | awk '{print $1}')"
    fi
    
    # External IP (if curl available)
    if command -v curl &>/dev/null; then
        local external_ip=$(curl -s --max-time 5 https://api.ipify.org 2>/dev/null || echo "N/A")
        info_line "External IP" "$external_ip"
    fi
    
    # DNS servers
    if [[ -f /etc/resolv.conf ]]; then
        local dns=$(grep nameserver /etc/resolv.conf | awk '{print $2}' | tr '\n' ' ')
        info_line "DNS Servers" "$dns"
    fi
    
    # Network interfaces
    echo -e "\n${YELLOW}Network Interfaces:${NC}"
    if command -v ip &>/dev/null; then
        ip -br link show 2>/dev/null || ip link show
    fi
}

#######################################
# User Information
#######################################
show_users() {
    header "User Information"
    
    info_line "Current User" "$USER"
    info_line "User ID" "$(id -u)"
    info_line "Groups" "$(id -Gn | tr ' ' ',')"
    info_line "Home Directory" "$HOME"
    info_line "Shell" "$SHELL"
    
    # Logged in users
    echo -e "\n${YELLOW}Currently Logged In:${NC}"
    who 2>/dev/null || users
    
    # Last logins
    echo -e "\n${YELLOW}Recent Logins:${NC}"
    last -n 5 2>/dev/null | head -5
}

#######################################
# Show all information
#######################################
show_all() {
    show_os
    show_hardware
    show_memory
    show_disk
    show_network
    show_users
}

#######################################
# Print usage
#######################################
usage() {
    cat << EOF
Usage: $(basename "$0") [section]

Display system information.

Sections:
    all       Show all information (default)
    os        Operating system info
    hardware  Hardware information
    memory    Memory usage
    disk      Disk usage
    network   Network information
    users     User information

Examples:
    $(basename "$0")
    $(basename "$0") memory
    $(basename "$0") network

EOF
    exit 0
}

#######################################
# Main
#######################################
main() {
    local section="${1:-all}"
    
    echo -e "${BOLD}${GREEN}"
    echo "╔════════════════════════════════════════╗"
    echo "║       SYSTEM INFORMATION REPORT        ║"
    echo "║       $(date '+%Y-%m-%d %H:%M:%S')              ║"
    echo "╚════════════════════════════════════════╝"
    echo -e "${NC}"
    
    case "$section" in
        all)      show_all ;;
        os)       show_os ;;
        hardware) show_hardware ;;
        memory)   show_memory ;;
        disk)     show_disk ;;
        network)  show_network ;;
        users)    show_users ;;
        -h|--help|help) usage ;;
        *)
            echo "Unknown section: $section"
            usage
            ;;
    esac
    
    echo -e "\n${GREEN}Report completed.${NC}"
}

main "$@"
