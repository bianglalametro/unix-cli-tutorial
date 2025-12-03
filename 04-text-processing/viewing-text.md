# Viewing Text

Commands for viewing and navigating file contents.

## 📖 Table of Contents

- [cat - Concatenate and Display](#cat---concatenate-and-display)
- [less - Paginated Viewing](#less---paginated-viewing)
- [head - View Beginning](#head---view-beginning)
- [tail - View End](#tail---view-end)
- [nl - Number Lines](#nl---number-lines)
- [wc - Word Count](#wc---word-count)

---

## cat - Concatenate and Display

Display file contents to the terminal.

### Basic Usage

```bash
# Display file
$ cat file.txt
Hello World
This is line 2
This is line 3

# Display multiple files
$ cat file1.txt file2.txt

# Concatenate files into one
$ cat file1.txt file2.txt > combined.txt
```

### Common Options

| Option | Description |
|--------|-------------|
| `-n` | Number all lines |
| `-b` | Number non-blank lines |
| `-s` | Squeeze blank lines |
| `-A` | Show all (non-printing chars) |
| `-E` | Show line endings ($) |
| `-T` | Show tabs (^I) |

### Examples

```bash
# Number all lines
$ cat -n file.txt
     1  Hello World
     2  This is line 2
     3
     4  This is line 4

# Number only non-blank lines
$ cat -b file.txt
     1  Hello World
     2  This is line 2

     3  This is line 4

# Show special characters
$ cat -A file.txt
Hello World$
This has a	tab^I$
```

### Creating Files with cat

```bash
# Create file with cat
$ cat > newfile.txt
Type your content here
Press Ctrl+D when done
^D

# Append to file
$ cat >> existingfile.txt
Additional content
^D

# Heredoc
$ cat << EOF > file.txt
Line 1
Line 2
Line 3
EOF
```

### ⚠️ Warning

Don't cat large files or binary files:
```bash
# Bad: Large file floods terminal
$ cat hugefile.log

# Better: Use less or head
$ less hugefile.log
$ head -50 hugefile.log
```

---

## less - Paginated Viewing

View files one page at a time (better than `more`).

### Basic Usage

```bash
$ less file.txt
```

### Navigation

| Key | Action |
|-----|--------|
| `Space` / `f` | Page forward |
| `b` | Page backward |
| `Enter` | Line forward |
| `y` | Line backward |
| `g` | Go to beginning |
| `G` | Go to end |
| `/pattern` | Search forward |
| `?pattern` | Search backward |
| `n` | Next search result |
| `N` | Previous search result |
| `q` | Quit |

### Options

| Option | Description |
|--------|-------------|
| `-N` | Show line numbers |
| `-S` | Chop long lines |
| `-i` | Case-insensitive search |
| `-p pattern` | Start at first match |
| `+F` | Follow mode (like tail -f) |

### Examples

```bash
# With line numbers
$ less -N file.txt

# Start at pattern
$ less -p "error" logfile.log

# Follow file updates (like tail -f)
$ less +F logfile.log
# Press Ctrl+C to stop following, F to resume
```

### In-viewer Commands

```bash
# While in less:
-N          # Toggle line numbers
-S          # Toggle line wrapping
v           # Open in editor
=           # Show file info
```

---

## head - View Beginning

Display the first lines of a file.

### Basic Usage

```bash
# Default: first 10 lines
$ head file.txt

# Specific number of lines
$ head -n 5 file.txt
$ head -5 file.txt
```

### Options

| Option | Description |
|--------|-------------|
| `-n N` | First N lines |
| `-c N` | First N bytes |
| `-q` | Quiet (no headers for multiple files) |
| `-v` | Verbose (always show headers) |

### Examples

```bash
# First 20 lines
$ head -n 20 file.txt

# First 100 bytes
$ head -c 100 file.txt

# All but last 5 lines
$ head -n -5 file.txt

# Multiple files
$ head file1.txt file2.txt
==> file1.txt <==
Line 1
Line 2

==> file2.txt <==
Content
```

### Common Use Cases

```bash
# Preview large file
$ head -50 largefile.log

# Check file format
$ head -1 data.csv

# Pipeline preview
$ find . -name "*.txt" | head -5
```

---

## tail - View End

Display the last lines of a file.

### Basic Usage

```bash
# Default: last 10 lines
$ tail file.txt

# Specific number of lines
$ tail -n 20 file.txt
$ tail -20 file.txt
```

### Options

| Option | Description |
|--------|-------------|
| `-n N` | Last N lines |
| `-c N` | Last N bytes |
| `-f` | Follow (watch for updates) |
| `-F` | Follow with retry (if file recreated) |
| `--pid=PID` | Stop following when PID dies |

### Examples

```bash
# Last 50 lines
$ tail -n 50 file.txt

# From line 10 onwards
$ tail -n +10 file.txt

# Last 1000 bytes
$ tail -c 1000 file.txt
```

### Following Files

The most powerful feature of `tail`:

```bash
# Watch for new lines
$ tail -f /var/log/syslog

# Watch multiple files
$ tail -f file1.log file2.log

# Follow even if file is replaced
$ tail -F app.log

# Stop following when process ends
$ tail -f --pid=$$ logfile.log
```

### Real-World Examples

```bash
# Monitor web server logs
$ tail -f /var/log/nginx/access.log

# Watch application output
$ tail -f ~/app/app.log | grep ERROR

# Last 24 hours of logs (with grep)
$ tail -10000 /var/log/syslog | grep "Dec  3"
```

---

## nl - Number Lines

Add line numbers to files.

### Basic Usage

```bash
$ nl file.txt
     1  Line one
     2  Line two
     3  Line three
```

### Options

| Option | Description |
|--------|-------------|
| `-b a` | Number all lines |
| `-b t` | Number non-empty lines (default) |
| `-n ln` | Left-justified numbers |
| `-n rn` | Right-justified numbers |
| `-n rz` | Right-justified with zeros |
| `-s` | Separator after number |

### Examples

```bash
# Number all lines including blank
$ nl -b a file.txt

# With different separator
$ nl -s ": " file.txt
     1: Line one
     2: Line two

# Zero-padded numbers
$ nl -n rz file.txt
000001  Line one
000002  Line two
```

---

## wc - Word Count

Count lines, words, and characters.

### Basic Usage

```bash
$ wc file.txt
  10  50 300 file.txt
  │   │   │
  │   │   └── Bytes (characters)
  │   └── Words
  └── Lines
```

### Options

| Option | Description |
|--------|-------------|
| `-l` | Lines only |
| `-w` | Words only |
| `-c` | Bytes only |
| `-m` | Characters only |
| `-L` | Length of longest line |

### Examples

```bash
# Count lines only
$ wc -l file.txt
10 file.txt

# Just the number (no filename)
$ wc -l < file.txt
10

# Count words
$ wc -w document.txt

# Multiple files
$ wc -l *.txt
  10 file1.txt
  20 file2.txt
  30 total
```

### Common Use Cases

```bash
# Count files in directory
$ ls | wc -l

# Count matching lines
$ grep "error" log.txt | wc -l

# Count lines of code
$ find . -name "*.py" -exec cat {} \; | wc -l

# Check if file is empty
$ if [ $(wc -l < file.txt) -eq 0 ]; then echo "Empty"; fi
```

---

## Comparison Summary

| Command | Best For |
|---------|----------|
| `cat` | Small files, concatenation |
| `less` | Large files, searching |
| `head` | File beginnings, previews |
| `tail` | File endings, log monitoring |
| `nl` | Adding line numbers |
| `wc` | Counting |

---

## 🏋️ Practice Exercises

1. Display the first 20 lines of `/etc/passwd`
2. Watch a log file for changes in real-time
3. Count how many lines are in `/etc/passwd`
4. View a large file with line numbers
5. Display the last 5 lines of a file

### Solutions

```bash
# Exercise 1
head -n 20 /etc/passwd

# Exercise 2
tail -f /var/log/syslog
# Or create your own:
# Terminal 1: tail -f test.log
# Terminal 2: echo "new line" >> test.log

# Exercise 3
wc -l /etc/passwd
# or: wc -l < /etc/passwd

# Exercise 4
less -N /var/log/syslog
# or: cat -n /var/log/syslog | less

# Exercise 5
tail -n 5 /etc/passwd
```

---

## 🔗 Next Topic

Continue to [Processing Commands](processing-commands.md) →
