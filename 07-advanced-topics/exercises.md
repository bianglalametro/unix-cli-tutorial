# Module 07 Exercises

Practice compression, conversion, and system information.

## 🟢 Beginner Exercises

### Exercise 1: Create Archives
1. Create a tar archive of a directory
2. Create a compressed tar.gz archive
3. List contents without extracting

<details>
<summary>Solution</summary>

```bash
# Create test directory
mkdir testdir
touch testdir/{file1,file2,file3}.txt

# 1. Create tar archive
tar -cvf archive.tar testdir/

# 2. Create compressed archive
tar -czvf archive.tar.gz testdir/

# 3. List contents
tar -tzvf archive.tar.gz
```
</details>

---

### Exercise 2: Extract Archives
1. Extract a tar.gz archive
2. Extract to a specific directory
3. Extract only specific files

<details>
<summary>Solution</summary>

```bash
# 1. Extract tar.gz
tar -xzvf archive.tar.gz

# 2. Extract to specific directory
mkdir extracted
tar -xzvf archive.tar.gz -C extracted/

# 3. Extract specific files
tar -xzvf archive.tar.gz testdir/file1.txt
```
</details>

---

### Exercise 3: System Information
1. Find your kernel version
2. Check available memory
3. Check disk space

<details>
<summary>Solution</summary>

```bash
# 1. Kernel version
uname -r

# 2. Available memory
free -h

# 3. Disk space
df -h
```
</details>

---

## 🟡 Intermediate Exercises

### Exercise 4: Zip Operations
1. Create a zip archive with multiple files
2. Create an encrypted zip file
3. Extract files from a zip archive

<details>
<summary>Solution</summary>

```bash
# Create test files
echo "content1" > file1.txt
echo "content2" > file2.txt

# 1. Create zip with multiple files
zip myarchive.zip file1.txt file2.txt

# 2. Create encrypted zip
zip -e secure.zip file1.txt
# (Enter password when prompted)

# 3. Extract zip
unzip myarchive.zip -d extracted/
```
</details>

---

### Exercise 5: Compression Comparison
Compare compression ratios of different methods on the same file.

<details>
<summary>Solution</summary>

```bash
# Create a test file
dd if=/dev/urandom of=testfile.bin bs=1M count=5 2>/dev/null

# Original size
ls -lh testfile.bin

# Test gzip
cp testfile.bin test_gzip.bin
gzip test_gzip.bin
ls -lh test_gzip.bin.gz

# Test bzip2
cp testfile.bin test_bzip2.bin
bzip2 test_bzip2.bin
ls -lh test_bzip2.bin.bz2

# Test xz
cp testfile.bin test_xz.bin
xz test_xz.bin
ls -lh test_xz.bin.xz

# Compare
echo "=== Comparison ==="
ls -lh testfile.bin test_*.gz test_*.bz2 test_*.xz 2>/dev/null

# Cleanup
rm -f testfile.bin test_*
```
</details>

---

### Exercise 6: Hardware Discovery
1. Find your CPU model
2. List PCI devices (find your graphics card)
3. Find your network interfaces

<details>
<summary>Solution</summary>

```bash
# 1. CPU model
lscpu | grep "Model name"
# or
cat /proc/cpuinfo | grep "model name" | head -1

# 2. Graphics card
lspci | grep -i vga
# or
lspci | grep -i "3D\|display\|graphics"

# 3. Network interfaces
ip link show
# or
ip -br addr
# or
ls /sys/class/net/
```
</details>

---

## 🔴 Advanced Exercises

### Exercise 7: Backup Script
Create a script that:
1. Creates a compressed backup of a directory
2. Adds a timestamp to the filename
3. Keeps only the last 3 backups

<details>
<summary>Solution</summary>

```bash
#!/bin/bash
# backup_exercise.sh

SOURCE_DIR="${1:-.}"
BACKUP_DIR="./backups"
KEEP_COUNT=3

# Create backup directory
mkdir -p "$BACKUP_DIR"

# Create timestamp
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

# Create backup
BACKUP_FILE="$BACKUP_DIR/backup_$TIMESTAMP.tar.gz"
tar -czvf "$BACKUP_FILE" "$SOURCE_DIR"

echo "Created: $BACKUP_FILE"

# Remove old backups
BACKUP_COUNT=$(ls -1 "$BACKUP_DIR"/backup_*.tar.gz 2>/dev/null | wc -l)
if [[ $BACKUP_COUNT -gt $KEEP_COUNT ]]; then
    ls -1t "$BACKUP_DIR"/backup_*.tar.gz | tail -n +$((KEEP_COUNT + 1)) | xargs rm -f
    echo "Removed old backups, keeping last $KEEP_COUNT"
fi

# List current backups
echo "Current backups:"
ls -lh "$BACKUP_DIR"/backup_*.tar.gz
```
</details>

---

### Exercise 8: System Report
Create a script that generates a system report including:
1. System hostname and OS
2. CPU information
3. Memory usage
4. Disk usage
5. Network interfaces

<details>
<summary>Solution</summary>

```bash
#!/bin/bash
# system_report.sh

REPORT_FILE="system_report_$(date +%Y%m%d).txt"

{
    echo "================================"
    echo "   SYSTEM REPORT"
    echo "   Generated: $(date)"
    echo "================================"
    echo ""
    
    echo "=== SYSTEM ==="
    echo "Hostname: $(hostname)"
    echo "OS: $(cat /etc/os-release 2>/dev/null | grep PRETTY_NAME | cut -d= -f2 | tr -d '"')"
    echo "Kernel: $(uname -r)"
    echo "Uptime: $(uptime -p)"
    echo ""
    
    echo "=== CPU ==="
    lscpu | grep -E "^(Model name|CPU\(s\)|Architecture)"
    echo ""
    
    echo "=== MEMORY ==="
    free -h
    echo ""
    
    echo "=== DISK ==="
    df -h | grep -E "^/dev/"
    echo ""
    
    echo "=== NETWORK ==="
    ip -br addr | grep -v "^lo"
    echo ""
    
    echo "=== TOP PROCESSES ==="
    ps aux --sort=-%cpu | head -6
    
} > "$REPORT_FILE"

echo "Report saved to: $REPORT_FILE"
cat "$REPORT_FILE"
```
</details>

---

### Exercise 9: Archive Inspector
Create a script that can:
1. Detect archive type
2. List contents
3. Extract to a specified location

<details>
<summary>Solution</summary>

```bash
#!/bin/bash
# archive_inspector.sh

ARCHIVE="$1"
ACTION="${2:-list}"
DEST="${3:-.}"

if [[ -z "$ARCHIVE" || ! -f "$ARCHIVE" ]]; then
    echo "Usage: $0 <archive> [list|extract] [destination]"
    exit 1
fi

# Detect type
case "$ARCHIVE" in
    *.tar.gz|*.tgz)
        TYPE="tar.gz"
        LIST_CMD="tar -tzvf"
        EXTRACT_CMD="tar -xzvf"
        ;;
    *.tar.bz2|*.tbz)
        TYPE="tar.bz2"
        LIST_CMD="tar -tjvf"
        EXTRACT_CMD="tar -xjvf"
        ;;
    *.tar.xz|*.txz)
        TYPE="tar.xz"
        LIST_CMD="tar -tJvf"
        EXTRACT_CMD="tar -xJvf"
        ;;
    *.tar)
        TYPE="tar"
        LIST_CMD="tar -tvf"
        EXTRACT_CMD="tar -xvf"
        ;;
    *.zip)
        TYPE="zip"
        LIST_CMD="unzip -l"
        EXTRACT_CMD="unzip"
        ;;
    *.gz)
        TYPE="gzip"
        LIST_CMD="gzip -l"
        EXTRACT_CMD="gunzip -k"
        ;;
    *)
        echo "Unknown archive type: $ARCHIVE"
        exit 1
        ;;
esac

echo "Archive: $ARCHIVE"
echo "Type: $TYPE"
echo ""

case "$ACTION" in
    list)
        $LIST_CMD "$ARCHIVE"
        ;;
    extract)
        if [[ "$TYPE" == "zip" ]]; then
            $EXTRACT_CMD "$ARCHIVE" -d "$DEST"
        elif [[ "$TYPE" == "gzip" ]]; then
            $EXTRACT_CMD "$ARCHIVE"
        else
            $EXTRACT_CMD "$ARCHIVE" -C "$DEST"
        fi
        ;;
    *)
        echo "Unknown action: $ACTION"
        exit 1
        ;;
esac
```
</details>

---

### Exercise 10: Disk Space Alert
Create a script that checks disk usage and alerts if it exceeds a threshold.

<details>
<summary>Solution</summary>

```bash
#!/bin/bash
# disk_alert.sh

THRESHOLD=${1:-80}

echo "Checking disk usage (threshold: ${THRESHOLD}%)..."
echo ""

ALERT=false

while read -r line; do
    # Skip header
    [[ "$line" =~ ^Filesystem ]] && continue
    
    # Parse values
    USAGE=$(echo "$line" | awk '{gsub(/%/,"",$5); print $5}')
    MOUNT=$(echo "$line" | awk '{print $6}')
    
    # Check threshold
    if [[ $USAGE -ge $THRESHOLD ]]; then
        echo "⚠️  ALERT: $MOUNT is at ${USAGE}% usage"
        ALERT=true
    else
        echo "✓ $MOUNT: ${USAGE}%"
    fi
done < <(df -h | grep "^/dev/")

echo ""
if $ALERT; then
    echo "❌ Some filesystems exceed threshold!"
    exit 1
else
    echo "✓ All filesystems within limits"
    exit 0
fi
```
</details>

---

## 💡 Tips

1. **Always test on sample data** before working with important files
2. **Use `-v` for verbose** output when learning
3. **Check available space** before extracting large archives
4. **Verify archives** with `-t` option before extraction

---

## 🔗 Continue Learning

- [Cheatsheets](../cheatsheets/)
- [Exercises](../exercises/)
- [Resources](../resources/)
