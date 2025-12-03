# Module 05 Exercises

Practice process and job management.

## 🟢 Beginner Exercises

### Exercise 1: Viewing Processes
1. List all processes running on your system
2. Find the PID of your shell
3. Show processes in tree form

<details>
<summary>Solution</summary>

```bash
# 1. All processes
ps aux
# or: ps -ef

# 2. Your shell's PID
echo $$
# or: ps -p $$

# 3. Process tree
pstree
# or: ps axjf
```
</details>

---

### Exercise 2: Background Jobs Basics
1. Start `sleep 60` in the background
2. List your background jobs
3. Bring the job to foreground, then stop it

<details>
<summary>Solution</summary>

```bash
# 1. Start in background
sleep 60 &

# 2. List jobs
jobs
# Shows: [1]+  Running    sleep 60 &

# 3. Foreground and stop
fg %1
^C   # Ctrl+C to stop
```
</details>

---

### Exercise 3: Basic Process Information
Using the `ps` command:
1. Show only your processes
2. Show processes sorted by CPU usage
3. Show processes sorted by memory usage

<details>
<summary>Solution</summary>

```bash
# 1. Your processes
ps -u $USER

# 2. Sorted by CPU
ps aux --sort=-%cpu | head

# 3. Sorted by memory
ps aux --sort=-%mem | head
```
</details>

---

## 🟡 Intermediate Exercises

### Exercise 4: Job Control Workflow
Practice the suspend/resume workflow:
1. Start `top` in the foreground
2. Suspend it with Ctrl+Z
3. Start another command
4. Resume `top` in foreground

<details>
<summary>Solution</summary>

```bash
# 1. Start top
top

# 2. Press Ctrl+Z
^Z
# Shows: [1]+  Stopped    top

# 3. Run another command
ls -la

# 4. Resume top
fg %1
# or just: fg
```
</details>

---

### Exercise 5: Process Priority
1. Start a command with nice value 15
2. Find a running process and change its nice value
3. Verify the nice value changed

<details>
<summary>Solution</summary>

```bash
# 1. Start with nice value
nice -n 15 sleep 100 &

# 2. Change nice value
renice 10 -p $(pgrep sleep)
# or find PID first: ps aux | grep sleep

# 3. Verify
ps -o pid,ni,cmd -p $(pgrep sleep)
```
</details>

---

### Exercise 6: Finding Processes
1. Find all processes containing "bash" in the name
2. Find the PID of a specific program
3. Kill a process by name

<details>
<summary>Solution</summary>

```bash
# 1. Find processes with "bash"
pgrep -l bash
# or: ps aux | grep bash

# 2. Find PID of a program
pidof sleep
# or: pgrep sleep

# 3. Kill by name
pkill sleep
# or: killall sleep
```
</details>

---

## 🔴 Advanced Exercises

### Exercise 7: Process Monitoring
Set up monitoring for a specific process:
1. Find the PID of a running process
2. Watch its CPU and memory usage
3. See what files it has open

<details>
<summary>Solution</summary>

```bash
# Start a test process
python3 -c "import time; time.sleep(300)" &
PID=$!

# 1. Find PID (already have it from above)
echo $PID
# or: pgrep -f "python3"

# 2. Watch usage
watch -n 1 "ps -p $PID -o pid,ppid,%cpu,%mem,cmd"
# or use top: top -p $PID

# 3. Files open
lsof -p $PID
```
</details>

---

### Exercise 8: Signal Handling
Practice different ways to stop processes:
1. Start a background process
2. Send SIGTERM
3. If still running, send SIGKILL

<details>
<summary>Solution</summary>

```bash
# 1. Start process
sleep 300 &
PID=$!

# 2. Send SIGTERM (graceful)
kill $PID
# or: kill -15 $PID
# or: kill -TERM $PID

# 3. If still running, force kill
ps -p $PID  # Check if running
kill -9 $PID
# or: kill -KILL $PID
```
</details>

---

### Exercise 9: Long-Running Tasks
Set up a task that survives logout:
1. Create a script that runs for a long time
2. Run it with nohup
3. Verify it's running and check output

<details>
<summary>Solution</summary>

```bash
# 1. Create script
cat << 'EOF' > /tmp/longrun.sh
#!/bin/bash
for i in {1..60}; do
    echo "$(date): Iteration $i"
    sleep 1
done
EOF
chmod +x /tmp/longrun.sh

# 2. Run with nohup
nohup /tmp/longrun.sh > /tmp/longrun.log 2>&1 &
echo "PID: $!"

# 3. Verify
ps aux | grep longrun
cat /tmp/longrun.log
tail -f /tmp/longrun.log  # Follow output
```
</details>

---

### Exercise 10: System Investigation
Investigate what's happening on the system:
1. Find what's listening on network ports
2. Find processes with most open files
3. Display process tree for the init system

<details>
<summary>Solution</summary>

```bash
# 1. Network listeners
sudo lsof -i -P -n | grep LISTEN
# or: sudo netstat -tlnp
# or: sudo ss -tlnp

# 2. Processes with most open files
lsof | awk '{print $1}' | sort | uniq -c | sort -rn | head -10

# 3. Init process tree
pstree -p 1
# or: pstree systemd
```
</details>

---

## 💡 Real-World Scenarios

### Scenario 1: Runaway Process
You notice your system is slow. Find and handle the problem:

```bash
# Find CPU hog
ps aux --sort=-%cpu | head -5

# Or use top/htop
top

# Once identified, lower priority or kill
renice 19 -p <PID>
# or
kill <PID>
```

### Scenario 2: Stuck SSH Session
Your SSH session is frozen and you need to preserve work:

```bash
# From another terminal, find your processes
pgrep -u $USER

# See what's running
ps -u $USER

# Don't kill the shell - send SIGSTOP to problematic process
kill -19 <PROBLEM_PID>

# Or attach with gdb to debug (advanced)
```

### Scenario 3: Port Already in Use
Your application can't start because port is in use:

```bash
# Find what's using the port
lsof -i :8080
# or
sudo netstat -tlnp | grep 8080

# Kill it if appropriate
kill <PID>
# or
pkill -f "program using port"
```

---

## 📊 Quick Reference

```
┌─────────────────────────────────────────────────────────────┐
│                 PROCESS MANAGEMENT CHEAT SHEET              │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  VIEW PROCESSES                                             │
│  ps aux              All processes                          │
│  ps -ef              All processes (Unix style)             │
│  top / htop          Real-time viewer                       │
│  pstree              Process tree                           │
│                                                             │
│  FIND PROCESSES                                             │
│  pgrep name          Find by name                           │
│  pidof program       Get PID                                │
│  lsof -i :port       Find by port                           │
│                                                             │
│  CONTROL PROCESSES                                          │
│  kill PID            Terminate (SIGTERM)                    │
│  kill -9 PID         Force kill (SIGKILL)                   │
│  pkill name          Kill by name                           │
│  nice -n 10 cmd      Start with low priority                │
│  renice 10 -p PID    Change priority                        │
│                                                             │
│  JOB CONTROL                                                │
│  command &           Run in background                      │
│  Ctrl+Z              Suspend foreground                     │
│  jobs                List jobs                              │
│  fg %N               Bring to foreground                    │
│  bg %N               Resume in background                   │
│                                                             │
│  SURVIVE LOGOUT                                             │
│  nohup cmd &         Ignore hangup signal                   │
│  disown %N           Remove from job table                  │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

---

## 🔗 Continue Learning

- [Module 06: Shell Scripting](../06-shell-scripting/)
- [Cheatsheets: Essential Commands](../cheatsheets/essential-commands.md)
