# File Ownership

Understanding who owns files and how ownership works.

## 📖 Table of Contents

- [Understanding Ownership](#understanding-ownership)
- [Viewing Ownership](#viewing-ownership)
- [chown - Change Owner](#chown---change-owner)
- [chgrp - Change Group](#chgrp---change-group)
- [Default Ownership](#default-ownership)

---

## Understanding Ownership

Every file and directory has two owners:

1. **User (owner)**: The user who owns the file
2. **Group**: A group of users who share access

```
┌──────────────────────────────────────────────────────────┐
│                    FILE OWNERSHIP                        │
├──────────────────────────────────────────────────────────┤
│                                                          │
│   File: /home/john/document.txt                          │
│                                                          │
│   ┌──────────────┐    ┌──────────────┐                  │
│   │    Owner     │    │    Group     │                  │
│   │              │    │              │                  │
│   │    john      │    │   staff      │                  │
│   │              │    │              │                  │
│   │  • Full      │    │  • Members   │                  │
│   │    control   │    │    of staff  │                  │
│   │    (usually) │    │    get group │                  │
│   │              │    │    access    │                  │
│   └──────────────┘    └──────────────┘                  │
│                                                          │
│   Others: Everyone not the owner or in the group        │
│                                                          │
└──────────────────────────────────────────────────────────┘
```

### Why This Matters

- **Security**: Control who can read/modify your files
- **Collaboration**: Share files with specific groups
- **System integrity**: Protect system files from regular users

---

## Viewing Ownership

### Using ls -l

```bash
$ ls -l file.txt
-rw-r--r-- 1 john staff 1234 Dec  3 08:00 file.txt
             ^^^^  ^^^^^
             │     └── Group
             └── Owner (user)
```

### Using stat

```bash
$ stat file.txt
  File: file.txt
  Size: 1234        Blocks: 8          IO Block: 4096   regular file
Device: 801h/2049d  Inode: 12345678    Links: 1
Access: (0644/-rw-r--r--)  Uid: ( 1000/    john)   Gid: ( 1000/   staff)
                                ^^^^^^^^^^^^       ^^^^^^^^^^^^
                                User ID & name     Group ID & name
```

### ls -n (Numeric IDs)

```bash
$ ls -ln file.txt
-rw-r--r-- 1 1000 1000 1234 Dec  3 08:00 file.txt
             ^^^^  ^^^^
             UID   GID
```

---

## chown - Change Owner

Change the owner and/or group of files.

### Syntax
```bash
chown [options] owner[:group] file...
chown [options] :group file...
```

### Basic Usage

```bash
# Change owner only
$ sudo chown jane file.txt

# Change owner and group
$ sudo chown jane:developers file.txt

# Change group only (note the colon)
$ sudo chown :developers file.txt

# Verify
$ ls -l file.txt
-rw-r--r-- 1 jane developers 1234 Dec  3 08:00 file.txt
```

### Common Options

| Option | Description |
|--------|-------------|
| `-R` | Recursive (include subdirectories) |
| `-v` | Verbose (show what's being changed) |
| `--reference=file` | Use another file's ownership |
| `--from=owner:group` | Only change if current owner matches |

### Examples

```bash
# Change ownership recursively
$ sudo chown -R john:staff project/

# Verbose output
$ sudo chown -v jane:developers file.txt
changed ownership of 'file.txt' from john:staff to jane:developers

# Copy ownership from another file
$ sudo chown --reference=source.txt target.txt

# Only change if currently owned by john
$ sudo chown --from=john jane file.txt
```

### ⚠️ Important Notes

- **Only root can change ownership** (or the file owner in some systems)
- **Be careful with recursive (-R)** - it affects ALL files and subdirectories
- **Symbolic links**: By default, chown changes the link itself; use `-h` for the link target

---

## chgrp - Change Group

Change only the group ownership.

### Syntax
```bash
chgrp [options] group file...
```

### Examples

```bash
# Change group
$ chgrp developers file.txt

# Recursive
$ chgrp -R staff project/

# Verbose
$ chgrp -v developers file.txt
changed group of 'file.txt' from staff to developers

# Using reference file
$ chgrp --reference=other.txt file.txt
```

### 💡 Tip

Regular users can only change the group to groups they belong to:

```bash
# Check your groups
$ groups
john staff developers

# This works (john is in developers)
$ chgrp developers myfile.txt

# This fails (john is not in admin)
$ chgrp admin myfile.txt
chgrp: changing group of 'myfile.txt': Operation not permitted
```

---

## Default Ownership

### When You Create Files

Files are created with:
- **Owner**: The user who created it
- **Group**: The user's primary group (usually)

```bash
$ id
uid=1000(john) gid=1000(john) groups=1000(john),27(sudo),1001(developers)

$ touch newfile.txt
$ ls -l newfile.txt
-rw-r--r-- 1 john john 0 Dec  3 08:00 newfile.txt
           ^^^^ ^^^^
           │    └── Primary group (john)
           └── Owner (john)
```

### The setgid Bit

Directories with setgid cause new files to inherit the directory's group:

```bash
# Normal directory
$ mkdir normal
$ touch normal/file.txt
$ ls -l normal/
-rw-r--r-- 1 john john 0 Dec  3 08:00 file.txt

# Directory with setgid
$ mkdir shared
$ chgrp developers shared
$ chmod g+s shared
$ ls -ld shared
drwxr-sr-x 2 john developers 4096 Dec  3 08:00 shared
        ^
        setgid bit (s)

$ touch shared/file.txt
$ ls -l shared/
-rw-r--r-- 1 john developers 0 Dec  3 08:00 file.txt
                 ^^^^^^^^^^
                 Inherited from directory
```

---

## Common Ownership Scenarios

### Shared Project Directory

```bash
# Create shared directory
$ sudo mkdir /shared/project
$ sudo chown :developers /shared/project
$ sudo chmod 2775 /shared/project

# Now all developers can read/write, and files inherit the group
```

### Web Server Files

```bash
# Web server typically runs as www-data
$ sudo chown -R www-data:www-data /var/www/html
```

### Home Directory Fix

```bash
# If ownership gets messed up
$ sudo chown -R $USER:$USER ~
```

---

## 🏋️ Practice Exercises

1. Check the ownership of `/etc/passwd`
2. Create a file and view its ownership
3. Create a test directory and change its group
4. View your current user ID and group memberships

### Solutions

```bash
# Exercise 1
ls -l /etc/passwd
# Note: owned by root:root

# Exercise 2
touch myfile.txt
ls -l myfile.txt

# Exercise 3
mkdir testdir
ls -ld testdir
chgrp $(groups | awk '{print $2}') testdir  # Change to second group
ls -ld testdir

# Exercise 4
id
```

---

## 🔗 Next Topic

Continue to [Permissions](permissions.md) →
