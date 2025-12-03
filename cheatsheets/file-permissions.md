# 🔐 File Permissions Cheatsheet

> Complete reference for UNIX/Linux file permissions

---

## 📖 Understanding Permission Strings

```
-rwxrw-r--  1 user group  4096 Dec  1 10:30 filename
│└┬┘└┬┘└┬┘
│ │  │  └── Others permissions (world)
│ │  └───── Group permissions
│ └──────── Owner permissions (user)
└────────── File type (- = file, d = directory, l = link)
```

---

## 🎯 Permission Types

| Symbol | Permission | For Files | For Directories |
|--------|------------|-----------|-----------------|
| `r` | Read | View contents | List contents |
| `w` | Write | Modify contents | Add/delete files |
| `x` | Execute | Run as program | Enter directory |
| `-` | None | No permission | No permission |

---

## 🔢 Numeric (Octal) Mode

### Individual Values

| Number | Binary | Permission |
|--------|--------|------------|
| 0 | 000 | `---` (none) |
| 1 | 001 | `--x` (execute) |
| 2 | 010 | `-w-` (write) |
| 3 | 011 | `-wx` (write + execute) |
| 4 | 100 | `r--` (read) |
| 5 | 101 | `r-x` (read + execute) |
| 6 | 110 | `rw-` (read + write) |
| 7 | 111 | `rwx` (all) |

### Common Combinations

| Octal | Symbolic | Description | Use Case |
|-------|----------|-------------|----------|
| `777` | `rwxrwxrwx` | Full access for all | ⚠️ Avoid! Security risk |
| `755` | `rwxr-xr-x` | Owner full, others read/execute | Executables, scripts |
| `750` | `rwxr-x---` | Owner full, group read/execute | Group-shared programs |
| `700` | `rwx------` | Owner only | Private executables |
| `666` | `rw-rw-rw-` | Read/write for all | ⚠️ Avoid! Security risk |
| `644` | `rw-r--r--` | Owner read/write, others read | Regular files |
| `640` | `rw-r-----` | Owner read/write, group read | Config files |
| `600` | `rw-------` | Owner only read/write | Private files, keys |
| `400` | `r--------` | Owner read only | Read-only files |

---

## ⚙️ chmod Command

### Symbolic Mode

```bash
chmod [who][operator][permission] filename
```

#### Who

| Symbol | Meaning |
|--------|---------|
| `u` | User (owner) |
| `g` | Group |
| `o` | Others |
| `a` | All (user, group, others) |

#### Operators

| Symbol | Meaning |
|--------|---------|
| `+` | Add permission |
| `-` | Remove permission |
| `=` | Set exact permission |

#### Examples

```bash
# Add execute for owner
chmod u+x script.sh

# Remove write for others
chmod o-w file.txt

# Set read-only for all
chmod a=r file.txt

# Add read/write for user and group
chmod ug+rw file.txt

# Remove all permissions for others
chmod o= file.txt

# Make executable for all
chmod +x script.sh

# Set multiple permissions
chmod u=rwx,g=rx,o=r file.txt
```

### Numeric Mode

```bash
chmod [mode] filename
```

#### Examples

```bash
# Full permissions for all (risky!)
chmod 777 file.txt

# Standard file permissions
chmod 644 file.txt

# Executable script
chmod 755 script.sh

# Private file
chmod 600 secrets.txt

# Recursive change
chmod -R 755 directory/
```

---

## 👤 chown Command

Change file owner and group.

```bash
chown [owner][:group] filename
```

### Examples

```bash
# Change owner
chown john file.txt

# Change owner and group
chown john:developers file.txt

# Change group only
chown :developers file.txt

# Recursive change
chown -R john:developers project/
```

---

## 👥 chgrp Command

Change group ownership only.

```bash
chgrp [group] filename
```

### Examples

```bash
# Change group
chgrp developers file.txt

# Recursive change
chgrp -R developers project/
```

---

## 🔒 Special Permissions

### Setuid (Set User ID)

When set on executable, runs with owner's permissions.

```bash
# View (shows 's' in user execute position)
-rwsr-xr-x

# Set
chmod u+s executable
chmod 4755 executable
```

### Setgid (Set Group ID)

- On executable: Runs with group's permissions
- On directory: New files inherit directory's group

```bash
# View (shows 's' in group execute position)
-rwxr-sr-x

# Set
chmod g+s executable
chmod 2755 directory/
```

### Sticky Bit

On directory: Only owner can delete their files.

```bash
# View (shows 't' in others execute position)
drwxrwxrwt

# Set
chmod +t directory/
chmod 1777 directory/
```

### Special Permission Numbers

| Number | Permission |
|--------|------------|
| 4000 | Setuid |
| 2000 | Setgid |
| 1000 | Sticky bit |

```bash
# Setuid + 755
chmod 4755 executable

# Setgid + 755
chmod 2755 directory/

# Sticky + 777
chmod 1777 /tmp
```

---

## 📁 Default Permissions (umask)

The `umask` value subtracts from default permissions.

### Default Creation Permissions

| Type | Without umask |
|------|---------------|
| Files | 666 (rw-rw-rw-) |
| Directories | 777 (rwxrwxrwx) |

### Common umask Values

| umask | Files | Directories |
|-------|-------|-------------|
| 022 | 644 (rw-r--r--) | 755 (rwxr-xr-x) |
| 027 | 640 (rw-r-----) | 750 (rwxr-x---) |
| 077 | 600 (rw-------) | 700 (rwx------) |

### Examples

```bash
# View current umask
umask

# Set umask (session only)
umask 022

# Set umask in profile
echo "umask 022" >> ~/.bashrc
```

---

## 🔍 Viewing Permissions

### ls -l Output

```bash
$ ls -l
-rw-r--r--  1 john staff   1024 Dec  1 10:30 document.txt
drwxr-xr-x  2 john staff   4096 Dec  1 10:30 project/
lrwxrwxrwx  1 john staff     11 Dec  1 10:30 link -> target.txt
```

### stat Command

```bash
$ stat file.txt
  File: file.txt
  Size: 1024            Blocks: 8          IO Block: 4096   regular file
Device: 801h/2049d      Inode: 1234567     Links: 1
Access: (0644/-rw-r--r--)  Uid: ( 1000/   john)   Gid: (   50/  staff)
Access: 2023-12-01 10:30:00.000000000 +0000
Modify: 2023-12-01 10:30:00.000000000 +0000
Change: 2023-12-01 10:30:00.000000000 +0000
```

### getfacl (ACL)

```bash
$ getfacl file.txt
# file: file.txt
# owner: john
# group: staff
user::rw-
group::r--
other::r--
```

---

## 📝 Quick Reference Table

| Task | Command |
|------|---------|
| Make file executable | `chmod +x file.sh` |
| Remove all permissions for others | `chmod o= file.txt` |
| Set standard file permissions | `chmod 644 file.txt` |
| Set standard directory permissions | `chmod 755 dir/` |
| Make file private | `chmod 600 file.txt` |
| Change owner | `chown user file.txt` |
| Change owner and group | `chown user:group file.txt` |
| Change group only | `chgrp group file.txt` |
| View permissions | `ls -l file.txt` |
| View detailed permissions | `stat file.txt` |

---

## ⚠️ Security Best Practices

1. **Never use 777** - Full permissions for all is a security risk
2. **Use 600 for sensitive files** - SSH keys, passwords, configs
3. **Use 755 for executables** - Owner has full control
4. **Use 644 for regular files** - Standard readable files
5. **Be careful with setuid/setgid** - Can be exploited
6. **Regularly audit permissions** - `find . -perm 777`
7. **Use groups for collaboration** - Better than world-writable

---

## 💡 Common Scenarios

### Web Server Files

```bash
# HTML/CSS/JS files (readable)
chmod 644 index.html

# Upload directory
chmod 755 uploads/
chown www-data:www-data uploads/

# PHP files
chmod 644 script.php
```

### SSH Keys

```bash
# Private key (must be restrictive)
chmod 600 ~/.ssh/id_rsa

# Public key
chmod 644 ~/.ssh/id_rsa.pub

# SSH directory
chmod 700 ~/.ssh
```

### Shell Scripts

```bash
# Make script executable
chmod 755 script.sh

# Run script
./script.sh
```

### Shared Directory

```bash
# Create shared directory with setgid
mkdir /shared
chmod 2775 /shared
chown :developers /shared
```

---

**📖 Related Resources:**
- [Essential Commands Cheatsheet](essential-commands.md)
- [Permissions Module](../03-permissions-and-links/permissions.md)
