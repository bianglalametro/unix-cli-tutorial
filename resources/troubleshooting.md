# 🔧 Troubleshooting Guide

> Common issues and their solutions

---

## 📋 Table of Contents

1. [Permission Issues](#permission-issues)
2. [Command Not Found](#command-not-found)
3. [File and Directory Issues](#file-and-directory-issues)
4. [Process Problems](#process-problems)
5. [Network Issues](#network-issues)
6. [Shell and Script Problems](#shell-and-script-problems)
7. [Disk and Storage Issues](#disk-and-storage-issues)
8. [System Performance](#system-performance)

---

## Permission Issues

### "Permission denied" Error

**Problem:**
```bash
$ ./script.sh
-bash: ./script.sh: Permission denied
```

**Solutions:**

1. **Make file executable:**
   ```bash
   chmod +x script.sh
   ./script.sh
   ```

2. **Run with bash directly:**
   ```bash
   bash script.sh
   ```

3. **Check current permissions:**
   ```bash
   ls -l script.sh
   ```

---

### "Operation not permitted" Error

**Problem:**
```bash
$ rm /etc/passwd
rm: cannot remove '/etc/passwd': Operation not permitted
```

**Solutions:**

1. **Use sudo for system files:**
   ```bash
   sudo rm /path/to/file
   ```

2. **Check if file is immutable:**
   ```bash
   lsattr filename
   # Remove immutable flag
   sudo chattr -i filename
   ```

---

### Cannot Access Directory

**Problem:**
```bash
$ cd /root
-bash: cd: /root: Permission denied
```

**Solutions:**

1. **Check permissions:**
   ```bash
   ls -ld /root
   ```

2. **Use sudo to access:**
   ```bash
   sudo ls /root
   # or start a root shell
   sudo -i
   ```

---

## Command Not Found

### "command not found" Error

**Problem:**
```bash
$ mycommand
-bash: mycommand: command not found
```

**Solutions:**

1. **Check if command is installed:**
   ```bash
   which mycommand
   whereis mycommand
   ```

2. **Check your PATH:**
   ```bash
   echo $PATH
   ```

3. **Install the missing package:**
   ```bash
   # Debian/Ubuntu
   sudo apt install package-name
   
   # RHEL/CentOS
   sudo yum install package-name
   
   # Arch Linux
   sudo pacman -S package-name
   ```

4. **Add directory to PATH:**
   ```bash
   export PATH=$PATH:/path/to/directory
   # Make permanent in ~/.bashrc
   ```

---

### Executable in Current Directory Not Found

**Problem:**
```bash
$ myscript.sh
-bash: myscript.sh: command not found
```

**Solutions:**

1. **Use ./ prefix:**
   ```bash
   ./myscript.sh
   ```

2. **Use full path:**
   ```bash
   /path/to/myscript.sh
   ```

---

## File and Directory Issues

### "No such file or directory"

**Problem:**
```bash
$ cat myfile.txt
cat: myfile.txt: No such file or directory
```

**Solutions:**

1. **Check if file exists:**
   ```bash
   ls -la myfile.txt
   ```

2. **Check current directory:**
   ```bash
   pwd
   ls -la
   ```

3. **Check for typos (case-sensitive):**
   ```bash
   ls -la | grep -i myfile
   ```

4. **Find the file:**
   ```bash
   find . -name "myfile.txt"
   find . -iname "myfile.txt"  # case-insensitive
   ```

---

### Cannot Delete File

**Problem:**
```bash
$ rm -rf stubborn_directory/
rm: cannot remove 'stubborn_directory/': Device or resource busy
```

**Solutions:**

1. **Check what's using it:**
   ```bash
   lsof +D stubborn_directory/
   fuser -v stubborn_directory/
   ```

2. **Kill processes using it:**
   ```bash
   fuser -k stubborn_directory/
   ```

3. **Unmount if mounted:**
   ```bash
   umount stubborn_directory/
   ```

---

### Filename with Special Characters

**Problem:**
```bash
$ rm -my-file.txt
rm: invalid option -- 'm'
```

**Solutions:**

1. **Use -- to end options:**
   ```bash
   rm -- -my-file.txt
   ```

2. **Use ./ prefix:**
   ```bash
   rm ./-my-file.txt
   ```

3. **Quote the filename:**
   ```bash
   rm "-my-file.txt"
   ```

---

### File with Spaces in Name

**Problem:**
```bash
$ cat my file.txt
cat: my: No such file or directory
cat: file.txt: No such file or directory
```

**Solutions:**

1. **Use quotes:**
   ```bash
   cat "my file.txt"
   cat 'my file.txt'
   ```

2. **Escape spaces:**
   ```bash
   cat my\ file.txt
   ```

---

## Process Problems

### Process Won't Die

**Problem:**
```bash
$ kill 1234
# Process still running
```

**Solutions:**

1. **Use stronger signal:**
   ```bash
   kill -9 1234    # SIGKILL
   kill -15 1234   # SIGTERM (default)
   ```

2. **Kill by name:**
   ```bash
   killall process_name
   pkill process_name
   ```

3. **Check if it's a zombie:**
   ```bash
   ps aux | grep Z
   # Zombies can only be cleaned by killing parent process
   ```

---

### Cannot Kill Process (Permission)

**Problem:**
```bash
$ kill 1234
-bash: kill: (1234) - Operation not permitted
```

**Solutions:**

1. **Use sudo:**
   ```bash
   sudo kill 1234
   sudo kill -9 1234
   ```

2. **Check process owner:**
   ```bash
   ps aux | grep 1234
   ```

---

### Finding a Runaway Process

**Problem:** System is slow, something is consuming resources.

**Solutions:**

1. **Find CPU-intensive processes:**
   ```bash
   top
   # Press P to sort by CPU
   
   ps aux --sort=-%cpu | head
   ```

2. **Find memory-intensive processes:**
   ```bash
   top
   # Press M to sort by memory
   
   ps aux --sort=-%mem | head
   ```

---

## Network Issues

### Cannot Connect to Host

**Problem:**
```bash
$ ssh user@host
ssh: connect to host host port 22: Connection refused
```

**Solutions:**

1. **Check if host is reachable:**
   ```bash
   ping host
   ```

2. **Check if port is open:**
   ```bash
   nc -zv host 22
   telnet host 22
   ```

3. **Check firewall:**
   ```bash
   sudo iptables -L
   sudo ufw status
   ```

---

### DNS Resolution Failed

**Problem:**
```bash
$ ping google.com
ping: google.com: Temporary failure in name resolution
```

**Solutions:**

1. **Check DNS configuration:**
   ```bash
   cat /etc/resolv.conf
   ```

2. **Test with IP directly:**
   ```bash
   ping 8.8.8.8
   ```

3. **Add DNS servers:**
   ```bash
   echo "nameserver 8.8.8.8" | sudo tee -a /etc/resolv.conf
   ```

---

## Shell and Script Problems

### Script Not Running Correctly

**Problem:** Script runs but doesn't produce expected results.

**Solutions:**

1. **Enable debugging:**
   ```bash
   bash -x script.sh
   # or add to script:
   set -x  # Enable debug
   set +x  # Disable debug
   ```

2. **Check for errors:**
   ```bash
   # Add to beginning of script:
   set -e  # Exit on error
   set -u  # Error on undefined variable
   ```

3. **Check line endings (Windows vs Unix):**
   ```bash
   file script.sh
   # Fix Windows line endings:
   dos2unix script.sh
   # or
   sed -i 's/\r$//' script.sh
   ```

---

### "Bad interpreter" Error

**Problem:**
```bash
$ ./script.sh
-bash: ./script.sh: /bin/bash^M: bad interpreter: No such file or directory
```

**Solution:**
```bash
# Windows line endings issue
dos2unix script.sh
# or
sed -i 's/\r$//' script.sh
```

---

### Variables Not Expanding

**Problem:**
```bash
$ echo '$HOME'
$HOME
```

**Solutions:**

1. **Use double quotes instead of single:**
   ```bash
   echo "$HOME"
   ```

2. **Variables don't expand in single quotes:**
   ```bash
   echo 'This is $HOME'  # Literal
   echo "This is $HOME"  # Expanded
   ```

---

### Unexpected End of File

**Problem:**
```bash
./script.sh: line 20: syntax error: unexpected end of file
```

**Solutions:**

1. **Check for unclosed quotes:**
   ```bash
   grep -n '"' script.sh
   grep -n "'" script.sh
   ```

2. **Check for missing `done`, `fi`, `esac`:**
   ```bash
   # Count structures
   grep -c 'if' script.sh
   grep -c 'fi' script.sh
   grep -c 'do' script.sh
   grep -c 'done' script.sh
   ```

---

## Disk and Storage Issues

### "No space left on device"

**Problem:**
```bash
$ cp large_file /destination
cp: error writing '/destination/large_file': No space left on device
```

**Solutions:**

1. **Check disk usage:**
   ```bash
   df -h
   ```

2. **Find large files:**
   ```bash
   find / -type f -size +100M 2>/dev/null | head
   du -sh /* 2>/dev/null | sort -h | tail
   ```

3. **Clear temporary files:**
   ```bash
   sudo rm -rf /tmp/*
   sudo journalctl --vacuum-time=7d
   ```

4. **Check inode usage:**
   ```bash
   df -i
   ```

---

### "Disk quota exceeded"

**Problem:**
```bash
$ touch newfile
touch: cannot touch 'newfile': Disk quota exceeded
```

**Solutions:**

1. **Check your quota:**
   ```bash
   quota -s
   ```

2. **Find your large files:**
   ```bash
   du -sh ~/* | sort -h | tail
   ```

3. **Request quota increase** from system administrator.

---

## System Performance

### System is Slow

**Solutions:**

1. **Check load average:**
   ```bash
   uptime
   w
   ```

2. **Check CPU usage:**
   ```bash
   top
   htop
   ```

3. **Check memory:**
   ```bash
   free -h
   ```

4. **Check disk I/O:**
   ```bash
   iostat -x 1
   iotop
   ```

5. **Check for swapping:**
   ```bash
   vmstat 1
   # Look at 'si' and 'so' columns
   ```

---

### High CPU Usage

**Solutions:**

1. **Identify the process:**
   ```bash
   top
   ps aux --sort=-%cpu | head
   ```

2. **Lower process priority:**
   ```bash
   renice 19 -p PID
   ```

3. **Limit CPU usage:**
   ```bash
   cpulimit -p PID -l 50
   ```

---

### High Memory Usage

**Solutions:**

1. **Identify memory hogs:**
   ```bash
   ps aux --sort=-%mem | head
   ```

2. **Clear page cache:**
   ```bash
   sudo sh -c 'echo 3 > /proc/sys/vm/drop_caches'
   ```

3. **Check for memory leaks:**
   ```bash
   # Monitor process memory over time
   while true; do ps -o pid,rss,comm -p PID; sleep 60; done
   ```

---

## 🆘 Getting Help

### When You're Stuck

1. **Read the manual:**
   ```bash
   man command
   command --help
   ```

2. **Search for solutions:**
   - [Stack Overflow](https://stackoverflow.com/)
   - [Unix & Linux Stack Exchange](https://unix.stackexchange.com/)
   - [Google the exact error message](https://google.com/)

3. **Ask for help:**
   - Include the exact error message
   - Include the command you ran
   - Include relevant context (OS, shell version)

### Useful Diagnostic Commands

```bash
# System info
uname -a
cat /etc/os-release

# Environment
env
echo $PATH
echo $SHELL

# Process info
ps aux
top

# Disk info
df -h
du -sh *

# Network info
ip addr
netstat -tuln

# Logs
journalctl -xe
dmesg | tail
cat /var/log/syslog | tail
```

---

**📖 Related Resources:**
- [Recommended Books](books.md)
- [Useful Websites](websites.md)
