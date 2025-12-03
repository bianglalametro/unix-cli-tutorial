# Streams and Redirection

Control input/output streams and build powerful command pipelines.

## 📖 Table of Contents

- [Standard Streams](#standard-streams)
- [Output Redirection](#output-redirection)
- [Input Redirection](#input-redirection)
- [Pipes](#pipes)
- [Advanced Redirection](#advanced-redirection)

---

## Standard Streams

Every process has three standard streams:

```
┌─────────────────────────────────────────────────────────────┐
│                    STANDARD STREAMS                         │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│                    ┌─────────────┐                          │
│   stdin (0) ──────>│             │────────> stdout (1)     │
│   (keyboard)       │   PROCESS   │         (terminal)       │
│                    │             │────────> stderr (2)     │
│                    └─────────────┘         (terminal)       │
│                                                             │
│   0 = stdin  = Standard Input  (default: keyboard)         │
│   1 = stdout = Standard Output (default: terminal)         │
│   2 = stderr = Standard Error  (default: terminal)         │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### Stream Numbers

| Stream | Number | Default | Description |
|--------|--------|---------|-------------|
| stdin | 0 | Keyboard | Input to the program |
| stdout | 1 | Terminal | Normal output |
| stderr | 2 | Terminal | Error messages |

---

## Output Redirection

### Redirect stdout to File

```bash
# Overwrite (create if doesn't exist)
$ echo "Hello" > output.txt
$ cat output.txt
Hello

# Append to file
$ echo "World" >> output.txt
$ cat output.txt
Hello
World

# Redirect command output
$ ls -la > directory_listing.txt
$ date > timestamp.txt
```

### Redirect stderr to File

```bash
# Redirect errors only
$ ls nonexistent_file 2> errors.txt
$ cat errors.txt
ls: cannot access 'nonexistent_file': No such file or directory

# Append errors
$ command_that_fails 2>> errors.log
```

### Redirect Both stdout and stderr

```bash
# Both to same file (Bash 4+)
$ command &> output.txt

# Both to same file (older method)
$ command > output.txt 2>&1

# To different files
$ command > stdout.txt 2> stderr.txt

# Append both
$ command >> output.txt 2>&1
```

### Discard Output

```bash
# Discard stdout
$ command > /dev/null

# Discard stderr
$ command 2> /dev/null

# Discard both
$ command &> /dev/null
$ command > /dev/null 2>&1
```

### Examples

```bash
# Save command output
$ ps aux > processes.txt

# Log errors only
$ find / -name "*.conf" 2> /dev/null

# Save output, ignore errors
$ find / -name "*.log" 2>/dev/null > logfiles.txt

# Capture everything for debugging
$ ./script.sh > script_output.txt 2>&1
```

---

## Input Redirection

### Redirect stdin from File

```bash
# Read input from file
$ wc -l < document.txt
42

# Same as (but more efficient)
$ cat document.txt | wc -l

# Sort from file
$ sort < unsorted.txt > sorted.txt
```

### Here Documents (Heredoc)

Multi-line input embedded in the script:

```bash
# Basic heredoc
$ cat << EOF
This is line 1
This is line 2
EOF

# Save to file
$ cat << EOF > config.txt
server=localhost
port=8080
EOF

# Heredoc in scripts
#!/bin/bash
mysql -u user -p << SQL
SELECT * FROM users;
DELETE FROM temp_data;
SQL
```

### Here Strings

Single-line input:

```bash
# Here string
$ wc -w <<< "Hello World"
2

$ tr 'a-z' 'A-Z' <<< "hello world"
HELLO WORLD

$ bc <<< "10 * 5"
50
```

---

## Pipes

Pipes connect stdout of one command to stdin of another.

### Basic Piping

```bash
# Command1's output becomes Command2's input
$ command1 | command2

# Examples
$ ls -la | head
$ cat file.txt | grep "error"
$ ps aux | grep nginx
```

### Multiple Pipes

```bash
# Chain multiple commands
$ cat file.txt | grep "error" | sort | uniq -c

# Process pipeline
$ ls -la | awk '{print $5, $9}' | sort -n | tail -5
```

### Common Pipe Patterns

```bash
# Search in output
$ dmesg | grep -i error

# Count lines
$ cat file.txt | wc -l

# Top items
$ command | sort | uniq -c | sort -rn | head

# Paged output
$ ls -la | less

# Filter and count
$ ps aux | grep nginx | wc -l
```

### Real-World Examples

```bash
# Find largest files
$ du -sh * | sort -rh | head -10

# Monitor log in real-time
$ tail -f /var/log/syslog | grep error

# Find most common words
$ cat book.txt | tr ' ' '\n' | sort | uniq -c | sort -rn | head

# Process CSV
$ cat data.csv | cut -d',' -f2 | sort | uniq -c | sort -rn

# Find processes using most memory
$ ps aux | sort -k4 -rn | head

# IP addresses hitting server
$ cat access.log | awk '{print $1}' | sort | uniq -c | sort -rn | head
```

---

## Advanced Redirection

### File Descriptors

```bash
# Create custom file descriptor
$ exec 3> output.txt   # Open fd 3 for writing
$ echo "Hello" >&3     # Write to fd 3
$ exec 3>&-            # Close fd 3

# Read from custom fd
$ exec 4< input.txt    # Open fd 4 for reading
$ read line <&4        # Read from fd 4
$ exec 4<&-            # Close fd 4
```

### Process Substitution

Treat command output as a file:

```bash
# Compare two command outputs
$ diff <(ls dir1) <(ls dir2)

# Multiple input sources
$ paste <(cut -f1 file1) <(cut -f2 file2)

# Process without temp files
$ while read line; do
    echo "Line: $line"
  done < <(command)
```

### tee Command

Write to file AND stdout:

```bash
# Save and display
$ ls -la | tee directory.txt

# Append instead of overwrite
$ command | tee -a logfile.txt

# Multiple files
$ command | tee file1.txt file2.txt

# Use in pipeline (continue processing)
$ ls -la | tee listing.txt | grep ".txt"
```

### Redirect to Multiple Commands

```bash
# Using tee with process substitution
$ command | tee >(command2) | command3

# Example: log to file and also grep for errors
$ ./script.sh 2>&1 | tee output.log | grep -i error
```

---

## Special Files

### /dev/null - Black Hole

```bash
# Discard output
$ command > /dev/null

# Suppress all output
$ command &> /dev/null
```

### /dev/zero - Zero Source

```bash
# Create file filled with zeros
$ dd if=/dev/zero of=zeroes.bin bs=1M count=10
```

### /dev/random, /dev/urandom - Random Data

```bash
# Generate random data
$ head -c 100 /dev/urandom | base64
```

### /dev/stdin, /dev/stdout, /dev/stderr

```bash
# Explicit reference to streams
$ echo "Hello" > /dev/stdout
$ cat /dev/stdin  # Reads from keyboard
```

---

## Practical Examples

### Log Processing

```bash
# Count errors in log
$ grep -c "ERROR" /var/log/syslog

# Save errors to separate file
$ grep "ERROR" /var/log/syslog > errors.log 2> grep_errors.log

# Real-time error monitoring
$ tail -f /var/log/syslog | grep --line-buffered "ERROR"
```

### Data Pipeline

```bash
# Extract, transform, load pattern
$ cat data.csv | \
    grep -v "^#" | \
    cut -d',' -f1,3 | \
    sort -t',' -k2 | \
    uniq > processed.csv
```

### Backup with Progress

```bash
# Show progress while backing up
$ tar -cvf - /home | tee backup.tar | wc -c
```

### Command Output as Variable

```bash
# Using $()
$ FILES=$(ls -1 | wc -l)
$ echo "There are $FILES files"

# Using backticks (older style)
$ FILES=`ls -1 | wc -l`
```

---

## 🏋️ Practice Exercises

1. Redirect the output of `date` to a file called `today.txt`
2. List all files, errors only to a file, normal output to terminal
3. Create a pipeline that counts the number of files in `/etc`
4. Use `tee` to save command output while also viewing it
5. Create a heredoc that writes a multi-line config file

### Solutions

```bash
# Exercise 1
date > today.txt

# Exercise 2
ls /nonexistent /etc 2> errors.txt

# Exercise 3
ls /etc | wc -l

# Exercise 4
ls -la | tee directory_listing.txt

# Exercise 5
cat << EOF > config.ini
[database]
host=localhost
port=5432
[app]
debug=true
EOF
```

---

## 🔗 Next Topic

Continue to [Exercises](exercises.md) →
