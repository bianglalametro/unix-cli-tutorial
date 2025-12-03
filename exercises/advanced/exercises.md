# 🔴 Advanced Exercises

> Challenge yourself with complex real-world scenarios

---

## Exercise 1: Shell Scripting - Backup Script

### Objective
Create a fully functional backup script.

### Task
Write a script called `backup.sh` that:
1. Takes a source directory as an argument
2. Creates a timestamped backup archive
3. Validates the archive was created successfully
4. Logs the backup operation

### Requirements
- Handle missing arguments gracefully
- Use proper error handling
- Create backups in a specified backup directory

<details>
<summary>💡 Hints</summary>

- Use `$1` for the first argument
- `date +%Y%m%d_%H%M%S` for timestamp
- `tar -czvf` for creating archives
- Check `$?` for command success
</details>

<details>
<summary>✅ Solution</summary>

```bash
#!/bin/bash

# Backup script with error handling and logging

set -e

# Configuration
BACKUP_DIR="${BACKUP_DIR:-$HOME/backups}"
LOG_FILE="$BACKUP_DIR/backup.log"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

# Functions
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

error_exit() {
    echo -e "${RED}ERROR: $1${NC}" >&2
    log "ERROR: $1"
    exit 1
}

success() {
    echo -e "${GREEN}$1${NC}"
    log "$1"
}

usage() {
    echo "Usage: $0 <source_directory>"
    echo "Example: $0 /home/user/documents"
    exit 1
}

# Main
main() {
    # Check arguments
    [[ $# -eq 0 ]] && usage
    
    SOURCE_DIR="$1"
    
    # Validate source directory
    [[ ! -d "$SOURCE_DIR" ]] && error_exit "Source directory does not exist: $SOURCE_DIR"
    
    # Create backup directory if needed
    mkdir -p "$BACKUP_DIR"
    
    # Generate backup filename
    TIMESTAMP=$(date +%Y%m%d_%H%M%S)
    BASENAME=$(basename "$SOURCE_DIR")
    BACKUP_FILE="$BACKUP_DIR/${BASENAME}_${TIMESTAMP}.tar.gz"
    
    log "Starting backup of $SOURCE_DIR"
    
    # Create backup
    if tar -czvf "$BACKUP_FILE" -C "$(dirname "$SOURCE_DIR")" "$BASENAME" 2>/dev/null; then
        # Verify archive
        if tar -tzf "$BACKUP_FILE" >/dev/null 2>&1; then
            SIZE=$(du -h "$BACKUP_FILE" | cut -f1)
            success "Backup created successfully: $BACKUP_FILE ($SIZE)"
        else
            error_exit "Backup verification failed"
        fi
    else
        error_exit "Backup creation failed"
    fi
}

main "$@"
```

Save as `backup.sh`, make executable with `chmod +x backup.sh`, and run with `./backup.sh /path/to/directory`.
</details>

---

## Exercise 2: Log Monitoring Script

### Objective
Create a script that monitors a log file and alerts on specific patterns.

### Task
Write a script that:
1. Watches a log file for new entries
2. Filters for ERROR and WARNING messages
3. Sends alerts (prints to console with timestamp)
4. Counts occurrences of each error type

<details>
<summary>💡 Hints</summary>

- Use `tail -f` for watching files
- Use `grep` with `--line-buffered`
- Use associative arrays for counting (Bash 4+)
</details>

<details>
<summary>✅ Solution</summary>

```bash
#!/bin/bash

# Log monitor script

LOG_FILE="${1:-/var/log/syslog}"
ALERT_PATTERN="ERROR|WARNING|CRITICAL"

declare -A error_counts

# Check if log file exists
if [[ ! -f "$LOG_FILE" ]]; then
    echo "Log file not found: $LOG_FILE"
    exit 1
fi

echo "Monitoring $LOG_FILE for errors..."
echo "Press Ctrl+C to stop and see summary"
echo "---"

# Trap for cleanup and summary
cleanup() {
    echo ""
    echo "=== Summary ==="
    for type in "${!error_counts[@]}"; do
        echo "$type: ${error_counts[$type]}"
    done
    exit 0
}
trap cleanup SIGINT

# Monitor log file
tail -f "$LOG_FILE" | grep --line-buffered -E "$ALERT_PATTERN" | while read -r line; do
    timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] ALERT: $line"
    
    # Count error types
    if [[ "$line" =~ ERROR ]]; then
        ((error_counts[ERROR]++)) 2>/dev/null || error_counts[ERROR]=1
    elif [[ "$line" =~ WARNING ]]; then
        ((error_counts[WARNING]++)) 2>/dev/null || error_counts[WARNING]=1
    elif [[ "$line" =~ CRITICAL ]]; then
        ((error_counts[CRITICAL]++)) 2>/dev/null || error_counts[CRITICAL]=1
    fi
done
```
</details>

---

## Exercise 3: File Organization Script

### Objective
Create a script that organizes files by extension.

### Task
Write a script that:
1. Scans a directory for files
2. Creates subdirectories based on file extensions
3. Moves files to appropriate directories
4. Handles files without extensions
5. Provides a summary of actions taken

<details>
<summary>💡 Hints</summary>

- Use `${filename##*.}` to extract extension
- Check if filename equals extension (no extension case)
- Use associative arrays for counting
</details>

<details>
<summary>✅ Solution</summary>

```bash
#!/bin/bash

# File organizer script

set -e

SOURCE_DIR="${1:-.}"
DRY_RUN=false

# Parse options
while getopts "d" opt; do
    case $opt in
        d) DRY_RUN=true ;;
    esac
done
shift $((OPTIND-1))

SOURCE_DIR="${1:-.}"

# Validate directory
if [[ ! -d "$SOURCE_DIR" ]]; then
    echo "Directory not found: $SOURCE_DIR"
    exit 1
fi

declare -A file_counts
total_files=0
total_moved=0

echo "Organizing files in: $SOURCE_DIR"
[[ "$DRY_RUN" == true ]] && echo "(DRY RUN - no files will be moved)"
echo "---"

# Process each file
for file in "$SOURCE_DIR"/*; do
    # Skip if not a regular file
    [[ ! -f "$file" ]] && continue
    
    ((total_files++))
    
    filename=$(basename "$file")
    extension="${filename##*.}"
    
    # Handle files without extension
    if [[ "$filename" == "$extension" ]] || [[ -z "$extension" ]]; then
        extension="no_extension"
    fi
    
    # Convert to lowercase
    extension=$(echo "$extension" | tr '[:upper:]' '[:lower:]')
    
    # Create category directory
    target_dir="$SOURCE_DIR/$extension"
    
    if [[ "$DRY_RUN" == false ]]; then
        mkdir -p "$target_dir"
        mv "$file" "$target_dir/"
    fi
    
    # Count files
    ((file_counts[$extension]++)) 2>/dev/null || file_counts[$extension]=1
    ((total_moved++))
    
    echo "  $filename -> $extension/"
done

# Summary
echo ""
echo "=== Summary ==="
echo "Total files processed: $total_files"
echo ""
echo "Files by type:"
for ext in "${!file_counts[@]}"; do
    printf "  %-15s: %d\n" "$ext" "${file_counts[$ext]}"
done | sort

if [[ "$DRY_RUN" == true ]]; then
    echo ""
    echo "Run without -d to actually move files"
fi
```
</details>

---

## Exercise 4: System Health Check

### Objective
Create a comprehensive system health check script.

### Task
Write a script that reports on:
1. CPU usage
2. Memory usage
3. Disk usage
4. Top 5 processes by CPU
5. Top 5 processes by memory
6. Network connections

<details>
<summary>✅ Solution</summary>

```bash
#!/bin/bash

# System health check script

echo "=================================="
echo "    SYSTEM HEALTH CHECK"
echo "    $(date)"
echo "=================================="

# System info
echo ""
echo "--- SYSTEM INFO ---"
echo "Hostname: $(hostname)"
echo "Uptime: $(uptime -p)"
echo "Kernel: $(uname -r)"

# CPU Usage
echo ""
echo "--- CPU USAGE ---"
cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'%' -f1)
echo "Current CPU Usage: ${cpu_usage:-N/A}%"
echo ""
echo "Load Average: $(cat /proc/loadavg | awk '{print $1, $2, $3}')"

# Memory Usage
echo ""
echo "--- MEMORY USAGE ---"
free -h | awk '
    NR==1 {print $1, $2, $3, $4}
    NR==2 {
        printf "RAM:  Total: %s | Used: %s | Free: %s\n", $2, $3, $4
    }
    NR==3 {
        printf "Swap: Total: %s | Used: %s | Free: %s\n", $2, $3, $4
    }
'

# Disk Usage
echo ""
echo "--- DISK USAGE ---"
df -h | awk '
    NR==1 {printf "%-20s %10s %10s %10s %6s\n", "Filesystem", "Size", "Used", "Avail", "Use%"}
    NR>1 && $1 !~ /tmpfs|udev/ {printf "%-20s %10s %10s %10s %6s\n", $1, $2, $3, $4, $5}
'

# Top processes by CPU
echo ""
echo "--- TOP 5 PROCESSES BY CPU ---"
ps aux --sort=-%cpu | head -6 | awk '
    NR==1 {printf "%-10s %6s %6s %s\n", "USER", "%CPU", "%MEM", "COMMAND"}
    NR>1 {printf "%-10s %6s %6s %s\n", $1, $3, $4, $11}
'

# Top processes by memory
echo ""
echo "--- TOP 5 PROCESSES BY MEMORY ---"
ps aux --sort=-%mem | head -6 | awk '
    NR==1 {printf "%-10s %6s %6s %s\n", "USER", "%CPU", "%MEM", "COMMAND"}
    NR>1 {printf "%-10s %6s %6s %s\n", $1, $3, $4, $11}
'

# Network connections
echo ""
echo "--- NETWORK CONNECTIONS ---"
if command -v ss &> /dev/null; then
    echo "Listening ports:"
    ss -tuln | grep LISTEN | head -10
else
    echo "Listening ports:"
    netstat -tuln | grep LISTEN | head -10
fi

echo ""
echo "=================================="
echo "    Health check complete"
echo "=================================="
```
</details>

---

## Exercise 5: Advanced Text Processing

### Objective
Solve complex text processing problems using command pipelines.

### Setup
```bash
mkdir -p ~/practice-advanced
cd ~/practice-advanced
cat > sales.csv << 'EOF'
date,product,region,quantity,price
2023-01-15,Widget A,North,100,25.99
2023-01-15,Widget B,South,50,35.99
2023-01-16,Widget A,East,75,25.99
2023-01-16,Widget C,North,200,15.99
2023-01-17,Widget B,West,30,35.99
2023-01-17,Widget A,South,120,25.99
2023-01-18,Widget C,East,80,15.99
2023-01-18,Widget A,North,90,25.99
2023-01-19,Widget B,North,45,35.99
2023-01-19,Widget C,South,150,15.99
EOF
```

### Tasks

1. **Calculate total revenue by product**
   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   awk -F',' 'NR>1 {
       revenue[$2] += $4 * $5
   } END {
       for (product in revenue) {
           printf "%s: $%.2f\n", product, revenue[product]
       }
   }' sales.csv | sort -t'$' -k2 -rn
   ```
   </details>

2. **Find the best-selling day (by total quantity)**
   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   awk -F',' 'NR>1 {
       qty[$1] += $4
   } END {
       for (date in qty) {
           print date, qty[date]
       }
   }' sales.csv | sort -k2 -rn | head -1
   ```
   </details>

3. **Calculate total revenue by region**
   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   awk -F',' 'NR>1 {
       revenue[$3] += $4 * $5
   } END {
       for (region in revenue) {
           printf "%s: $%.2f\n", region, revenue[region]
       }
   }' sales.csv
   ```
   </details>

4. **Generate a formatted sales report**
   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   awk -F',' '
   BEGIN {
       printf "%-12s %-12s %-8s %8s %10s %12s\n", 
              "Date", "Product", "Region", "Qty", "Price", "Revenue"
       print "--------------------------------------------------------------"
   }
   NR>1 {
       revenue = $4 * $5
       total += revenue
       printf "%-12s %-12s %-8s %8d %10.2f %12.2f\n", 
              $1, $2, $3, $4, $5, revenue
   }
   END {
       print "--------------------------------------------------------------"
       printf "%50s %12.2f\n", "TOTAL:", total
   }' sales.csv
   ```
   </details>

---

## Exercise 6: Create a Command-Line Tool

### Objective
Create a useful command-line tool with proper argument parsing.

### Task
Create a tool called `finder` that:
1. Searches for files by name, type, or content
2. Supports multiple search modes
3. Has proper help documentation
4. Uses colors for output

<details>
<summary>✅ Solution</summary>

```bash
#!/bin/bash

# finder - A friendly file search tool

VERSION="1.0.0"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'

usage() {
    cat << EOF
${GREEN}finder${NC} - A friendly file search tool (v${VERSION})

${YELLOW}USAGE:${NC}
    finder [OPTIONS] <pattern> [directory]

${YELLOW}OPTIONS:${NC}
    -n, --name      Search by filename (default)
    -c, --content   Search file contents
    -t, --type      Search by file type (f=file, d=directory)
    -i, --ignore    Case insensitive search
    -m, --max       Maximum depth to search
    -h, --help      Show this help message

${YELLOW}EXAMPLES:${NC}
    finder "*.py"               Find Python files
    finder -c "TODO" ./src      Search for TODO in src
    finder -t d backup          Find directories named backup
    finder -i readme            Case-insensitive search for readme

EOF
    exit 0
}

# Defaults
SEARCH_MODE="name"
CASE_INSENSITIVE=""
MAX_DEPTH=""
SEARCH_DIR="."

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -n|--name)
            SEARCH_MODE="name"
            shift
            ;;
        -c|--content)
            SEARCH_MODE="content"
            shift
            ;;
        -t|--type)
            SEARCH_MODE="type"
            FILE_TYPE="$2"
            shift 2
            ;;
        -i|--ignore)
            CASE_INSENSITIVE="-i"
            shift
            ;;
        -m|--max)
            MAX_DEPTH="-maxdepth $2"
            shift 2
            ;;
        -h|--help)
            usage
            ;;
        -*)
            echo -e "${RED}Unknown option: $1${NC}"
            exit 1
            ;;
        *)
            if [[ -z "$PATTERN" ]]; then
                PATTERN="$1"
            else
                SEARCH_DIR="$1"
            fi
            shift
            ;;
    esac
done

# Validate
if [[ -z "$PATTERN" ]]; then
    echo -e "${RED}Error: No search pattern provided${NC}"
    usage
fi

if [[ ! -d "$SEARCH_DIR" ]]; then
    echo -e "${RED}Error: Directory not found: $SEARCH_DIR${NC}"
    exit 1
fi

# Search functions
search_by_name() {
    echo -e "${BLUE}Searching for files matching: $PATTERN${NC}"
    echo "---"
    
    if [[ -n "$CASE_INSENSITIVE" ]]; then
        find "$SEARCH_DIR" $MAX_DEPTH -iname "$PATTERN" 2>/dev/null
    else
        find "$SEARCH_DIR" $MAX_DEPTH -name "$PATTERN" 2>/dev/null
    fi
}

search_by_content() {
    echo -e "${BLUE}Searching for content: $PATTERN${NC}"
    echo "---"
    
    grep -rn $CASE_INSENSITIVE "$PATTERN" "$SEARCH_DIR" 2>/dev/null | \
    while IFS=: read -r file line content; do
        echo -e "${GREEN}$file${NC}:${YELLOW}$line${NC}: $content"
    done
}

search_by_type() {
    echo -e "${BLUE}Searching for type '$FILE_TYPE' named: $PATTERN${NC}"
    echo "---"
    
    if [[ -n "$CASE_INSENSITIVE" ]]; then
        find "$SEARCH_DIR" $MAX_DEPTH -type "$FILE_TYPE" -iname "*$PATTERN*" 2>/dev/null
    else
        find "$SEARCH_DIR" $MAX_DEPTH -type "$FILE_TYPE" -name "*$PATTERN*" 2>/dev/null
    fi
}

# Execute search
case $SEARCH_MODE in
    name)
        search_by_name
        ;;
    content)
        search_by_content
        ;;
    type)
        search_by_type
        ;;
esac
```
</details>

---

## Exercise 7: Data Analysis Pipeline

### Objective
Create a complete data analysis pipeline using shell commands.

### Setup
```bash
cd ~/practice-advanced
# Generate sample web access log
for i in {1..1000}; do
    ip="192.168.$((RANDOM%255)).$((RANDOM%255))"
    status=$((RANDOM%3 == 0 ? 404 : 200))
    page="/page$((RANDOM%10)).html"
    bytes=$((RANDOM*10))
    echo "$ip - - [01/Dec/2023:10:$((RANDOM%60)):$((RANDOM%60))] \"GET $page HTTP/1.1\" $status $bytes"
done > web_access.log
```

### Tasks

Create a script that analyzes the log and produces a report showing:
1. Total number of requests
2. Requests by status code
3. Top 10 IP addresses by request count
4. Top 5 most accessed pages
5. Total bandwidth transferred

<details>
<summary>✅ Solution</summary>

```bash
#!/bin/bash

# Web log analyzer

LOG_FILE="${1:-web_access.log}"

if [[ ! -f "$LOG_FILE" ]]; then
    echo "Log file not found: $LOG_FILE"
    exit 1
fi

echo "=================================="
echo "   WEB ACCESS LOG ANALYSIS"
echo "   File: $LOG_FILE"
echo "=================================="

# Total requests
total=$(wc -l < "$LOG_FILE")
echo ""
echo "Total Requests: $total"

# Requests by status
echo ""
echo "--- REQUESTS BY STATUS CODE ---"
awk '{print $9}' "$LOG_FILE" | sort | uniq -c | sort -rn | \
while read count code; do
    pct=$(echo "scale=1; $count * 100 / $total" | bc)
    printf "  %s: %6d (%5.1f%%)\n" "$code" "$count" "$pct"
done

# Top 10 IPs
echo ""
echo "--- TOP 10 IP ADDRESSES ---"
awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -rn | head -10 | \
while read count ip; do
    printf "  %-15s: %6d requests\n" "$ip" "$count"
done

# Top 5 pages
echo ""
echo "--- TOP 5 PAGES ---"
awk '{print $7}' "$LOG_FILE" | sort | uniq -c | sort -rn | head -5 | \
while read count page; do
    printf "  %-20s: %6d requests\n" "$page" "$count"
done

# Total bandwidth
echo ""
echo "--- BANDWIDTH ---"
total_bytes=$(awk '{sum+=$10} END {print sum}' "$LOG_FILE")
if [[ $total_bytes -gt 1073741824 ]]; then
    printf "Total transferred: %.2f GB\n" $(echo "scale=2; $total_bytes/1073741824" | bc)
elif [[ $total_bytes -gt 1048576 ]]; then
    printf "Total transferred: %.2f MB\n" $(echo "scale=2; $total_bytes/1048576" | bc)
else
    printf "Total transferred: %.2f KB\n" $(echo "scale=2; $total_bytes/1024" | bc)
fi

# Error analysis
echo ""
echo "--- ERROR ANALYSIS ---"
errors=$(awk '$9 >= 400' "$LOG_FILE" | wc -l)
error_pct=$(echo "scale=1; $errors * 100 / $total" | bc)
echo "Total errors: $errors ($error_pct%)"

echo ""
echo "=================================="
```
</details>

---

## 🏆 Final Project: Deployment Script

### Objective
Create a complete deployment script for a web application.

### Requirements
The script should:
1. Check system requirements
2. Backup current deployment
3. Pull latest code (simulated)
4. Run tests (simulated)
5. Deploy new version
6. Verify deployment
7. Rollback on failure
8. Send notification (simulated)

<details>
<summary>✅ Solution</summary>

```bash
#!/bin/bash

# Deployment script with rollback capability

set -e

# Configuration
APP_NAME="myapp"
DEPLOY_DIR="/tmp/deploy_test"
BACKUP_DIR="/tmp/deploy_backups"
LOG_FILE="/tmp/deploy.log"
VERSION="1.0.$RANDOM"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Logging
log() {
    echo -e "${BLUE}[$(date '+%H:%M:%S')]${NC} $1"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

success() {
    echo -e "${GREEN}✓${NC} $1"
    log "SUCCESS: $1"
}

warn() {
    echo -e "${YELLOW}⚠${NC} $1"
    log "WARNING: $1"
}

error() {
    echo -e "${RED}✗${NC} $1"
    log "ERROR: $1"
}

# Check requirements
check_requirements() {
    log "Checking system requirements..."
    
    # Check disk space
    available=$(df -BM /tmp | awk 'NR==2 {print $4}' | tr -d 'M')
    if [[ $available -lt 100 ]]; then
        error "Insufficient disk space: ${available}MB available, 100MB required"
        return 1
    fi
    success "Disk space OK: ${available}MB available"
    
    # Check required commands
    for cmd in tar gzip; do
        if ! command -v $cmd &> /dev/null; then
            error "Required command not found: $cmd"
            return 1
        fi
    done
    success "Required commands available"
    
    return 0
}

# Create backup
create_backup() {
    log "Creating backup..."
    
    mkdir -p "$BACKUP_DIR"
    
    if [[ -d "$DEPLOY_DIR" ]]; then
        backup_name="${APP_NAME}_backup_$(date +%Y%m%d_%H%M%S).tar.gz"
        tar -czvf "$BACKUP_DIR/$backup_name" -C "$(dirname $DEPLOY_DIR)" "$(basename $DEPLOY_DIR)" 2>/dev/null
        success "Backup created: $backup_name"
        echo "$BACKUP_DIR/$backup_name"
    else
        warn "No existing deployment to backup"
        echo ""
    fi
}

# Simulate pulling code
pull_code() {
    log "Pulling latest code (v$VERSION)..."
    
    mkdir -p "$DEPLOY_DIR"
    
    # Simulate code pull
    sleep 1
    echo "Version: $VERSION" > "$DEPLOY_DIR/version.txt"
    echo "<?php echo 'Hello World'; ?>" > "$DEPLOY_DIR/index.php"
    mkdir -p "$DEPLOY_DIR/css" "$DEPLOY_DIR/js"
    touch "$DEPLOY_DIR/css/style.css"
    touch "$DEPLOY_DIR/js/app.js"
    
    success "Code pulled successfully"
}

# Simulate tests
run_tests() {
    log "Running tests..."
    
    # Simulate test execution
    sleep 1
    
    # Random test failure for demonstration
    if [[ $((RANDOM % 10)) -eq 0 ]]; then
        error "Tests failed!"
        return 1
    fi
    
    success "All tests passed"
    return 0
}

# Deploy
deploy() {
    log "Deploying version $VERSION..."
    
    # Simulate deployment steps
    sleep 1
    
    # Set permissions
    chmod -R 755 "$DEPLOY_DIR"
    
    success "Deployment complete"
}

# Verify deployment
verify_deployment() {
    log "Verifying deployment..."
    
    # Check files exist
    if [[ -f "$DEPLOY_DIR/version.txt" ]] && [[ -f "$DEPLOY_DIR/index.php" ]]; then
        deployed_version=$(cat "$DEPLOY_DIR/version.txt")
        success "Deployment verified: $deployed_version"
        return 0
    else
        error "Deployment verification failed"
        return 1
    fi
}

# Rollback
rollback() {
    local backup_file="$1"
    
    log "Rolling back to previous version..."
    
    if [[ -z "$backup_file" ]] || [[ ! -f "$backup_file" ]]; then
        error "No backup file available for rollback"
        return 1
    fi
    
    rm -rf "$DEPLOY_DIR"
    tar -xzvf "$backup_file" -C "$(dirname $DEPLOY_DIR)" 2>/dev/null
    
    success "Rollback completed"
}

# Send notification (simulated)
notify() {
    local status="$1"
    local message="$2"
    
    log "Sending notification: [$status] $message"
    # In real scenario, this would send email/Slack/etc.
}

# Main deployment flow
main() {
    echo ""
    echo "=================================="
    echo "  DEPLOYMENT: $APP_NAME v$VERSION"
    echo "=================================="
    echo ""
    
    # Step 1: Check requirements
    if ! check_requirements; then
        notify "FAILED" "Requirement check failed"
        exit 1
    fi
    
    # Step 2: Create backup
    backup_file=$(create_backup)
    
    # Step 3: Pull code
    if ! pull_code; then
        notify "FAILED" "Code pull failed"
        exit 1
    fi
    
    # Step 4: Run tests
    if ! run_tests; then
        warn "Tests failed, rolling back..."
        rollback "$backup_file"
        notify "FAILED" "Tests failed, rolled back"
        exit 1
    fi
    
    # Step 5: Deploy
    if ! deploy; then
        warn "Deployment failed, rolling back..."
        rollback "$backup_file"
        notify "FAILED" "Deployment failed, rolled back"
        exit 1
    fi
    
    # Step 6: Verify
    if ! verify_deployment; then
        warn "Verification failed, rolling back..."
        rollback "$backup_file"
        notify "FAILED" "Verification failed, rolled back"
        exit 1
    fi
    
    # Success!
    echo ""
    echo "=================================="
    echo -e "  ${GREEN}DEPLOYMENT SUCCESSFUL${NC}"
    echo "  Version: $VERSION"
    echo "  Location: $DEPLOY_DIR"
    echo "=================================="
    
    notify "SUCCESS" "Deployed $APP_NAME v$VERSION"
}

main "$@"
```
</details>

---

## 🧹 Cleanup

```bash
cd ~
rm -rf ~/practice-advanced
rm -rf /tmp/deploy_test /tmp/deploy_backups /tmp/deploy.log
```

---

## ✅ Completion Checklist

- [ ] I can create shell scripts with proper error handling
- [ ] I can implement backup and restore functionality
- [ ] I can process and analyze log files
- [ ] I can create command-line tools with argument parsing
- [ ] I can build data processing pipelines
- [ ] I understand deployment automation concepts

---

**Congratulations on completing the advanced exercises! 🎉**

You're now equipped with skills that are valuable for:
- DevOps and System Administration
- Data Engineering
- Software Development
- Technical Operations
