# File Permissions

Control who can read, write, and execute files.

## 📖 Table of Contents

- [Understanding Permissions](#understanding-permissions)
- [Reading Permissions](#reading-permissions)
- [chmod - Change Permissions](#chmod---change-permissions)
- [Special Permissions](#special-permissions)
- [umask - Default Permissions](#umask---default-permissions)

---

## Understanding Permissions

### The Three Permission Types

| Permission | Symbol | File Effect | Directory Effect |
|------------|--------|-------------|------------------|
| **Read** | `r` | View file contents | List directory contents |
| **Write** | `w` | Modify file contents | Create/delete files |
| **Execute** | `x` | Run as program | Enter directory (cd) |

### The Three User Classes

| Class | Symbol | Description |
|-------|--------|-------------|
| **User** | `u` | The file owner |
| **Group** | `g` | Members of the file's group |
| **Others** | `o` | Everyone else |
| **All** | `a` | All three classes |

### Permission Diagram

```
-rwxr-xr-- 1 john staff 4096 Dec  3 08:00 script.sh
│└─┬┘└─┬┘└─┬┘
│  │   │   │
│  │   │   └── Others: r-- (read only)
│  │   └── Group: r-x (read and execute)
│  └── User: rwx (read, write, execute)
└── File type: - (regular file)
```

---

## Reading Permissions

### Using ls -l

```bash
$ ls -l
drwxr-xr-x 2 john staff 4096 Dec  3 08:00 Documents
-rwxr-xr-- 1 john staff  512 Dec  3 08:00 script.sh
-rw-r--r-- 1 john staff 1024 Dec  3 08:00 file.txt
lrwxrwxrwx 1 john staff   10 Dec  3 08:00 link -> file.txt
```

### File Type Indicators

| Symbol | Type |
|--------|------|
| `-` | Regular file |
| `d` | Directory |
| `l` | Symbolic link |
| `c` | Character device |
| `b` | Block device |
| `s` | Socket |
| `p` | Named pipe |

### Symbolic vs Octal Notation

| Symbolic | Octal | Description |
|----------|-------|-------------|
| `rwx` | 7 | Read + Write + Execute |
| `rw-` | 6 | Read + Write |
| `r-x` | 5 | Read + Execute |
| `r--` | 4 | Read only |
| `-wx` | 3 | Write + Execute |
| `-w-` | 2 | Write only |
| `--x` | 1 | Execute only |
| `---` | 0 | No permissions |

### Octal Calculation

```
r = 4, w = 2, x = 1

Example: rwxr-xr--
  User:  r(4) + w(2) + x(1) = 7
  Group: r(4) + w(0) + x(1) = 5
  Other: r(4) + w(0) + x(0) = 4
  
Result: 754
```

---

## chmod - Change Permissions

Change file permissions using symbolic or octal notation.

### Syntax
```bash
chmod [options] mode file...
```

### Symbolic Mode

| Operator | Description |
|----------|-------------|
| `+` | Add permission |
| `-` | Remove permission |
| `=` | Set exact permission |

```bash
# Add execute for user
$ chmod u+x script.sh

# Remove write for group and others
$ chmod go-w file.txt

# Set exact permissions for all
$ chmod a=r file.txt

# Multiple changes
$ chmod u+x,g-w,o-rwx file.txt

# Add execute to directories only
$ chmod +X directory/
```

### Examples - Symbolic Mode

```bash
# Make script executable by owner
$ chmod u+x script.sh
$ ls -l script.sh
-rwxr--r-- 1 john staff 512 Dec  3 08:00 script.sh

# Make file readable by everyone
$ chmod a+r document.txt

# Remove all permissions for others
$ chmod o= file.txt

# Make file writable by group
$ chmod g+w shared.txt

# Combined operations
$ chmod u=rwx,g=rx,o=r file.txt
```

### Octal Mode

```bash
# Format: chmod NNN file
# Where N is: user group others

# Common permission sets
$ chmod 755 script.sh    # rwxr-xr-x (executable script)
$ chmod 644 file.txt     # rw-r--r-- (regular file)
$ chmod 600 secret.txt   # rw------- (private file)
$ chmod 700 private_dir  # rwx------ (private directory)
$ chmod 777 open_file    # rwxrwxrwx (everyone can do everything - dangerous!)
```

### Common Permission Patterns

| Octal | Symbolic | Use Case |
|-------|----------|----------|
| `755` | `rwxr-xr-x` | Executable programs, public directories |
| `644` | `rw-r--r--` | Regular files, config files |
| `600` | `rw-------` | Private files, SSH keys |
| `700` | `rwx------` | Private directories |
| `775` | `rwxrwxr-x` | Shared executable directories |
| `664` | `rw-rw-r--` | Shared files |
| `666` | `rw-rw-rw-` | World-writable file (use carefully) |
| `777` | `rwxrwxrwx` | World-writable directory (dangerous) |

### Options

| Option | Description |
|--------|-------------|
| `-R` | Recursive (change all files in directory) |
| `-v` | Verbose (show what's being changed) |
| `--reference=file` | Use another file's permissions |

```bash
# Change all files in directory
$ chmod -R 755 project/

# Verbose output
$ chmod -v 644 file.txt
mode of 'file.txt' changed from 0755 (rwxr-xr-x) to 0644 (rw-r--r--)

# Copy permissions from another file
$ chmod --reference=template.txt newfile.txt
```

---

## Special Permissions

### setuid (Set User ID)

When set on an executable, it runs with the file owner's privileges.

```bash
# The 's' in user position indicates setuid
$ ls -l /usr/bin/passwd
-rwsr-xr-x 1 root root 68208 Dec  3 08:00 /usr/bin/passwd
   ^
   setuid

# Set setuid (octal: 4xxx)
$ chmod u+s program
$ chmod 4755 program
```

### setgid (Set Group ID)

- On executable: Runs with file's group privileges
- On directory: New files inherit directory's group

```bash
# The 's' in group position indicates setgid
$ ls -ld /shared
drwxr-sr-x 2 john developers 4096 Dec  3 08:00 /shared
      ^
      setgid

# Set setgid (octal: 2xxx)
$ chmod g+s directory
$ chmod 2755 directory
```

### Sticky Bit

On a directory, only file owners can delete their files.

```bash
# The 't' indicates sticky bit
$ ls -ld /tmp
drwxrwxrwt 10 root root 4096 Dec  3 08:00 /tmp
         ^
         sticky bit

# Set sticky bit (octal: 1xxx)
$ chmod +t directory
$ chmod 1777 directory
```

### Special Permissions Summary

| Permission | Octal | Effect |
|------------|-------|--------|
| setuid | 4000 | Execute as owner |
| setgid | 2000 | Execute as group / inherit group |
| sticky | 1000 | Only owner can delete |

```bash
# Full octal with special permissions
$ chmod 4755 file    # setuid + rwxr-xr-x
$ chmod 2755 dir     # setgid + rwxr-xr-x
$ chmod 1777 dir     # sticky + rwxrwxrwx
```

---

## umask - Default Permissions

The umask sets default permissions for new files.

### How umask Works

```
Files:      666 (rw-rw-rw-) - umask = default permissions
Directories: 777 (rwxrwxrwx) - umask = default permissions
```

### Viewing umask

```bash
$ umask
0022

$ umask -S
u=rwx,g=rx,o=rx
```

### Common umask Values

| umask | File Result | Directory Result | Description |
|-------|-------------|------------------|-------------|
| `022` | 644 | 755 | Default (standard) |
| `002` | 664 | 775 | Group-friendly |
| `077` | 600 | 700 | Private |
| `027` | 640 | 750 | Private from others |

### Setting umask

```bash
# For current session
$ umask 077

# Permanent (add to ~/.bashrc)
umask 022
```

### Example

```bash
$ umask 022
$ touch newfile.txt
$ ls -l newfile.txt
-rw-r--r-- 1 john john 0 Dec  3 08:00 newfile.txt
# 666 - 022 = 644

$ mkdir newdir
$ ls -ld newdir
drwxr-xr-x 2 john john 4096 Dec  3 08:00 newdir
# 777 - 022 = 755
```

---

## Directory Permissions Explained

Directories need different permissions than files:

| Permission | Effect on Directory |
|------------|---------------------|
| `r` | List contents (`ls`) |
| `w` | Create/delete files |
| `x` | Enter directory (`cd`) |

### Examples

```bash
# Can list but not enter
$ chmod 444 testdir
$ ls testdir
file1.txt  file2.txt
$ cd testdir
bash: cd: testdir: Permission denied

# Can enter but not list
$ chmod 111 testdir
$ cd testdir
$ ls
ls: cannot open directory '.': Permission denied

# Can list and enter, but not modify
$ chmod 555 testdir
$ cd testdir && ls
file1.txt  file2.txt
$ touch newfile
touch: cannot touch 'newfile': Permission denied
```

---

## 🏋️ Practice Exercises

1. Create a file and view its default permissions
2. Make a script executable by the owner only
3. Create a directory that anyone can write to, but only owners can delete
4. Set permissions so only you can read a private file
5. Check your umask and calculate the default permissions for new files

### Solutions

```bash
# Exercise 1
touch test.txt
ls -l test.txt

# Exercise 2
echo '#!/bin/bash' > script.sh
echo 'echo "Hello"' >> script.sh
chmod u+x script.sh
ls -l script.sh

# Exercise 3
mkdir shared
chmod 1777 shared
ls -ld shared

# Exercise 4
touch private.txt
chmod 600 private.txt
ls -l private.txt

# Exercise 5
umask
# If umask is 022:
# Files: 666 - 022 = 644 (rw-r--r--)
# Dirs: 777 - 022 = 755 (rwxr-xr-x)
```

---

## 🔗 Next Topic

Continue to [Links](links.md) →
