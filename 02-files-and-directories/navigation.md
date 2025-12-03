# Navigation

Learn to move around the file system using `pwd`, `cd`, and `ls`.

## 📖 Table of Contents

- [pwd - Print Working Directory](#pwd---print-working-directory)
- [cd - Change Directory](#cd---change-directory)
- [ls - List Directory Contents](#ls---list-directory-contents)

---

## pwd - Print Working Directory

Shows your current location in the file system.

### Syntax
```bash
pwd [options]
```

### Examples

```bash
# Show current directory
$ pwd
/home/john

# After changing directory
$ cd /var/log
$ pwd
/var/log

# Show physical path (resolve symlinks)
$ pwd -P

# Show logical path (default, may include symlinks)
$ pwd -L
```

### 💡 Tip

The current directory is also stored in the `$PWD` environment variable:

```bash
$ echo $PWD
/home/john
```

---

## cd - Change Directory

Navigate to different directories.

### Syntax
```bash
cd [directory]
```

### Basic Usage

```bash
# Go to home directory
$ cd
$ pwd
/home/john

# Same as above
$ cd ~
$ cd $HOME

# Go to specific directory
$ cd /var/log
$ pwd
/var/log

# Go to parent directory
$ cd ..
$ pwd
/var

# Go up two levels
$ cd ../..
$ pwd
/
```

### Special Shortcuts

| Shortcut | Description |
|----------|-------------|
| `cd` | Go to home directory |
| `cd ~` | Go to home directory |
| `cd -` | Go to previous directory |
| `cd ..` | Go to parent directory |
| `cd ../..` | Go up two directories |
| `cd /` | Go to root directory |

### Examples with Special Shortcuts

```bash
# Start in home
$ pwd
/home/john

# Go to /var/log
$ cd /var/log
$ pwd
/var/log

# Go back to previous directory
$ cd -
/home/john

# Go to another user's home (if permitted)
$ cd ~jane
$ pwd
/home/jane

# Go back home
$ cd
$ pwd
/home/john
```

### Navigating with Paths

```bash
# Absolute path (starts with /)
$ cd /usr/local/bin

# Relative path (from current location)
$ cd Documents
$ cd ../Downloads
$ cd ./Pictures    # ./ is optional

# Combined
$ cd /home/john/Documents/../Downloads
$ pwd
/home/john/Downloads
```

### 💡 Tips

1. Use **Tab completion** to autocomplete directory names
2. `cd -` is great for toggling between two directories
3. Directory names are case-sensitive

### ⚠️ Common Errors

```bash
# Directory doesn't exist
$ cd /nonexistent
bash: cd: /nonexistent: No such file or directory

# Not a directory
$ cd /etc/passwd
bash: cd: /etc/passwd: Not a directory

# Permission denied
$ cd /root
bash: cd: /root: Permission denied
```

---

## ls - List Directory Contents

The most frequently used command for viewing files and directories.

### Syntax
```bash
ls [options] [files/directories...]
```

### Basic Usage

```bash
# List current directory
$ ls
Desktop  Documents  Downloads  file.txt

# List specific directory
$ ls /var
backups  cache  lib  local  log  mail

# List multiple locations
$ ls /var /tmp
/var:
backups  cache  lib  local  log  mail

/tmp:
temp_file.txt  session.tmp
```

### Common Options

| Option | Description |
|--------|-------------|
| `-l` | Long format with details |
| `-a` | Show all files (including hidden) |
| `-h` | Human-readable sizes (with -l) |
| `-R` | Recursive listing |
| `-t` | Sort by modification time |
| `-S` | Sort by size |
| `-r` | Reverse sort order |
| `-d` | List directories themselves, not contents |

### Long Format (-l)

```bash
$ ls -l
total 24
drwxr-xr-x 2 john john 4096 Dec  3 08:00 Desktop
drwxr-xr-x 3 john john 4096 Dec  3 08:00 Documents
drwxr-xr-x 2 john john 4096 Dec  3 08:00 Downloads
-rw-r--r-- 1 john john  256 Dec  3 08:00 file.txt
```

#### Understanding Long Format

```
drwxr-xr-x 2 john john 4096 Dec  3 08:00 Desktop
│└──┬───┘  │  │    │     │       │         │
│   │      │  │    │     │       │         └─ Name
│   │      │  │    │     │       └─ Modification date/time
│   │      │  │    │     └─ Size (bytes)
│   │      │  │    └─ Group
│   │      │  └─ Owner
│   │      └─ Link count
│   └─ Permissions (rwx for user, group, others)
└─ File type (d=directory, -=file, l=link)
```

### Show Hidden Files (-a)

```bash
$ ls -a
.  ..  .bashrc  .profile  Desktop  Documents  Downloads

$ ls -la
total 36
drwxr-xr-x 5 john john 4096 Dec  3 08:00 .
drwxr-xr-x 3 root root 4096 Dec  2 12:00 ..
-rw-r--r-- 1 john john  220 Dec  2 12:00 .bashrc
-rw-r--r-- 1 john john  807 Dec  2 12:00 .profile
drwxr-xr-x 2 john john 4096 Dec  3 08:00 Desktop
drwxr-xr-x 3 john john 4096 Dec  3 08:00 Documents
drwxr-xr-x 2 john john 4096 Dec  3 08:00 Downloads
```

### Human-Readable Sizes (-h)

```bash
$ ls -lh
total 1.5G
-rw-r--r-- 1 john john 1.2G Dec  3 08:00 large_file.iso
-rw-r--r-- 1 john john 256K Dec  3 08:00 document.pdf
-rw-r--r-- 1 john john  42 Dec  3 08:00 small.txt
```

### Sorting Options

```bash
# Sort by time (newest first)
$ ls -lt

# Sort by size (largest first)
$ ls -lS

# Reverse any sort
$ ls -ltr      # Oldest first
$ ls -lSr      # Smallest first
```

### Recursive Listing (-R)

```bash
$ ls -R
.:
Documents  Downloads

./Documents:
report.txt  notes/

./Documents/notes:
meeting.md

./Downloads:
file.zip
```

### Useful Combinations

```bash
# Most common: long format with human sizes
$ ls -lh

# Show all including hidden, with details
$ ls -la

# Newest files first
$ ls -lt

# One file per line
$ ls -1

# Only directories
$ ls -d */

# Files by extension
$ ls *.txt

# Size and sorted by size
$ ls -lhS
```

### Color Output

Most modern systems color `ls` output by default:

| Color | Meaning |
|-------|---------|
| Blue | Directory |
| Green | Executable |
| Cyan | Symbolic link |
| Red | Archive/compressed |
| Magenta | Image/media |

Enable color if not default:
```bash
$ ls --color=auto

# Add to ~/.bashrc
alias ls='ls --color=auto'
```

---

## 🏋️ Practice Exercises

1. Print your current working directory
2. Navigate to `/tmp`, then back to your home directory
3. Use `cd -` to switch between two directories
4. List all files (including hidden) in your home directory
5. List files sorted by size in `/var/log` (if accessible)
6. List only directories in your home directory

### Solutions

```bash
# Exercise 1
pwd

# Exercise 2
cd /tmp
cd ~
# or just: cd

# Exercise 3
cd /var
cd /tmp
cd -    # back to /var
cd -    # back to /tmp

# Exercise 4
ls -la ~

# Exercise 5
ls -lhS /var/log

# Exercise 6
ls -d */
```

---

## 🔗 Next Topic

Continue to [File Operations](file-operations.md) →
