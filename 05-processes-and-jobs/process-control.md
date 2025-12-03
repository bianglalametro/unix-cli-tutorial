# Process Control

Control process priorities and resource limits.

## 📖 Table of Contents

- [nice - Start with Priority](#nice---start-with-priority)
- [renice - Change Priority](#renice---change-priority)
- [timeout - Run with Time Limit](#timeout---run-with-time-limit)
- [nohup - Run Immune to Hangups](#nohup---run-immune-to-hangups)
- [ulimit - Resource Limits](#ulimit---resource-limits)

---

## nice - Start with Priority

Start a process with a specific priority.

### Understanding Nice Values

```
┌─────────────────────────────────────────────────────────────────┐
│                      NICE VALUES                                │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│   -20  ─────────────────────────────────────────────────  +19  │
│   High                    Normal                         Low    │
│   Priority                  (0)                       Priority  │
│                                                                 │
│   • Range: -20 (highest) to +19 (lowest)                       │
│   • Default: 0                                                  │
│   • Only root can set negative nice values                     │
│   • Higher nice = lower priority = "nicer" to other processes  │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### Basic Usage

```bash
# Start with low priority (nice to others)
$ nice long_running_command

# Start with specific nice value
$ nice -n 10 backup_script.sh

# Maximum niceness (lowest priority)
$ nice -n 19 intensive_job

# High priority (requires root)
$ sudo nice -n -10 important_process
```

### Examples

```bash
# Run backup with low priority
$ nice -n 15 tar -czf backup.tar.gz /home

# Compile with low priority
$ nice -n 10 make -j4

# Check nice value of running process
$ ps -o pid,ni,cmd -p 12345
```

---

## renice - Change Priority

Change the priority of a running process.

### Basic Usage

```bash
# Change priority by PID
$ renice 10 -p 12345

# Change priority for all processes of a user
$ sudo renice 5 -u john

# Change priority for a process group
$ renice 15 -g 1000
```

### Options

| Option | Description |
|--------|-------------|
| `-p` | Process ID |
| `-u` | User (all their processes) |
| `-g` | Process group |
| `-n` | Nice increment |

### Examples

```bash
# Lower priority of a CPU hog
$ renice 19 -p $(pgrep -f "heavy_process")

# Increase priority (requires root)
$ sudo renice -10 -p 12345

# Make all user's processes lower priority
$ sudo renice 10 -u developer
```

### Check Current Nice Value

```bash
$ ps -o pid,ni,cmd -p 12345
    PID  NI CMD
  12345  10 /usr/bin/myprocess

$ top -p 12345
# Look at the NI column
```

---

## timeout - Run with Time Limit

Run a command with a time limit.

### Basic Usage

```bash
# Kill after 10 seconds
$ timeout 10 command

# Kill after 5 minutes
$ timeout 5m command

# Kill after 2 hours
$ timeout 2h command
```

### Time Units

| Suffix | Unit |
|--------|------|
| `s` | Seconds (default) |
| `m` | Minutes |
| `h` | Hours |
| `d` | Days |

### Options

```bash
# Send specific signal
$ timeout --signal=KILL 10 command

# Preserve exit status
$ timeout --preserve-status 10 command

# Verbose
$ timeout -v 10 command
```

### Examples

```bash
# Limit download time
$ timeout 60 wget http://example.com/large_file.zip

# Limit script execution
$ timeout 5m ./potentially_hanging_script.sh

# Force kill after grace period
$ timeout -k 5s 30s command
# Try SIGTERM after 30s, then SIGKILL after additional 5s
```

### Exit Codes

| Code | Meaning |
|------|---------|
| 0 | Command completed in time |
| 124 | Command timed out |
| 137 | Command killed (SIGKILL) |
| Other | Command's exit code |

---

## nohup - Run Immune to Hangups

Run a command that won't be killed when you log out.

### Basic Usage

```bash
# Run in background, immune to hangup
$ nohup long_running_command &

# Output goes to nohup.out by default
$ cat nohup.out
```

### Redirecting Output

```bash
# Custom output file
$ nohup command > output.log 2>&1 &

# Discard output
$ nohup command > /dev/null 2>&1 &
```

### Examples

```bash
# Run backup overnight
$ nohup ./backup.sh > /var/log/backup.log 2>&1 &

# Start server that persists after logout
$ nohup python server.py &

# Check if still running
$ jobs
$ ps aux | grep server.py
```

### Alternative: disown

```bash
# Start process normally
$ long_running_command &

# Disown it (removes from job table)
$ disown %1

# Or disown all background jobs
$ disown -a
```

---

## ulimit - Resource Limits

Set or display resource limits for the shell and its children.

### View Current Limits

```bash
# Show all limits
$ ulimit -a

# Show soft limits
$ ulimit -Sa

# Show hard limits
$ ulimit -Ha
```

### Common Limits

| Option | Resource |
|--------|----------|
| `-n` | Open files |
| `-u` | Max user processes |
| `-m` | Max memory size |
| `-v` | Virtual memory |
| `-s` | Stack size |
| `-f` | Max file size |
| `-t` | CPU time |
| `-c` | Core file size |

### Setting Limits

```bash
# Set max open files (soft limit)
$ ulimit -n 4096

# Set max processes
$ ulimit -u 1000

# Set unlimited (where permitted)
$ ulimit -n unlimited
```

### Examples

```bash
# Before running file-heavy process
$ ulimit -n 65535
$ ./many_files_process

# Limit file size (in 512-byte blocks)
$ ulimit -f 100000    # ~50MB max file

# Prevent core dumps
$ ulimit -c 0
```

### Permanent Changes

Edit `/etc/security/limits.conf`:
```
# <domain>  <type>  <item>  <value>
john        soft    nofile  4096
john        hard    nofile  65535
@developers soft    nproc   2048
*           soft    core    0
```

---

## Process Priority in Practice

### CPU-Intensive Jobs

```bash
# Compile in background with low priority
$ nice -n 19 make -j$(nproc) &

# Reduce priority of existing compile
$ renice 19 -p $(pgrep make)
```

### Long-Running Jobs

```bash
# Start job that survives logout
$ nohup nice -n 10 ./long_job.sh > job.log 2>&1 &
$ disown

# With timeout for safety
$ nohup timeout 24h ./job.sh > job.log 2>&1 &
```

### Resource-Heavy Applications

```bash
# Increase file limit before starting
$ ulimit -n 65535
$ ./database_server

# Or in script
#!/bin/bash
ulimit -n 65535
exec ./application
```

---

## 🏋️ Practice Exercises

1. Start a `sleep 60` with low priority (nice value 15)
2. Change the priority of a running process
3. Run a command with a 5-second timeout
4. Check your current ulimit settings
5. Run a process that will survive logout

### Solutions

```bash
# Exercise 1
nice -n 15 sleep 60 &

# Exercise 2
sleep 100 &
ps -o pid,ni,cmd | grep sleep
renice 10 -p $!
ps -o pid,ni,cmd | grep sleep

# Exercise 3
timeout 5 sleep 30
echo "Exit code: $?"  # Should be 124

# Exercise 4
ulimit -a

# Exercise 5
nohup sleep 300 &
disown
# or simply: nohup sleep 300 > /dev/null 2>&1 &
```

---

## 🔗 Next Topic

Continue to [Job Control](job-control.md) →
