# Module 05: Processes and Jobs

Learn to manage processes and control jobs in the shell.

## 🎯 Learning Objectives

By the end of this module, you will be able to:
- Understand how processes work in Linux
- View and monitor running processes
- Control process priorities and resource limits
- Manage background and foreground jobs
- Use monitoring tools effectively

## 📖 Topics Covered

| File | Description | Time |
|------|-------------|------|
| [process-management.md](process-management.md) | View and manage processes | 25 min |
| [process-control.md](process-control.md) | Control process behavior | 20 min |
| [job-control.md](job-control.md) | Background and foreground jobs | 20 min |
| [monitoring.md](monitoring.md) | System monitoring tools | 25 min |
| [exercises.md](exercises.md) | Practice exercises | 30 min |

## 🔧 Understanding Processes

```
┌─────────────────────────────────────────────────────────────────┐
│                    PROCESS HIERARCHY                            │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│                        init (PID 1)                             │
│                            │                                    │
│           ┌───────────┬────┴────┬───────────┐                  │
│           │           │         │           │                   │
│         systemd    sshd      cron        login                  │
│           │           │                     │                   │
│       ┌───┴───┐       │                     │                   │
│       │       │    sshd───bash           bash                   │
│    nginx  mysql       │                     │                   │
│                    vim │                  python                 │
│                       cat                                       │
│                                                                 │
│   • Every process has a parent (except init)                   │
│   • Processes are identified by PID (Process ID)               │
│   • Parent processes have PPID                                  │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

## 🔑 Key Concepts

### Process States

| State | Symbol | Description |
|-------|--------|-------------|
| Running | R | Currently executing |
| Sleeping | S | Waiting for event |
| Stopped | T | Suspended (Ctrl+Z) |
| Zombie | Z | Terminated but not cleaned up |
| Uninterruptible | D | Waiting for I/O |

### Process Identifiers

| ID | Description |
|----|-------------|
| PID | Process ID (unique) |
| PPID | Parent Process ID |
| UID | User ID (who started it) |
| GID | Group ID |

### Signals

Signals are used to communicate with processes:

| Signal | Number | Default Action | Description |
|--------|--------|----------------|-------------|
| SIGTERM | 15 | Terminate | Polite termination request |
| SIGKILL | 9 | Terminate | Force kill (can't be caught) |
| SIGSTOP | 19 | Stop | Pause process |
| SIGCONT | 18 | Continue | Resume process |
| SIGHUP | 1 | Terminate | Hangup / reload config |
| SIGINT | 2 | Terminate | Interrupt (Ctrl+C) |

## 📊 Command Quick Reference

### Viewing Processes

| Command | Description |
|---------|-------------|
| `ps` | Snapshot of processes |
| `top` | Real-time process viewer |
| `htop` | Enhanced process viewer |
| `pgrep` | Find processes by name |
| `pidof` | Get PID of a program |

### Managing Processes

| Command | Description |
|---------|-------------|
| `kill` | Send signal to process |
| `killall` | Kill by name |
| `pkill` | Kill by pattern |
| `nice` | Start with priority |
| `renice` | Change priority |

### Job Control

| Command | Description |
|---------|-------------|
| `jobs` | List background jobs |
| `fg` | Bring to foreground |
| `bg` | Send to background |
| `&` | Start in background |
| `Ctrl+Z` | Suspend current process |

## 💡 Tips

1. **Use SIGTERM before SIGKILL** - Give processes a chance to clean up
2. **Monitor resource usage** - Prevent runaway processes
3. **Use `nohup`** - Keep processes running after logout
4. **Check parent processes** - Understand process relationships

## ⚠️ Common Mistakes

- Using `kill -9` as first option (should be last resort)
- Forgetting backgrounded processes
- Not checking process ownership before killing
- Ignoring zombie processes

## 🔗 Next Steps

Start with:
1. [Process Management](process-management.md) - View and manage processes
2. [Process Control](process-control.md) - Priority and limits
3. [Job Control](job-control.md) - Background jobs
4. [Monitoring](monitoring.md) - System monitoring

After completing this module, continue to:
- [Module 06: Shell Scripting](../06-shell-scripting/)

## 📚 Additional Resources

- [Linux Process Management](https://tldp.org/LDP/tlk/kernel/processes.html)
- [Signal Handling](https://www.gnu.org/software/libc/manual/html_node/Signal-Handling.html)
