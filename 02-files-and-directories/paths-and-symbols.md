# Paths and Symbols

Understanding absolute paths, relative paths, and special path symbols.

## 📖 Table of Contents

- [Absolute vs Relative Paths](#absolute-vs-relative-paths)
- [Special Path Symbols](#special-path-symbols)
- [Path Resolution](#path-resolution)
- [Practical Examples](#practical-examples)

---

## Absolute vs Relative Paths

### Absolute Paths

An **absolute path** starts from the root directory (`/`) and specifies the complete path to a file or directory.

```bash
/home/john/Documents/report.txt
/etc/nginx/nginx.conf
/var/log/syslog
/usr/local/bin/python3
```

**Characteristics:**
- Always starts with `/`
- Works from any directory
- Unambiguous location
- Often longer to type

### Relative Paths

A **relative path** is relative to your current working directory.

```bash
Documents/report.txt      # From home directory
../Downloads/file.zip     # Go up one level, then down
./script.sh               # Current directory
../../etc/hosts           # Up two levels
```

**Characteristics:**
- Does NOT start with `/`
- Depends on current directory
- Shorter to type
- Can be confusing if in wrong directory

### Comparison

```bash
# Starting location
$ pwd
/home/john

# These are equivalent:
$ cat /home/john/Documents/report.txt    # Absolute
$ cat Documents/report.txt               # Relative
$ cat ./Documents/report.txt             # Relative (explicit)

# From /tmp, only absolute works the same way:
$ cd /tmp
$ cat /home/john/Documents/report.txt    # Still works
$ cat Documents/report.txt               # Fails (no Documents here)
```

---

## Special Path Symbols

### ~ (Tilde) - Home Directory

```bash
# Current user's home
$ echo ~
/home/john

$ cd ~
$ pwd
/home/john

# Specific user's home
$ echo ~jane
/home/jane

$ echo ~root
/root

# Use in paths
$ ls ~/Documents
$ cp file.txt ~/backup/
```

### . (Dot) - Current Directory

```bash
$ pwd
/home/john

$ ls .
Documents  Downloads  file.txt

# Explicitly reference current directory
$ ./script.sh           # Run script in current dir
$ cp file.txt ./backup/ # Copy to ./backup/

# Why use ./?
# - Security: explicitly run local executables
# - Clarity: show file is in current directory
```

### .. (Double Dot) - Parent Directory

```bash
$ pwd
/home/john/Documents

$ cd ..
$ pwd
/home/john

$ cd ../..
$ pwd
/home

# Use in paths
$ ls ../Downloads        # Sibling directory
$ cp file.txt ../        # Copy to parent
$ cat ../../etc/hosts    # Two levels up, then down
```

### - (Hyphen with cd) - Previous Directory

```bash
$ pwd
/home/john

$ cd /var/log
$ pwd
/var/log

$ cd -
/home/john

$ cd -
/var/log
```

### Summary Table

| Symbol | Meaning | Example |
|--------|---------|---------|
| `/` | Root directory / separator | `/home/john` |
| `~` | Home directory | `~/Documents` |
| `~user` | Specific user's home | `~jane/file.txt` |
| `.` | Current directory | `./script.sh` |
| `..` | Parent directory | `../config` |
| `-` | Previous directory (cd only) | `cd -` |

---

## Path Resolution

### How Paths Are Resolved

```bash
# Start: /home/john/Documents

$ cd ../Downloads/../Pictures/./vacation/../
# Step by step:
# ../           → /home/john/
# Downloads/    → /home/john/Downloads/
# ../           → /home/john/
# Pictures/     → /home/john/Pictures/
# ./            → /home/john/Pictures/
# vacation/     → /home/john/Pictures/vacation/
# ../           → /home/john/Pictures/

$ pwd
/home/john/Pictures
```

### Simplifying Paths

```bash
# Complex path
/home/john/../jane/./Documents/../Downloads

# Simplified
/home/jane/Downloads

# Use realpath to see resolved path
$ realpath /home/john/../jane/./Documents/../Downloads
/home/jane/Downloads
```

### The PATH Variable

The `PATH` environment variable tells the shell where to find executables:

```bash
$ echo $PATH
/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin

# Directories are separated by :
# Shell searches left to right

# Add to PATH (temporary)
$ export PATH="$PATH:/home/john/bin"

# Add to PATH (permanent) - add to ~/.bashrc
export PATH="$PATH:$HOME/bin"
```

---

## Practical Examples

### Navigating a Project

```bash
# Project structure
project/
├── src/
│   ├── main.c
│   └── utils/
│       └── helper.c
├── include/
│   └── header.h
└── build/

# From project/src/utils/
$ cd ../..           # Go to project/
$ cd ../../project   # Also goes to project/ (if inside project)
$ cd ~/projects/project  # Absolute path
```

### Copying Files Between Directories

```bash
# Current: /home/john/Documents/project

# Copy from sibling directory
$ cp ../Downloads/data.csv .

# Copy to parent
$ cp report.txt ../

# Copy using home directory
$ cp ~/templates/base.html ./src/
```

### Running Scripts

```bash
# Why ./script.sh instead of script.sh?
$ script.sh
command not found: script.sh

$ ./script.sh
Hello World!

# Because . (current directory) is NOT in PATH by default (security)
# You must explicitly specify ./
```

### Referencing Files in Scripts

```bash
#!/bin/bash

# Get the directory of the script itself
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Reference files relative to script location
source "$SCRIPT_DIR/config.sh"
cat "$SCRIPT_DIR/../data/input.txt"
```

---

## Useful Commands

### realpath - Get Absolute Path

```bash
$ realpath ./relative/path/../file.txt
/home/john/relative/file.txt

$ realpath ~
/home/john
```

### dirname / basename - Extract Path Parts

```bash
$ dirname /home/john/Documents/report.txt
/home/john/Documents

$ basename /home/john/Documents/report.txt
report.txt

$ basename /home/john/Documents/report.txt .txt
report
```

### readlink - Resolve Symbolic Links

```bash
$ readlink -f /usr/bin/python
/usr/bin/python3.10

$ readlink -f ./symlink
/actual/target/file
```

---

## 🏋️ Practice Exercises

1. Navigate to `/tmp` using an absolute path, then return home using `~`
2. From your home directory, navigate to a subdirectory and back using `..`
3. Use `cd -` to switch between two directories
4. Create a file and reference it using both absolute and relative paths
5. Find the absolute path of your current directory using multiple methods

### Solutions

```bash
# Exercise 1
cd /tmp
cd ~

# Exercise 2
cd Documents
cd ..

# Exercise 3
cd /tmp
cd /var/log
cd -     # back to /tmp
cd -     # back to /var/log

# Exercise 4
touch ~/testfile.txt
cat ~/testfile.txt                    # Using ~
cat /home/$USER/testfile.txt          # Absolute
cd ~ && cat testfile.txt              # Relative

# Exercise 5
pwd
echo $PWD
realpath .
readlink -f .
```

---

## 🔗 Next Topic

Continue to [Exercises](exercises.md) →
