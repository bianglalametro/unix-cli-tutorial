# Search Commands

Find files, commands, and documentation.

## 📖 Table of Contents

- [man - Manual Pages](#man---manual-pages)
- [which - Locate Commands](#which---locate-commands)
- [whereis - Locate Binaries](#whereis---locate-binaries)
- [locate - Fast File Search](#locate---fast-file-search)
- [find - Powerful File Search](#find---powerful-file-search)

---

## man - Manual Pages

The built-in documentation for commands.

### Basic Usage

```bash
$ man ls
$ man grep
$ man man     # Manual for the manual!
```

### Navigation in man

| Key | Action |
|-----|--------|
| `Space` | Next page |
| `b` | Previous page |
| `/pattern` | Search forward |
| `?pattern` | Search backward |
| `n` | Next search result |
| `N` | Previous search result |
| `q` | Quit |

### Manual Sections

```bash
# Sections
1 - User commands
2 - System calls
3 - Library functions
4 - Special files
5 - File formats
6 - Games
7 - Miscellaneous
8 - System administration

# Access specific section
$ man 5 passwd    # File format for /etc/passwd
$ man 1 passwd    # passwd command
```

### Searching Manuals

```bash
# Search for keywords
$ man -k "copy files"
cp (1)               - copy files and directories
scp (1)              - secure copy

# Equivalent to apropos
$ apropos "copy"
```

### Example

```bash
$ man cp
CP(1)                   User Commands                   CP(1)

NAME
       cp - copy files and directories

SYNOPSIS
       cp [OPTION]... SOURCE DEST
       cp [OPTION]... SOURCE... DIRECTORY

DESCRIPTION
       Copy SOURCE to DEST, or multiple SOURCE(s) to DIRECTORY.
...
```

---

## which - Locate Commands

Find where a command executable is located.

### Basic Usage

```bash
$ which python
/usr/bin/python

$ which ls
/usr/bin/ls

$ which node
/usr/local/bin/node
```

### Multiple Commands

```bash
$ which python python3 pip
/usr/bin/python
/usr/bin/python3
/usr/bin/pip
```

### Use Cases

```bash
# Check if a command is installed
$ which docker
/usr/bin/docker

# Not found
$ which nonexistent
# Returns nothing, exit code 1

# Verify correct version is first in PATH
$ which -a python
/usr/bin/python
/usr/local/bin/python
```

---

## whereis - Locate Binaries

Find binary, source, and manual page locations.

### Basic Usage

```bash
$ whereis ls
ls: /usr/bin/ls /usr/share/man/man1/ls.1.gz

$ whereis python
python: /usr/bin/python /usr/lib/python3.10 /usr/share/man/man1/python.1.gz
```

### Options

| Option | Description |
|--------|-------------|
| `-b` | Search for binaries only |
| `-m` | Search for manual pages only |
| `-s` | Search for source files only |

```bash
$ whereis -b python
python: /usr/bin/python

$ whereis -m python
python: /usr/share/man/man1/python.1.gz
```

---

## locate - Fast File Search

Search a pre-built database of filenames (very fast).

### Installation

```bash
# Debian/Ubuntu
$ sudo apt install mlocate

# RHEL/Fedora
$ sudo dnf install mlocate

# Update the database
$ sudo updatedb
```

### Basic Usage

```bash
$ locate myfile.txt
/home/john/documents/myfile.txt
/home/john/backup/myfile.txt

$ locate "*.conf"
/etc/nginx/nginx.conf
/etc/ssh/ssh_config
...
```

### Options

| Option | Description |
|--------|-------------|
| `-i` | Case insensitive |
| `-n N` | Limit to N results |
| `-c` | Count matches |
| `-r` | Use regex |

```bash
# Case insensitive search
$ locate -i readme

# Limit results
$ locate -n 5 "*.txt"

# Count matching files
$ locate -c "*.py"
342
```

### ⚠️ Note

`locate` searches a database that may be out of date. New files won't appear until `updatedb` runs (usually daily via cron).

```bash
# Force database update
$ sudo updatedb
```

---

## find - Powerful File Search

Search for files in real-time with complex criteria.

### Basic Syntax

```bash
find [path] [expression]
```

### Search by Name

```bash
# Find by exact name
$ find . -name "myfile.txt"

# Find by pattern (glob)
$ find . -name "*.txt"

# Case-insensitive
$ find . -iname "readme*"

# In specific directory
$ find /var/log -name "*.log"
```

### Search by Type

```bash
# Files only
$ find . -type f

# Directories only
$ find . -type d

# Symbolic links
$ find . -type l

# Combined: .txt files only
$ find . -type f -name "*.txt"
```

### Search by Size

```bash
# Exact size (k=kilobytes, M=megabytes, G=gigabytes)
$ find . -size 10M

# Greater than
$ find . -size +100M

# Less than
$ find . -size -1k

# Range (between 10MB and 100MB)
$ find . -size +10M -size -100M
```

### Search by Time

```bash
# Modified in last 7 days
$ find . -mtime -7

# Modified more than 30 days ago
$ find . -mtime +30

# Accessed in last 24 hours
$ find . -atime -1

# Modified in last 60 minutes
$ find . -mmin -60
```

### Search by Permissions

```bash
# Exact permissions
$ find . -perm 644

# At least these permissions
$ find . -perm -644

# Any of these permissions
$ find . -perm /755

# Find world-writable files
$ find . -perm -o=w

# Find executable files
$ find . -executable
```

### Search by Owner

```bash
# By user
$ find . -user john

# By group
$ find . -group developers

# Files with no owner
$ find . -nouser
```

### Combining Criteria

```bash
# AND (implicit)
$ find . -type f -name "*.txt"

# OR (-o)
$ find . -name "*.txt" -o -name "*.md"

# NOT (!)
$ find . -type f ! -name "*.txt"

# Grouping
$ find . \( -name "*.txt" -o -name "*.md" \) -mtime -7
```

### Actions

```bash
# Print (default)
$ find . -name "*.txt" -print

# Delete (be careful!)
$ find . -name "*.tmp" -delete

# Execute command
$ find . -name "*.txt" -exec cat {} \;

# Execute command with confirmation
$ find . -name "*.txt" -ok rm {} \;

# Execute command with multiple files
$ find . -name "*.txt" -exec grep "pattern" {} +
```

### Common Examples

```bash
# Find large files
$ find /home -size +100M 2>/dev/null

# Find recently modified files
$ find . -mtime -1 -type f

# Find and delete empty directories
$ find . -type d -empty -delete

# Find files modified today
$ find . -daystart -mtime 0

# Find files by content
$ find . -type f -exec grep -l "pattern" {} \;

# Find and change permissions
$ find . -type f -name "*.sh" -exec chmod +x {} \;

# Find broken symlinks
$ find . -xtype l

# Find duplicate filenames
$ find . -type f -printf "%f\n" | sort | uniq -d
```

### Performance Tips

```bash
# Limit depth
$ find . -maxdepth 2 -name "*.txt"

# Start from minimum depth
$ find . -mindepth 1 -name "*.txt"

# Exclude directories
$ find . -path "./node_modules" -prune -o -name "*.js" -print

# Use -quit to stop after first match
$ find . -name "target.txt" -quit
```

---

## 🏋️ Practice Exercises

1. Find the location of the `grep` command
2. Read the manual page for `cp` and find the option for verbose output
3. Find all `.txt` files in your home directory
4. Find all files larger than 10MB in `/var`
5. Find files modified in the last 24 hours

### Solutions

```bash
# Exercise 1
which grep
whereis grep

# Exercise 2
man cp
# Answer: -v or --verbose

# Exercise 3
find ~ -name "*.txt" 2>/dev/null

# Exercise 4
find /var -size +10M 2>/dev/null

# Exercise 5
find . -mtime -1 -type f
```

---

## 🔗 Next Topic

Continue to [Text Editors](text-editors.md) →
