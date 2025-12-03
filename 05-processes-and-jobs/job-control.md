# Job Control

Manage background and foreground jobs in the shell.

## 📖 Table of Contents

- [Understanding Jobs](#understanding-jobs)
- [Background and Foreground](#background-and-foreground)
- [jobs - List Jobs](#jobs---list-jobs)
- [fg - Foreground](#fg---foreground)
- [bg - Background](#bg---background)
- [Ctrl+Z - Suspend](#ctrlz---suspend)
- [Practical Workflows](#practical-workflows)

---

## Understanding Jobs

```
┌─────────────────────────────────────────────────────────────────┐
│                       JOB STATES                                │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│   ┌─────────────┐                      ┌─────────────┐         │
│   │  FOREGROUND │                      │  BACKGROUND │         │
│   │  (running)  │                      │  (running)  │         │
│   └──────┬──────┘                      └──────┬──────┘         │
│          │                                    │                 │
│          │ Ctrl+Z                             │                 │
│          │                                    │                 │
│          ▼                                    │                 │
│   ┌─────────────┐                             │                 │
│   │   STOPPED   │ ◄──────────────────────────┘                 │
│   │  (paused)   │      Ctrl+Z (if fg'ed)                       │
│   └──────┬──────┘                                              │
│          │                                                      │
│      ┌───┴───┐                                                 │
│      │       │                                                 │
│      ▼       ▼                                                 │
│     fg      bg                                                 │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### Job vs Process

- **Process**: Any running program (has PID)
- **Job**: A process started from the current shell (has job number)

Jobs are shell-specific; if you start a new terminal, you won't see jobs from other terminals.

---

## Background and Foreground

### Starting in Background

```bash
# Add & at the end
$ long_command &
[1] 12345
# [1] = job number, 12345 = PID
```

### Moving to Background

```bash
# 1. Suspend with Ctrl+Z
$ long_command
^Z
[1]+  Stopped                 long_command

# 2. Resume in background
$ bg
[1]+ long_command &
```

### Bringing to Foreground

```bash
# After starting in background
$ long_command &
[1] 12345

# Bring to foreground
$ fg
long_command
# Now it's in foreground, Ctrl+C to stop
```

---

## jobs - List Jobs

Display jobs in the current shell.

### Basic Usage

```bash
$ jobs
[1]-  Running                 sleep 100 &
[2]+  Stopped                 vim file.txt
```

### Options

| Option | Description |
|--------|-------------|
| `-l` | Include PIDs |
| `-p` | PIDs only |
| `-r` | Running jobs only |
| `-s` | Stopped jobs only |

```bash
$ jobs -l
[1]- 12345 Running                 sleep 100 &
[2]+ 12346 Stopped                 vim file.txt
```

### Job Indicators

| Symbol | Meaning |
|--------|---------|
| `+` | Current job (default for fg/bg) |
| `-` | Previous job |

### Status Types

| Status | Meaning |
|--------|---------|
| Running | Executing in background |
| Stopped | Suspended (Ctrl+Z) |
| Done | Completed |
| Terminated | Killed |

---

## fg - Foreground

Bring a job to the foreground.

### Usage

```bash
# Bring current job (marked with +)
$ fg

# Bring specific job by number
$ fg %1
$ fg %2

# Bring by command name
$ fg %vim
$ fg %sleep
```

### Job Specifiers

| Specifier | Meaning |
|-----------|---------|
| `%N` | Job number N |
| `%string` | Job starting with string |
| `%?string` | Job containing string |
| `%%` or `%+` | Current job |
| `%-` | Previous job |

```bash
# Examples
$ fg %1           # Job 1
$ fg %sleep       # Job starting with "sleep"
$ fg %?backup     # Job containing "backup"
$ fg %%           # Current job
```

---

## bg - Background

Resume a stopped job in the background.

### Usage

```bash
# Resume current stopped job
$ bg

# Resume specific job
$ bg %1
```

### Workflow Example

```bash
# Start a long process
$ find / -name "*.log" 2>/dev/null
# Realize it's taking too long...

# Suspend it
^Z
[1]+  Stopped                 find / -name "*.log" 2>/dev/null

# Resume in background
$ bg %1
[1]+ find / -name "*.log" 2>/dev/null &

# Continue other work while it runs
$ jobs
[1]+  Running                 find / -name "*.log" 2>/dev/null &
```

---

## Ctrl+Z - Suspend

Suspend (stop) the foreground process.

### How It Works

1. Press `Ctrl+Z`
2. Process receives `SIGTSTP`
3. Process is stopped (paused)
4. Shell regains control

```bash
$ vim large_file.txt
# Press Ctrl+Z
^Z
[1]+  Stopped                 vim large_file.txt

# Do something else
$ ls -la

# Return to vim
$ fg
# Back in vim where you left off
```

### Difference: Ctrl+Z vs Ctrl+C

| Shortcut | Signal | Effect |
|----------|--------|--------|
| Ctrl+Z | SIGTSTP | Stop (pause) - can resume |
| Ctrl+C | SIGINT | Interrupt (terminate) |

---

## Practical Workflows

### Running Multiple Tasks

```bash
# Start several background tasks
$ ./download.sh &
$ ./process.sh &
$ ./upload.sh &

# Check status
$ jobs
[1]   Running                 ./download.sh &
[2]-  Running                 ./process.sh &
[3]+  Running                 ./upload.sh &
```

### Quick Task Switching

```bash
# Working in vim
$ vim config.yml
^Z

# Check something
$ cat /etc/passwd | head

# Back to vim
$ fg

# Oops, need to check something else
^Z
$ grep "pattern" large_file.txt

# Back to vim again
$ fg
```

### Background Long Tasks

```bash
# Start download in background
$ wget http://example.com/huge_file.iso &

# Monitor while doing other things
$ jobs
[1]+  Running                 wget http://example.com/huge_file.iso &

# Bring to foreground to check progress
$ fg
# Ctrl+Z to background again
^Z
$ bg
```

### Waiting for Background Jobs

```bash
# Start multiple jobs
$ process1 &
$ process2 &
$ process3 &

# Wait for all to complete
$ wait

# Or wait for specific job
$ wait %1
```

---

## Killing Jobs

```bash
# Kill by job number
$ kill %1

# Kill current job
$ kill %%

# Force kill
$ kill -9 %1

# Kill all background jobs
$ kill $(jobs -p)
```

---

## Job Control in Scripts

### Disabling Job Control

Job control is usually disabled in scripts. To enable:

```bash
#!/bin/bash
set -m  # Enable job control
```

### Background Processes in Scripts

```bash
#!/bin/bash

# Start background processes
./task1.sh &
PID1=$!

./task2.sh &
PID2=$!

# Wait for both
wait $PID1
wait $PID2

echo "Both tasks complete"
```

---

## 🏋️ Practice Exercises

1. Start `sleep 100` in the background
2. List all jobs with their PIDs
3. Suspend a foreground process and resume it in the background
4. Bring a background job to the foreground and then suspend it
5. Kill a background job

### Solutions

```bash
# Exercise 1
sleep 100 &
# Shows: [1] 12345

# Exercise 2
jobs -l

# Exercise 3
sleep 200
^Z
bg

# Exercise 4
sleep 300 &
fg %1
^Z

# Exercise 5
sleep 400 &
kill %1
# or: kill $(jobs -p)
jobs  # Should show "Terminated"
```

---

## 🔗 Next Topic

Continue to [Monitoring](monitoring.md) →
