# Text Processing Commands

Transform and manipulate text with powerful commands.

## 📖 Table of Contents

- [grep - Search Patterns](#grep---search-patterns)
- [sed - Stream Editor](#sed---stream-editor)
- [awk - Pattern Processing](#awk---pattern-processing)
- [cut - Extract Columns](#cut---extract-columns)
- [sort - Sort Lines](#sort---sort-lines)
- [uniq - Remove Duplicates](#uniq---remove-duplicates)
- [tr - Translate Characters](#tr---translate-characters)
- [paste - Merge Files](#paste---merge-files)
- [Building Pipelines](#building-pipelines)

---

## grep - Search Patterns

Search for patterns in text.

### Basic Usage

```bash
$ grep "pattern" file.txt
$ grep "error" /var/log/syslog
```

### Common Options

| Option | Description |
|--------|-------------|
| `-i` | Case insensitive |
| `-v` | Invert match (lines NOT matching) |
| `-n` | Show line numbers |
| `-c` | Count matches |
| `-l` | List files with matches |
| `-r` | Recursive search |
| `-E` | Extended regex |
| `-o` | Only matching part |
| `-A N` | N lines after match |
| `-B N` | N lines before match |
| `-C N` | N lines around match |

### Examples

```bash
# Case insensitive
$ grep -i "error" log.txt

# Show line numbers
$ grep -n "TODO" code.py

# Count matches
$ grep -c "warning" log.txt

# Search recursively
$ grep -r "function" ./src

# Extended regex
$ grep -E "error|warning" log.txt

# Context around matches
$ grep -C 3 "exception" log.txt

# Files containing pattern
$ grep -l "import" *.py
```

### Regex with grep

```bash
# Line starting with
$ grep "^Error" log.txt

# Line ending with
$ grep "failed$" log.txt

# Any character
$ grep "h.t" file.txt    # hat, hit, hot...

# Zero or more
$ grep "go*d" file.txt   # gd, god, good, goood...

# One or more (extended)
$ grep -E "go+d" file.txt  # god, good, goood...

# Character class
$ grep "[0-9]" file.txt

# Word boundary
$ grep -w "cat" file.txt  # Matches "cat" not "catalog"
```

---

## sed - Stream Editor

Transform text using patterns and commands.

### Basic Syntax

```bash
sed 'command' file.txt
sed 's/pattern/replacement/' file.txt
```

### Substitution

```bash
# Replace first occurrence per line
$ sed 's/old/new/' file.txt

# Replace all occurrences
$ sed 's/old/new/g' file.txt

# Case insensitive
$ sed 's/old/new/gi' file.txt

# Replace in place
$ sed -i 's/old/new/g' file.txt

# Backup before replacing
$ sed -i.bak 's/old/new/g' file.txt
```

### Common Operations

```bash
# Delete lines containing pattern
$ sed '/pattern/d' file.txt

# Delete empty lines
$ sed '/^$/d' file.txt

# Print only matching lines
$ sed -n '/pattern/p' file.txt

# Print specific lines
$ sed -n '5p' file.txt          # Line 5
$ sed -n '5,10p' file.txt       # Lines 5-10
$ sed -n '1p; $p' file.txt      # First and last

# Insert text before/after
$ sed '3i\New line' file.txt    # Insert before line 3
$ sed '3a\New line' file.txt    # Append after line 3
```

### Multiple Commands

```bash
# Using semicolons
$ sed 's/a/A/g; s/b/B/g' file.txt

# Using -e
$ sed -e 's/a/A/g' -e 's/b/B/g' file.txt

# Using a script file
$ sed -f commands.sed file.txt
```

### Advanced Examples

```bash
# Extract text between markers
$ sed -n '/START/,/END/p' file.txt

# Replace on specific lines
$ sed '5s/old/new/' file.txt     # Only line 5
$ sed '5,10s/old/new/g' file.txt # Lines 5-10

# Add prefix/suffix
$ sed 's/^/PREFIX: /' file.txt   # Add prefix
$ sed 's/$/ :SUFFIX/' file.txt   # Add suffix

# Delete first N lines
$ sed '1,5d' file.txt

# Reference matched group
$ sed 's/\(.*\)/@\1@/' file.txt  # Surround with @
```

---

## awk - Pattern Processing

Powerful text processing with field-based operations.

### Basic Syntax

```bash
awk 'pattern { action }' file.txt
awk '{ action }' file.txt
```

### Fields

AWK splits input by whitespace (default):
```bash
# Print first field
$ awk '{print $1}' file.txt

# Print multiple fields
$ awk '{print $1, $3}' file.txt

# Print all fields
$ awk '{print $0}' file.txt

# Number of fields
$ awk '{print NF}' file.txt
```

### Custom Field Separator

```bash
# Colon separator
$ awk -F: '{print $1}' /etc/passwd

# Comma separator
$ awk -F, '{print $1, $2}' data.csv

# Multiple separators
$ awk -F'[,:]' '{print $1}' file.txt
```

### Patterns

```bash
# Lines containing pattern
$ awk '/error/' file.txt

# Field equals value
$ awk '$1 == "John"' file.txt

# Field comparison
$ awk '$3 > 100' file.txt

# Line numbers
$ awk 'NR == 5' file.txt          # Line 5
$ awk 'NR >= 5 && NR <= 10' file.txt  # Lines 5-10
```

### Common Operations

```bash
# Sum a column
$ awk '{sum += $1} END {print sum}' numbers.txt

# Average
$ awk '{sum += $1; count++} END {print sum/count}' numbers.txt

# Max value
$ awk 'max < $1 {max = $1} END {print max}' numbers.txt

# Count lines matching
$ awk '/pattern/ {count++} END {print count}' file.txt

# Print with formatting
$ awk '{printf "%-10s %5d\n", $1, $2}' file.txt
```

### Built-in Variables

| Variable | Description |
|----------|-------------|
| `$0` | Entire line |
| `$1, $2...` | Fields |
| `NF` | Number of fields |
| `NR` | Line number |
| `FS` | Field separator |
| `RS` | Record separator |
| `OFS` | Output field separator |

### Examples

```bash
# Process /etc/passwd
$ awk -F: '{print "User:", $1, "Shell:", $7}' /etc/passwd

# Calculate disk usage
$ df -h | awk 'NR>1 {print $5, $6}'

# Find lines with more than 5 fields
$ awk 'NF > 5' file.txt

# Transform CSV
$ awk -F, '{print $2 "," $1}' data.csv

# Add line numbers
$ awk '{print NR ": " $0}' file.txt
```

---

## cut - Extract Columns

Extract specific fields or characters from lines.

### Basic Usage

```bash
# Cut by character position
$ cut -c1-10 file.txt

# Cut by field (tab-delimited)
$ cut -f1 file.txt

# Cut by field (custom delimiter)
$ cut -d: -f1 /etc/passwd
```

### Options

| Option | Description |
|--------|-------------|
| `-c` | Character positions |
| `-f` | Field numbers |
| `-d` | Field delimiter |
| `--complement` | Invert selection |

### Examples

```bash
# First 5 characters
$ cut -c1-5 file.txt

# Characters 5 to end
$ cut -c5- file.txt

# Multiple fields
$ cut -d: -f1,7 /etc/passwd

# Field range
$ cut -d, -f1-3 data.csv

# Everything except field 2
$ cut -d: --complement -f2 file.txt
```

---

## sort - Sort Lines

Sort lines alphabetically or numerically.

### Basic Usage

```bash
$ sort file.txt
$ sort -n numbers.txt    # Numeric sort
$ sort -r file.txt       # Reverse
```

### Options

| Option | Description |
|--------|-------------|
| `-n` | Numeric sort |
| `-r` | Reverse order |
| `-k` | Sort by key/field |
| `-t` | Field separator |
| `-u` | Unique only |
| `-h` | Human-readable numbers |
| `-f` | Case insensitive |

### Examples

```bash
# Numeric sort
$ sort -n numbers.txt

# Reverse sort
$ sort -r file.txt

# Sort by second column
$ sort -k2 file.txt

# Sort by column with custom delimiter
$ sort -t: -k3 -n /etc/passwd

# Sort by size (human-readable)
$ ls -lh | sort -k5 -h

# Unique sort
$ sort -u file.txt
```

---

## uniq - Remove Duplicates

Report or filter repeated lines.

### Basic Usage

```bash
$ sort file.txt | uniq
```

### ⚠️ Important

`uniq` only removes **adjacent** duplicates. Always `sort` first!

### Options

| Option | Description |
|--------|-------------|
| `-c` | Count occurrences |
| `-d` | Only duplicated lines |
| `-u` | Only unique lines |
| `-i` | Case insensitive |

### Examples

```bash
# Count occurrences
$ sort file.txt | uniq -c

# Most frequent items
$ sort file.txt | uniq -c | sort -rn | head

# Show only duplicates
$ sort file.txt | uniq -d

# Show only unique (non-duplicated)
$ sort file.txt | uniq -u
```

---

## tr - Translate Characters

Transform characters.

### Basic Usage

```bash
$ tr 'set1' 'set2' < file.txt
```

### Common Operations

```bash
# Uppercase to lowercase
$ tr 'A-Z' 'a-z' < file.txt

# Lowercase to uppercase
$ tr 'a-z' 'A-Z' < file.txt

# Replace spaces with newlines
$ tr ' ' '\n' < file.txt

# Delete characters
$ tr -d '0-9' < file.txt

# Squeeze repeated characters
$ tr -s ' ' < file.txt

# Delete non-printable
$ tr -cd '[:print:]' < file.txt
```

### Character Classes

| Class | Description |
|-------|-------------|
| `[:alpha:]` | Letters |
| `[:digit:]` | Digits |
| `[:alnum:]` | Alphanumeric |
| `[:space:]` | Whitespace |
| `[:upper:]` | Uppercase |
| `[:lower:]` | Lowercase |
| `[:print:]` | Printable |

---

## paste - Merge Files

Merge lines from multiple files.

### Basic Usage

```bash
# Merge side by side
$ paste file1.txt file2.txt

# Merge with custom delimiter
$ paste -d, file1.txt file2.txt

# Serial (all on one line)
$ paste -s file.txt
```

### Examples

```bash
# Create columns from files
$ paste names.txt scores.txt
John    85
Jane    92

# Join with comma
$ paste -d, col1.txt col2.txt > combined.csv

# Make single line
$ paste -s -d, list.txt
a,b,c,d,e
```

---

## Building Pipelines

Combine commands for powerful text processing.

### Classic Patterns

```bash
# Count unique words
$ cat file.txt | tr ' ' '\n' | sort | uniq -c | sort -rn

# Top 10 most common words
$ cat file.txt | tr -cs 'A-Za-z' '\n' | tr 'A-Z' 'a-z' | sort | uniq -c | sort -rn | head -10

# Extract and count log levels
$ cat app.log | grep -oE "(ERROR|WARN|INFO)" | sort | uniq -c

# Process CSV - average of column 3
$ awk -F, '{sum+=$3; count++} END {print sum/count}' data.csv

# Find most common IP addresses
$ cat access.log | awk '{print $1}' | sort | uniq -c | sort -rn | head

# Extract email addresses
$ grep -oE '[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}' file.txt | sort -u
```

---

## 🏋️ Practice Exercises

1. Find all lines containing "error" (case insensitive) in a log file
2. Replace all occurrences of "foo" with "bar" in a file
3. Extract usernames from /etc/passwd
4. Count how many times each word appears in a file
5. Find the 5 largest files in a directory listing

### Solutions

```bash
# Exercise 1
grep -i "error" logfile.log

# Exercise 2
sed 's/foo/bar/g' file.txt
# To modify in place: sed -i 's/foo/bar/g' file.txt

# Exercise 3
cut -d: -f1 /etc/passwd
# or: awk -F: '{print $1}' /etc/passwd

# Exercise 4
cat file.txt | tr -cs 'A-Za-z' '\n' | sort | uniq -c | sort -rn

# Exercise 5
ls -lh | sort -k5 -rh | head -5
```

---

## 🔗 Next Topic

Continue to [Regular Expressions](regular-expressions.md) →
