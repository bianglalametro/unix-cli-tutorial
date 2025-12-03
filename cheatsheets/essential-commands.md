# 📋 Essential Commands Cheatsheet

> Quick reference guide for the most commonly used UNIX/Linux commands

---

## 🗂️ File and Directory Operations

### Navigation

| Command | Description | Example |
|---------|-------------|---------|
| `pwd` | Print working directory | `pwd` → `/home/user` |
| `cd` | Change directory | `cd /var/log` |
| `cd ~` | Go to home directory | `cd ~` |
| `cd ..` | Go up one level | `cd ..` |
| `cd -` | Go to previous directory | `cd -` |
| `ls` | List directory contents | `ls -la` |
| `ls -l` | Long format listing | `ls -l` |
| `ls -a` | Show hidden files | `ls -a` |
| `ls -h` | Human readable sizes | `ls -lh` |

### File Operations

| Command | Description | Example |
|---------|-------------|---------|
| `touch` | Create empty file | `touch newfile.txt` |
| `cp` | Copy file | `cp source.txt dest.txt` |
| `cp -r` | Copy directory recursively | `cp -r dir1/ dir2/` |
| `mv` | Move/rename file | `mv old.txt new.txt` |
| `rm` | Remove file | `rm file.txt` |
| `rm -r` | Remove directory recursively | `rm -r directory/` |
| `rm -f` | Force remove | `rm -f file.txt` |

### Directory Operations

| Command | Description | Example |
|---------|-------------|---------|
| `mkdir` | Create directory | `mkdir newdir` |
| `mkdir -p` | Create nested directories | `mkdir -p a/b/c` |
| `rmdir` | Remove empty directory | `rmdir emptydir` |
| `tree` | Display directory tree | `tree -L 2` |

---

## 📄 Viewing and Editing Files

### Viewing Content

| Command | Description | Example |
|---------|-------------|---------|
| `cat` | Display file contents | `cat file.txt` |
| `less` | Page through file | `less file.txt` |
| `head` | Show first lines | `head -n 10 file.txt` |
| `tail` | Show last lines | `tail -n 10 file.txt` |
| `tail -f` | Follow file updates | `tail -f /var/log/syslog` |

### Text Editors

| Command | Description | Example |
|---------|-------------|---------|
| `nano` | Simple text editor | `nano file.txt` |
| `vim` | Advanced text editor | `vim file.txt` |
| `vi` | Classic text editor | `vi file.txt` |

---

## 🔍 Searching and Finding

| Command | Description | Example |
|---------|-------------|---------|
| `find` | Find files | `find . -name "*.txt"` |
| `find` | Find by type | `find . -type f` |
| `find` | Find by size | `find . -size +100M` |
| `locate` | Quick file search | `locate filename` |
| `which` | Find command location | `which python` |
| `whereis` | Find binary/source/manual | `whereis bash` |
| `grep` | Search file contents | `grep "pattern" file.txt` |
| `grep -r` | Search recursively | `grep -r "TODO" .` |
| `grep -i` | Case insensitive | `grep -i "error" log.txt` |
| `grep -n` | Show line numbers | `grep -n "pattern" file.txt` |

---

## 📝 Text Processing

| Command | Description | Example |
|---------|-------------|---------|
| `wc` | Word/line/char count | `wc -l file.txt` |
| `sort` | Sort lines | `sort file.txt` |
| `sort -n` | Numeric sort | `sort -n numbers.txt` |
| `sort -r` | Reverse sort | `sort -r file.txt` |
| `uniq` | Remove duplicates | `sort file.txt \| uniq` |
| `cut` | Extract columns | `cut -d',' -f1 file.csv` |
| `tr` | Translate characters | `tr 'a-z' 'A-Z'` |
| `sed` | Stream editor | `sed 's/old/new/g' file.txt` |
| `awk` | Pattern processing | `awk '{print $1}' file.txt` |

---

## 🔐 Permissions and Ownership

### Viewing Permissions

```bash
# Permission format: drwxrwxrwx
# d = directory, - = file
# rwx = read, write, execute
# First group: owner, Second: group, Third: others
```

| Command | Description | Example |
|---------|-------------|---------|
| `ls -l` | View permissions | `ls -l file.txt` |
| `stat` | Detailed file info | `stat file.txt` |

### Changing Permissions

| Command | Description | Example |
|---------|-------------|---------|
| `chmod` | Change permissions | `chmod 755 script.sh` |
| `chmod +x` | Add execute | `chmod +x script.sh` |
| `chmod -w` | Remove write | `chmod -w file.txt` |
| `chmod u+x` | Owner execute | `chmod u+x script.sh` |
| `chown` | Change owner | `chown user:group file` |

### Permission Numbers

| Number | Permission | Binary |
|--------|------------|--------|
| 7 | rwx | 111 |
| 6 | rw- | 110 |
| 5 | r-x | 101 |
| 4 | r-- | 100 |
| 3 | -wx | 011 |
| 2 | -w- | 010 |
| 1 | --x | 001 |
| 0 | --- | 000 |

---

## ⚙️ Process Management

| Command | Description | Example |
|---------|-------------|---------|
| `ps` | List processes | `ps aux` |
| `ps -ef` | Full format listing | `ps -ef` |
| `top` | Real-time process viewer | `top` |
| `htop` | Interactive process viewer | `htop` |
| `kill` | Terminate process | `kill PID` |
| `kill -9` | Force kill | `kill -9 PID` |
| `killall` | Kill by name | `killall process_name` |
| `pkill` | Kill by pattern | `pkill -f pattern` |
| `pgrep` | Find PID by name | `pgrep firefox` |

### Job Control

| Command | Description | Example |
|---------|-------------|---------|
| `jobs` | List background jobs | `jobs` |
| `fg` | Bring to foreground | `fg %1` |
| `bg` | Send to background | `bg %1` |
| `&` | Run in background | `./script.sh &` |
| `Ctrl+Z` | Suspend process | - |
| `Ctrl+C` | Interrupt process | - |

---

## 🌐 Networking

| Command | Description | Example |
|---------|-------------|---------|
| `ping` | Test connectivity | `ping google.com` |
| `curl` | Transfer data | `curl https://api.example.com` |
| `wget` | Download files | `wget https://example.com/file.zip` |
| `ssh` | Secure shell | `ssh user@host` |
| `scp` | Secure copy | `scp file.txt user@host:/path` |
| `netstat` | Network statistics | `netstat -tuln` |
| `ss` | Socket statistics | `ss -tuln` |
| `ifconfig` | Network interfaces | `ifconfig` |
| `ip` | Show/manipulate routing | `ip addr` |

---

## 📦 Compression and Archives

| Command | Description | Example |
|---------|-------------|---------|
| `tar -cvf` | Create archive | `tar -cvf archive.tar dir/` |
| `tar -xvf` | Extract archive | `tar -xvf archive.tar` |
| `tar -czvf` | Create gzip archive | `tar -czvf archive.tar.gz dir/` |
| `tar -xzvf` | Extract gzip archive | `tar -xzvf archive.tar.gz` |
| `gzip` | Compress file | `gzip file.txt` |
| `gunzip` | Decompress file | `gunzip file.txt.gz` |
| `zip` | Create zip archive | `zip archive.zip file1 file2` |
| `unzip` | Extract zip | `unzip archive.zip` |

---

## 💾 Disk and System Information

| Command | Description | Example |
|---------|-------------|---------|
| `df` | Disk space usage | `df -h` |
| `du` | Directory space usage | `du -sh *` |
| `free` | Memory usage | `free -h` |
| `uname -a` | System information | `uname -a` |
| `uptime` | System uptime | `uptime` |
| `whoami` | Current username | `whoami` |
| `hostname` | System hostname | `hostname` |
| `date` | Current date/time | `date` |
| `cal` | Calendar | `cal` |

---

## 🔄 I/O Redirection

| Operator | Description | Example |
|----------|-------------|---------|
| `>` | Redirect stdout (overwrite) | `echo "hello" > file.txt` |
| `>>` | Redirect stdout (append) | `echo "hello" >> file.txt` |
| `<` | Redirect stdin | `sort < unsorted.txt` |
| `2>` | Redirect stderr | `cmd 2> error.log` |
| `2>&1` | Redirect stderr to stdout | `cmd > all.log 2>&1` |
| `\|` | Pipe output | `cat file \| grep pattern` |
| `tee` | Redirect and display | `cmd \| tee output.txt` |

---

## 📚 Help and Documentation

| Command | Description | Example |
|---------|-------------|---------|
| `man` | Manual pages | `man ls` |
| `--help` | Command help | `ls --help` |
| `info` | Info pages | `info coreutils` |
| `whatis` | One-line description | `whatis ls` |
| `apropos` | Search man pages | `apropos search` |

---

## 🔑 Keyboard Shortcuts

### Line Editing

| Shortcut | Action |
|----------|--------|
| `Ctrl+A` | Go to beginning of line |
| `Ctrl+E` | Go to end of line |
| `Ctrl+U` | Delete to beginning |
| `Ctrl+K` | Delete to end |
| `Ctrl+W` | Delete word backward |
| `Ctrl+Y` | Paste deleted text |
| `Ctrl+L` | Clear screen |

### History

| Shortcut | Action |
|----------|--------|
| `↑` / `↓` | Previous/next command |
| `Ctrl+R` | Reverse search history |
| `!!` | Repeat last command |
| `!$` | Last argument |
| `history` | Show command history |

---

## 💡 Quick Tips

```bash
# Create alias for common commands
alias ll='ls -la'
alias ..='cd ..'

# Quick directory creation and entry
mkdir -p newdir && cd newdir

# Find and delete files older than 30 days
find . -mtime +30 -delete

# Count lines in all .txt files
find . -name "*.txt" -exec wc -l {} +

# Monitor log file in real-time
tail -f /var/log/syslog | grep error

# Quick backup with timestamp
cp file.txt file.txt.$(date +%Y%m%d)
```

---

**📖 Related Resources:**
- [File Permissions Cheatsheet](file-permissions.md)
- [Regex Cheatsheet](regex-cheatsheet.md)
- [Vim Cheatsheet](vim-cheatsheet.md)
- [Scripting Cheatsheet](scripting-cheatsheet.md)
