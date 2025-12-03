# Module 06 Exercises

Practice shell scripting fundamentals.

## 🟢 Beginner Exercises

### Exercise 1: Hello Script
Create a script that:
1. Prints "Hello, World!"
2. Shows the current date
3. Shows who is logged in

<details>
<summary>Solution</summary>

```bash
#!/bin/bash
# hello.sh

echo "Hello, World!"
echo "Today is: $(date)"
echo "You are: $USER"
echo "Logged in users: $(who | wc -l)"
```
</details>

---

### Exercise 2: Greeting Script
Create a script that takes a name as an argument and greets them. If no name is given, use "World".

<details>
<summary>Solution</summary>

```bash
#!/bin/bash
# greet.sh

NAME=${1:-"World"}
echo "Hello, $NAME!"
echo "Welcome to $(hostname)"
```

Usage:
```bash
./greet.sh         # Hello, World!
./greet.sh Alice   # Hello, Alice!
```
</details>

---

### Exercise 3: File Checker
Create a script that checks if a file exists and reports its type.

<details>
<summary>Solution</summary>

```bash
#!/bin/bash
# filecheck.sh

FILE=$1

if [[ -z "$FILE" ]]; then
    echo "Usage: $0 <filename>"
    exit 1
fi

if [[ ! -e "$FILE" ]]; then
    echo "File does not exist: $FILE"
    exit 1
fi

if [[ -f "$FILE" ]]; then
    echo "$FILE is a regular file"
    echo "Size: $(stat -c%s "$FILE") bytes"
elif [[ -d "$FILE" ]]; then
    echo "$FILE is a directory"
    echo "Contents: $(ls -1 "$FILE" | wc -l) items"
elif [[ -L "$FILE" ]]; then
    echo "$FILE is a symbolic link"
    echo "Points to: $(readlink "$FILE")"
fi
```
</details>

---

## 🟡 Intermediate Exercises

### Exercise 4: Calculator
Create a simple calculator that performs basic operations.

<details>
<summary>Solution</summary>

```bash
#!/bin/bash
# calc.sh

usage() {
    echo "Usage: $0 <num1> <operator> <num2>"
    echo "Operators: + - x / %"
    exit 1
}

[[ $# -ne 3 ]] && usage

NUM1=$1
OP=$2
NUM2=$3

case $OP in
    +)  echo "$NUM1 + $NUM2 = $((NUM1 + NUM2))" ;;
    -)  echo "$NUM1 - $NUM2 = $((NUM1 - NUM2))" ;;
    x|X|'*')  echo "$NUM1 x $NUM2 = $((NUM1 * NUM2))" ;;
    /)  
        if [[ $NUM2 -eq 0 ]]; then
            echo "Error: Division by zero"
            exit 1
        fi
        echo "$NUM1 / $NUM2 = $((NUM1 / NUM2))"
        ;;
    %)  echo "$NUM1 % $NUM2 = $((NUM1 % NUM2))" ;;
    *)  usage ;;
esac
```

Usage:
```bash
./calc.sh 10 + 5    # 10 + 5 = 15
./calc.sh 20 / 4    # 20 / 4 = 5
```
</details>

---

### Exercise 5: Countdown Timer
Create a countdown timer that counts down from a given number of seconds.

<details>
<summary>Solution</summary>

```bash
#!/bin/bash
# countdown.sh

SECONDS=${1:-10}

if ! [[ "$SECONDS" =~ ^[0-9]+$ ]]; then
    echo "Usage: $0 <seconds>"
    exit 1
fi

echo "Starting countdown from $SECONDS seconds..."

while [[ $SECONDS -gt 0 ]]; do
    printf "\r%02d:%02d" $((SECONDS/60)) $((SECONDS%60))
    sleep 1
    ((SECONDS--))
done

printf "\r00:00\n"
echo "Time's up!"

# Play a beep (if available)
echo -e "\a"
```
</details>

---

### Exercise 6: Directory Statistics
Create a script that shows statistics about a directory.

<details>
<summary>Solution</summary>

```bash
#!/bin/bash
# dirstats.sh

DIR=${1:-.}

if [[ ! -d "$DIR" ]]; then
    echo "Not a directory: $DIR"
    exit 1
fi

echo "Directory Statistics for: $DIR"
echo "=================================="

# Count files and directories
FILES=$(find "$DIR" -maxdepth 1 -type f | wc -l)
DIRS=$(find "$DIR" -maxdepth 1 -type d | wc -l)
DIRS=$((DIRS - 1))  # Exclude the directory itself

echo "Files: $FILES"
echo "Subdirectories: $DIRS"

# Total size
SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)
echo "Total size: $SIZE"

# Largest files
echo ""
echo "Largest files:"
find "$DIR" -maxdepth 1 -type f -exec ls -lh {} \; 2>/dev/null | 
    sort -k5 -h -r | 
    head -5 | 
    awk '{print "  " $9 " (" $5 ")"}'

# File types
echo ""
echo "File types:"
find "$DIR" -maxdepth 1 -type f -name "*.*" | 
    sed 's/.*\.//' | 
    sort | 
    uniq -c | 
    sort -rn | 
    head -5 |
    awk '{print "  ." $2 ": " $1}'
```
</details>

---

## 🔴 Advanced Exercises

### Exercise 7: Log Analyzer
Create a script that analyzes a log file and provides a summary.

<details>
<summary>Solution</summary>

```bash
#!/bin/bash
# loganalyzer.sh

LOG_FILE=$1

if [[ -z "$LOG_FILE" || ! -f "$LOG_FILE" ]]; then
    echo "Usage: $0 <logfile>"
    exit 1
fi

echo "Log Analysis Report"
echo "==================="
echo "File: $LOG_FILE"
echo "Generated: $(date)"
echo ""

# Basic stats
TOTAL_LINES=$(wc -l < "$LOG_FILE")
echo "Total lines: $TOTAL_LINES"

# Count by log level
echo ""
echo "By Log Level:"
for level in ERROR WARN INFO DEBUG; do
    COUNT=$(grep -c "$level" "$LOG_FILE" 2>/dev/null || echo 0)
    printf "  %-8s: %d\n" "$level" "$COUNT"
done

# Most recent errors
echo ""
echo "Recent Errors (last 5):"
grep "ERROR" "$LOG_FILE" | tail -5 | while read line; do
    echo "  $line"
done

# Hourly distribution (if timestamps are YYYY-MM-DD HH:MM:SS format)
echo ""
echo "Activity by Hour:"
grep -oE "[0-9]{2}:[0-9]{2}:[0-9]{2}" "$LOG_FILE" | 
    cut -d: -f1 | 
    sort | 
    uniq -c | 
    sort -k2 -n |
    while read count hour; do
        bar=$(printf '%*s' $((count/10)) | tr ' ' '#')
        printf "  %02d:00 | %-20s %d\n" "$hour" "$bar" "$count"
    done
```
</details>

---

### Exercise 8: Menu-Driven Program
Create an interactive menu-driven system administration tool.

<details>
<summary>Solution</summary>

```bash
#!/bin/bash
# adminmenu.sh

show_menu() {
    clear
    echo "╔════════════════════════════════════╗"
    echo "║     SYSTEM ADMIN MENU              ║"
    echo "╠════════════════════════════════════╣"
    echo "║  1. System Information             ║"
    echo "║  2. Disk Usage                     ║"
    echo "║  3. Memory Usage                   ║"
    echo "║  4. Process List                   ║"
    echo "║  5. Network Info                   ║"
    echo "║  6. User Sessions                  ║"
    echo "║  7. Exit                           ║"
    echo "╚════════════════════════════════════╝"
    echo ""
}

pause() {
    echo ""
    read -p "Press Enter to continue..."
}

system_info() {
    echo "System Information"
    echo "=================="
    echo "Hostname: $(hostname)"
    echo "OS: $(cat /etc/os-release 2>/dev/null | grep PRETTY_NAME | cut -d= -f2 | tr -d '"')"
    echo "Kernel: $(uname -r)"
    echo "Uptime: $(uptime -p)"
}

disk_usage() {
    echo "Disk Usage"
    echo "=========="
    df -h | grep -E '^/dev/'
}

memory_usage() {
    echo "Memory Usage"
    echo "============"
    free -h
}

process_list() {
    echo "Top 10 Processes by CPU"
    echo "========================"
    ps aux --sort=-%cpu | head -11
}

network_info() {
    echo "Network Information"
    echo "==================="
    echo "Interfaces:"
    ip -br addr 2>/dev/null || ifconfig
    echo ""
    echo "Listening Ports:"
    ss -tlnp 2>/dev/null | head -10 || netstat -tlnp 2>/dev/null | head -10
}

user_sessions() {
    echo "User Sessions"
    echo "============="
    who
    echo ""
    echo "Recent Logins:"
    last -n 5
}

# Main loop
while true; do
    show_menu
    read -p "Enter choice [1-7]: " choice
    echo ""
    
    case $choice in
        1) system_info; pause ;;
        2) disk_usage; pause ;;
        3) memory_usage; pause ;;
        4) process_list; pause ;;
        5) network_info; pause ;;
        6) user_sessions; pause ;;
        7) echo "Goodbye!"; exit 0 ;;
        *) echo "Invalid option"; pause ;;
    esac
done
```
</details>

---

### Exercise 9: Batch File Processor
Create a script that processes multiple files based on command line options.

<details>
<summary>Solution</summary>

```bash
#!/bin/bash
# batchprocess.sh

ACTION=""
EXTENSION=""
PREFIX=""
SUFFIX=""
DRY_RUN=false
FILES=()

usage() {
    cat << EOF
Usage: $0 [options] files...

Options:
    -u, --uppercase     Convert filenames to uppercase
    -l, --lowercase     Convert filenames to lowercase
    -e, --extension EXT Change extension to EXT
    -p, --prefix STR    Add prefix to filenames
    -s, --suffix STR    Add suffix before extension
    -d, --dry-run       Show what would be done
    -h, --help          Show this help

Examples:
    $0 -u *.txt
    $0 -e md *.txt
    $0 -p backup_ *.log
EOF
    exit 0
}

process_file() {
    local file=$1
    local dir=$(dirname "$file")
    local base=$(basename "$file")
    local name="${base%.*}"
    local ext="${base##*.}"
    [[ "$base" == "$ext" ]] && ext=""
    
    local newname="$name"
    local newext="$ext"
    
    # Apply transformations
    case $ACTION in
        upper) newname="${newname^^}" ;;
        lower) newname="${newname,,}" ;;
    esac
    
    [[ -n "$PREFIX" ]] && newname="${PREFIX}${newname}"
    [[ -n "$SUFFIX" ]] && newname="${newname}${SUFFIX}"
    [[ -n "$EXTENSION" ]] && newext="$EXTENSION"
    
    local newfile
    if [[ -n "$newext" ]]; then
        newfile="$dir/${newname}.${newext}"
    else
        newfile="$dir/${newname}"
    fi
    
    if [[ "$file" != "$newfile" ]]; then
        if $DRY_RUN; then
            echo "Would rename: $file -> $newfile"
        else
            mv -v "$file" "$newfile"
        fi
    fi
}

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -u|--uppercase) ACTION="upper"; shift ;;
        -l|--lowercase) ACTION="lower"; shift ;;
        -e|--extension) EXTENSION="$2"; shift 2 ;;
        -p|--prefix) PREFIX="$2"; shift 2 ;;
        -s|--suffix) SUFFIX="$2"; shift 2 ;;
        -d|--dry-run) DRY_RUN=true; shift ;;
        -h|--help) usage ;;
        -*) echo "Unknown option: $1"; usage ;;
        *) FILES+=("$1"); shift ;;
    esac
done

[[ ${#FILES[@]} -eq 0 ]] && { echo "No files specified"; usage; }

for file in "${FILES[@]}"; do
    [[ -f "$file" ]] && process_file "$file"
done
```
</details>

---

### Exercise 10: Service Monitor
Create a script that monitors services and restarts them if they're down.

<details>
<summary>Solution</summary>

```bash
#!/bin/bash
# servicemonitor.sh

SERVICES=("nginx" "mysql" "redis")
LOG_FILE="/tmp/servicemonitor.log"
CHECK_INTERVAL=60
MAX_RESTARTS=3

declare -A restart_counts

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $*" | tee -a "$LOG_FILE"
}

check_service() {
    local service=$1
    
    if systemctl is-active --quiet "$service" 2>/dev/null; then
        return 0
    fi
    return 1
}

restart_service() {
    local service=$1
    
    local count=${restart_counts[$service]:-0}
    
    if [[ $count -ge $MAX_RESTARTS ]]; then
        log "ALERT: $service has been restarted $count times. Manual intervention required."
        return 1
    fi
    
    log "Attempting to restart $service..."
    
    if sudo systemctl restart "$service" 2>/dev/null; then
        restart_counts[$service]=$((count + 1))
        log "Successfully restarted $service (restart #$((count + 1)))"
        return 0
    else
        log "ERROR: Failed to restart $service"
        return 1
    fi
}

monitor() {
    log "Service monitor started. Checking: ${SERVICES[*]}"
    
    while true; do
        for service in "${SERVICES[@]}"; do
            if ! check_service "$service"; then
                log "WARNING: $service is not running!"
                restart_service "$service"
            fi
        done
        
        sleep "$CHECK_INTERVAL"
    done
}

# Reset restart counts daily
reset_counts() {
    for service in "${SERVICES[@]}"; do
        restart_counts[$service]=0
    done
    log "Restart counts reset"
}

# Main
case "${1:-monitor}" in
    status)
        for service in "${SERVICES[@]}"; do
            if check_service "$service"; then
                echo "$service: ✓ Running"
            else
                echo "$service: ✗ Stopped"
            fi
        done
        ;;
    monitor)
        monitor
        ;;
    *)
        echo "Usage: $0 {status|monitor}"
        ;;
esac
```

Note: This script requires root privileges for restart functionality.
</details>

---

## 💡 Project Ideas

1. **Backup System**: Extend the backup script to support incremental backups and remote destinations

2. **Deployment Script**: Create a script that deploys code from a Git repository to a server

3. **Log Rotator**: Build a log rotation system with compression and retention policies

4. **System Health Reporter**: Create a daily health report that emails system statistics

5. **User Management Tool**: Build an interactive tool for adding, modifying, and removing users

---

## 🔗 Continue Learning

- [Module 07: Advanced Topics](../07-advanced-topics/)
- [Cheatsheets: Scripting](../cheatsheets/scripting-cheatsheet.md)
