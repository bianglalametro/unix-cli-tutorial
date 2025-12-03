# Process Management

View and manage running processes.

## 📖 Table of Contents

- [ps - Process Status](#ps---process-status)
- [top - Real-time Viewer](#top---real-time-viewer)
- [htop - Enhanced Viewer](#htop---enhanced-viewer)
- [kill - Terminate Processes](#kill---terminate-processes)
- [pgrep and pkill](#pgrep-and-pkill)

---

## ps - Process Status

Display a snapshot of current processes.

### Basic Usage

```bash
# Your processes
$ ps
    PID TTY          TIME CMD
  12345 pts/0    00:00:00 bash
  12456 pts/0    00:00:00 ps

# All processes (BSD style)
$ ps aux

# All processes (Unix style)
$ ps -ef
```

### Common Options

#### BSD Style (no dashes)

```bash
$ ps aux
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root           1  0.0  0.1 169584 13256 ?        Ss   Dec02   0:03 /sbin/init
root           2  0.0  0.0      0     0 ?        S    Dec02   0:00 [kthreadd]
john       12345  0.0  0.1  21324  5432 pts/0    Ss   10:00   0:00 -bash
```

| Column | Description |
|--------|-------------|
| USER | Process owner |
| PID | Process ID |
| %CPU | CPU usage |
| %MEM | Memory usage |
| VSZ | Virtual memory size |
| RSS | Resident memory size |
| TTY | Terminal |
| STAT | Process state |
| START | Start time |
| TIME | CPU time used |
| COMMAND | Command name |

#### Unix Style (with dashes)

```bash
$ ps -ef
UID          PID    PPID  C STIME TTY          TIME CMD
root           1       0  0 Dec02 ?        00:00:03 /sbin/init
root           2       0  0 Dec02 ?        00:00:00 [kthreadd]
john       12345   12300  0 10:00 pts/0    00:00:00 -bash
```

### Useful ps Commands

```bash
# All processes with full format
$ ps -ef

# All processes with user-oriented format
$ ps aux

# Process tree
$ ps -ejH
$ ps axjf

# Specific user's processes
$ ps -u john

# Specific process by PID
$ ps -p 12345

# Specific process by name
$ ps -C nginx

# Custom output
$ ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head
```

### Process States (STAT column)

| State | Meaning |
|-------|---------|
| R | Running |
| S | Sleeping (interruptible) |
| D | Sleeping (uninterruptible) |
| T | Stopped |
| Z | Zombie |
| < | High priority |
| N | Low priority |
| s | Session leader |
| + | Foreground process |
| l | Multi-threaded |

---

## top - Real-time Viewer

Interactive, real-time process monitor.

### Basic Usage

```bash
$ top
```

### Display

```
top - 10:30:00 up 1 day,  2:30,  1 user,  load average: 0.15, 0.10, 0.05
Tasks: 150 total,   1 running, 149 sleeping,   0 stopped,   0 zombie
%Cpu(s):  2.0 us,  1.0 sy,  0.0 ni, 96.5 id,  0.5 wa,  0.0 hi,  0.0 si
MiB Mem :   7976.5 total,   2500.0 free,   3000.0 used,   2476.5 buff/cache
MiB Swap:   2048.0 total,   2048.0 free,      0.0 used.   4500.0 avail Mem

    PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
   1234 john      20   0 2500000 500000  50000 S   5.0   6.3   1:23.45 firefox
   5678 root      20   0  500000 100000  20000 S   2.0   1.3   0:15.30 Xorg
```

### Interactive Commands

| Key | Action |
|-----|--------|
| `h` | Help |
| `q` | Quit |
| `k` | Kill a process |
| `r` | Renice a process |
| `u` | Filter by user |
| `M` | Sort by memory |
| `P` | Sort by CPU |
| `T` | Sort by time |
| `f` | Select fields |
| `1` | Toggle CPU cores |
| `c` | Toggle full command |
| `V` | Forest view (tree) |

### Command Line Options

```bash
# Update every 5 seconds
$ top -d 5

# Show specific user
$ top -u john

# Show specific PIDs
$ top -p 1234,5678

# Batch mode (for scripts)
$ top -bn1 | head -20
```

---

## htop - Enhanced Viewer

A more user-friendly alternative to top.

### Installation

```bash
# Debian/Ubuntu
$ sudo apt install htop

# RHEL/Fedora
$ sudo dnf install htop
```

### Features

- Color-coded display
- Mouse support
- Horizontal and vertical scrolling
- Tree view
- Easy process management

### Interactive Commands

| Key | Action |
|-----|--------|
| `F1` | Help |
| `F2` | Setup |
| `F3` | Search |
| `F4` | Filter |
| `F5` | Tree view |
| `F6` | Sort by |
| `F9` | Kill |
| `F10` | Quit |
| `Space` | Tag process |
| `U` | Untag all |
| `k` | Kill tagged |

---

## kill - Terminate Processes

Send signals to processes.

### Basic Usage

```bash
# Default: SIGTERM (15)
$ kill 12345

# Force kill: SIGKILL (9)
$ kill -9 12345
$ kill -KILL 12345

# By signal name
$ kill -TERM 12345
$ kill -HUP 12345
```

### Common Signals

```bash
# List all signals
$ kill -l

# Graceful termination
$ kill -15 12345    # SIGTERM

# Force kill
$ kill -9 12345     # SIGKILL

# Stop (pause)
$ kill -19 12345    # SIGSTOP

# Continue
$ kill -18 12345    # SIGCONT

# Reload configuration
$ kill -1 12345     # SIGHUP
```

### killall - Kill by Name

```bash
# Kill all processes with name
$ killall firefox

# Interactive (confirm)
$ killall -i firefox

# Kill only user's processes
$ killall -u john firefox

# Wait for processes to die
$ killall -w firefox
```

### Best Practices

```bash
# Step 1: Try SIGTERM first
$ kill 12345

# Step 2: Wait a few seconds

# Step 3: If still running, use SIGKILL
$ kill -9 12345
```

⚠️ **Warning**: `kill -9` should be a last resort. It doesn't allow the process to clean up (save data, close files, etc.).

---

## pgrep and pkill

Find and kill processes by pattern.

### pgrep - Find Processes

```bash
# Find PIDs by name
$ pgrep nginx
1234
1235

# Find with full command line
$ pgrep -f "python server.py"

# List with process name
$ pgrep -l nginx
1234 nginx
1235 nginx

# List with full command
$ pgrep -a nginx

# User's processes only
$ pgrep -u john

# Newest matching process
$ pgrep -n firefox

# Oldest matching process
$ pgrep -o firefox
```

### pkill - Kill by Pattern

```bash
# Kill by name
$ pkill nginx

# Kill with signal
$ pkill -9 firefox

# Kill by full command
$ pkill -f "python server.py"

# Kill user's processes
$ pkill -u john firefox

# Kill processes older than 1 hour
$ pkill -o -9 myprocess
```

### pidof

```bash
# Get PID of a program
$ pidof nginx
1234 1235

# Single PID only
$ pidof -s nginx
1234
```

---

## Practical Examples

### Finding Resource-Hungry Processes

```bash
# Top 5 CPU consumers
$ ps aux --sort=-%cpu | head -6

# Top 5 memory consumers
$ ps aux --sort=-%mem | head -6

# Find processes using most memory
$ ps -eo pid,ppid,cmd,%mem --sort=-%mem | head
```

### Process Cleanup

```bash
# Find and kill zombie processes' parents
$ ps aux | grep 'Z' | awk '{print $2}'

# Kill all processes by a user
$ pkill -u baduser

# Kill stuck process
$ kill -9 $(pgrep -f "stuck_script.py")
```

### Monitoring Specific Process

```bash
# Watch a process
$ watch -n 1 'ps -p 12345 -o pid,ppid,cmd,%cpu,%mem'

# Follow process with top
$ top -p 12345
```

---

## 🏋️ Practice Exercises

1. List all processes running as your user
2. Find the PID of the bash shell you're currently using
3. Start a `sleep 100` process and kill it gracefully
4. Find the top 3 memory-consuming processes
5. Use htop (if available) to explore the process list

### Solutions

```bash
# Exercise 1
ps -u $USER
# or: ps aux | grep $USER

# Exercise 2
echo $$
# or: ps -p $$

# Exercise 3
sleep 100 &
# Note the PID
kill %1
# or: kill <PID>

# Exercise 4
ps aux --sort=-%mem | head -4

# Exercise 5
htop
# Navigate with arrows, press F1 for help
```

---

## 🔗 Next Topic

Continue to [Process Control](process-control.md) →
