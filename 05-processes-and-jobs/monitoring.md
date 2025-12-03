# System Monitoring

Tools for monitoring processes and system resources.

## 📖 Table of Contents

- [pstree - Process Tree](#pstree---process-tree)
- [pmap - Process Memory Map](#pmap---process-memory-map)
- [lsof - List Open Files](#lsof---list-open-files)
- [strace - System Call Trace](#strace---system-call-trace)
- [watch - Repeat Commands](#watch---repeat-commands)

---

## pstree - Process Tree

Display processes in a tree structure showing parent-child relationships.

### Basic Usage

```bash
$ pstree
systemd─┬─NetworkManager───2*[{NetworkManager}]
        ├─accounts-daemon───2*[{accounts-daemon}]
        ├─sshd───sshd───sshd───bash───pstree
        ├─cron
        └─systemd───(sd-pam)
```

### Common Options

| Option | Description |
|--------|-------------|
| `-p` | Show PIDs |
| `-u` | Show user transitions |
| `-a` | Show command arguments |
| `-h` | Highlight current process |
| `-n` | Sort by PID |
| `-H PID` | Highlight specific PID |

### Examples

```bash
# With PIDs
$ pstree -p
systemd(1)─┬─sshd(1234)───sshd(5678)───bash(9012)───pstree(9013)
           └─cron(567)

# Show specific user's processes
$ pstree john
sshd───bash───vim

# With command arguments
$ pstree -a john

# Highlight a specific PID
$ pstree -H 1234
```

---

## pmap - Process Memory Map

Display the memory map of a process.

### Basic Usage

```bash
$ pmap 12345
12345:   /usr/bin/python3 script.py
0000555555554000     16K r-x-- python3
0000555555757000      4K r---- python3
0000555555758000      4K rw--- python3
...
total           123456K
```

### Options

| Option | Description |
|--------|-------------|
| `-x` | Extended format |
| `-X` | More extended format |
| `-d` | Device format |
| `-q` | Quiet (no headers) |

### Examples

```bash
# Extended format with details
$ pmap -x 12345
Address           Kbytes     RSS   Dirty Mode  Mapping
0000555555554000      16      16       0 r-x-- python3
...

# For your current shell
$ pmap $$

# Check memory of a process
$ pmap -x $(pgrep firefox) | tail -1
total kB         1234567    56789   12345
```

### Understanding Output

| Column | Description |
|--------|-------------|
| Address | Memory address |
| Kbytes | Virtual memory size |
| RSS | Resident memory (in RAM) |
| Dirty | Modified pages |
| Mode | Permissions (r/w/x) |
| Mapping | File or [heap]/[stack] |

---

## lsof - List Open Files

Show files opened by processes (everything is a file in Unix!).

### Basic Usage

```bash
# All open files (lots of output!)
$ lsof | head

# Files opened by specific process
$ lsof -p 12345

# Files opened by command
$ lsof -c nginx
```

### Common Options

| Option | Description |
|--------|-------------|
| `-p PID` | Files by PID |
| `-c name` | Files by command name |
| `-u user` | Files by user |
| `-i` | Network connections |
| `+D dir` | Files in directory |

### Network Connections

```bash
# All network connections
$ lsof -i

# Specific port
$ lsof -i :80
$ lsof -i :443

# TCP connections
$ lsof -i tcp

# UDP connections
$ lsof -i udp

# Specific protocol and port
$ lsof -i tcp:22
```

### Finding Processes

```bash
# What's using a file?
$ lsof /var/log/syslog

# What's using a directory?
$ lsof +D /tmp

# What's using a deleted file?
$ lsof | grep deleted

# What ports are in use?
$ lsof -i -P -n | grep LISTEN
```

### Practical Examples

```bash
# Find what's using port 8080
$ lsof -i :8080
COMMAND  PID USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
node    1234 john   20u  IPv4  12345      0t0  TCP *:8080 (LISTEN)

# Find what's preventing umount
$ lsof +D /mnt/usb

# Check user's network activity
$ lsof -u john -i

# Find processes with most files open
$ lsof | awk '{print $1}' | sort | uniq -c | sort -rn | head
```

---

## strace - System Call Trace

Trace system calls made by a process (advanced debugging).

### Basic Usage

```bash
# Trace a new command
$ strace ls

# Trace an existing process
$ strace -p 12345
```

### Common Options

| Option | Description |
|--------|-------------|
| `-p PID` | Attach to process |
| `-f` | Follow forks |
| `-e CALL` | Filter by call type |
| `-o FILE` | Output to file |
| `-c` | Count statistics |
| `-t` | Timestamps |

### Examples

```bash
# Just file operations
$ strace -e open,read,write ls

# Network operations
$ strace -e network curl http://example.com

# With timestamps
$ strace -t ls

# Statistics only
$ strace -c ls
% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
 30.00    0.000030          10         3           openat
 20.00    0.000020          10         2           read
...

# Save to file
$ strace -o trace.log -f ./myprogram
```

### Common System Calls

| Call | Description |
|------|-------------|
| open | Open file |
| read | Read from fd |
| write | Write to fd |
| close | Close fd |
| stat | Get file info |
| fork | Create child process |
| execve | Execute program |
| socket | Create network socket |
| connect | Connect to address |

### Debugging Example

```bash
# Why is my program failing?
$ strace -e openat myprogram 2>&1 | grep -i error
openat(AT_FDCWD, "/missing/file", O_RDONLY) = -1 ENOENT (No such file)

# What config files does a program read?
$ strace -e openat nginx 2>&1 | grep -v ENOENT
```

---

## watch - Repeat Commands

Execute a command repeatedly and display results.

### Basic Usage

```bash
# Default: every 2 seconds
$ watch 'date'

# Every 5 seconds
$ watch -n 5 'date'
```

### Options

| Option | Description |
|--------|-------------|
| `-n N` | Update every N seconds |
| `-d` | Highlight differences |
| `-t` | No title |
| `-b` | Beep on error |
| `-c` | Interpret colors |

### Examples

```bash
# Monitor disk usage
$ watch df -h

# Monitor memory
$ watch free -m

# Monitor processes
$ watch 'ps aux | head -10'

# Monitor file changes
$ watch -d ls -l

# Monitor network connections
$ watch -n 1 'netstat -tuln'

# Monitor log file
$ watch 'tail -5 /var/log/syslog'
```

### Highlight Changes

```bash
# Highlight what changed
$ watch -d 'cat /proc/meminfo | head'

# Good for monitoring:
$ watch -d 'ls -la'
$ watch -d 'df -h'
$ watch -d 'free -m'
```

---

## Monitoring Best Practices

### Quick System Overview

```bash
# One-liner system check
$ echo "=== Load ===" && uptime && echo "=== Memory ===" && free -h && echo "=== Disk ===" && df -h / && echo "=== Top Processes ===" && ps aux --sort=-%cpu | head -5
```

### Continuous Monitoring

```bash
# Terminal 1: htop
$ htop

# Terminal 2: Watch logs
$ tail -f /var/log/syslog

# Terminal 3: Network
$ watch 'netstat -tuln'
```

### Performance Investigation

```bash
# 1. What's using CPU?
$ ps aux --sort=-%cpu | head

# 2. What's using memory?
$ ps aux --sort=-%mem | head

# 3. What's using disk I/O?
$ iotop  # (if installed)

# 4. What files are open?
$ lsof | wc -l

# 5. What network connections?
$ lsof -i | grep ESTABLISHED
```

---

## 🏋️ Practice Exercises

1. Display the process tree for your current session
2. Find what process is using port 22
3. Watch the output of `free -m` every 3 seconds
4. Find how many files your shell process has open
5. List all network connections as root

### Solutions

```bash
# Exercise 1
pstree -p $$
# or: pstree -u $USER

# Exercise 2
sudo lsof -i :22
# or: sudo lsof -i tcp:22

# Exercise 3
watch -n 3 free -m

# Exercise 4
lsof -p $$ | wc -l

# Exercise 5
sudo lsof -i
# or: sudo lsof -i -P -n | grep ESTABLISHED
```

---

## 🔗 Next Topic

Continue to [Exercises](exercises.md) →
