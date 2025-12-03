# Hard Links and Symbolic Links

Create multiple references to files.

## 📖 Table of Contents

- [Understanding Links](#understanding-links)
- [Hard Links](#hard-links)
- [Symbolic Links](#symbolic-links)
- [Comparison](#comparison)
- [Practical Applications](#practical-applications)

---

## Understanding Links

Links allow one file to be accessed by multiple names or paths.

### File System Basics

```
┌─────────────────────────────────────────────────────────────┐
│                    FILE SYSTEM STRUCTURE                    │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  Filename ────> Inode ────> Data Blocks                     │
│                                                             │
│  • Filename: Human-readable name (file.txt)                 │
│  • Inode: Metadata container (permissions, size, location)  │
│  • Data Blocks: Actual file contents on disk               │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### Two Types of Links

| Type | Points To | Crosses Filesystems | Survives Rename |
|------|-----------|---------------------|-----------------|
| Hard Link | Inode | No | Yes |
| Symbolic Link | Filename | Yes | No |

---

## Hard Links

A hard link is an additional name pointing to the same inode.

### Creating Hard Links

```bash
# Syntax
ln source_file link_name

# Example
$ echo "Hello, World!" > original.txt
$ ln original.txt hardlink.txt

$ ls -li
12345 -rw-r--r-- 2 john john 14 Dec  3 08:00 hardlink.txt
12345 -rw-r--r-- 2 john john 14 Dec  3 08:00 original.txt
      │         │
      │         └── Link count: 2 (two names for same inode)
      └── Same inode number
```

### How Hard Links Work

```
┌────────────────────────────────────────────────────────────┐
│                      HARD LINK                             │
├────────────────────────────────────────────────────────────┤
│                                                            │
│   Directory:                                               │
│   ┌─────────────────────────────────────────────────────┐ │
│   │  original.txt  ──────────────┐                      │ │
│   │                              │                      │ │
│   │  hardlink.txt  ──────────────┼───> Inode 12345     │ │
│   │                              │     ┌─────────────┐ │ │
│   │                              └────>│ Permissions │ │ │
│   │                                    │ Owner       │ │ │
│   │                                    │ Size        │ │ │
│   │                                    │ Data blocks │───>│DATA│
│   │                                    │ Link count  │ │ │
│   │                                    └─────────────┘ │ │
│   └─────────────────────────────────────────────────────┘ │
│                                                            │
│   Both names are EQUAL - neither is the "real" file       │
│   Data exists until link count reaches 0                  │
│                                                            │
└────────────────────────────────────────────────────────────┘
```

### Properties of Hard Links

- **Same inode**: Both names share the same inode
- **Same data**: Changes to one affect the other
- **Equal status**: No "original" - both names are equally valid
- **Persistent**: Deleting one doesn't affect the other
- **Link count**: Increases when hard links are created

### Limitations

```bash
# Cannot hard link to directories (usually)
$ ln directory/ link_to_dir
ln: directory/: hard link not allowed for directory

# Cannot cross filesystems
$ ln /home/john/file.txt /mnt/usb/link.txt
ln: failed to create hard link '/mnt/usb/link.txt': Invalid cross-device link
```

### Example: Data Preservation

```bash
$ echo "Important data" > original.txt
$ ln original.txt backup.txt

# Delete the "original"
$ rm original.txt

# Data still accessible through hard link
$ cat backup.txt
Important data

# Check link count dropped to 1
$ ls -l backup.txt
-rw-r--r-- 1 john john 15 Dec  3 08:00 backup.txt
```

---

## Symbolic Links

A symbolic link (symlink) points to a filename, not an inode.

### Creating Symbolic Links

```bash
# Syntax
ln -s target link_name

# Example
$ echo "Hello, World!" > original.txt
$ ln -s original.txt symlink.txt

$ ls -l
-rw-r--r-- 1 john john 14 Dec  3 08:00 original.txt
lrwxrwxrwx 1 john john 12 Dec  3 08:00 symlink.txt -> original.txt
^                                       ^^^^^^^^^^^^^^^^^^^^^^^^
└── 'l' for link                        Shows target
```

### How Symbolic Links Work

```
┌────────────────────────────────────────────────────────────┐
│                    SYMBOLIC LINK                           │
├────────────────────────────────────────────────────────────┤
│                                                            │
│   symlink.txt                                              │
│   ┌─────────────────┐                                     │
│   │ "original.txt"  │───> original.txt ───> Inode ───>│DATA│
│   │ (stored path)   │     │                              │
│   └─────────────────┘     │                              │
│         │                 └── If deleted, link breaks    │
│         │                                                │
│   Symlink stores the PATH, not the inode                 │
│                                                            │
└────────────────────────────────────────────────────────────┘
```

### Properties of Symbolic Links

- **Separate inode**: The symlink itself is a file
- **Stores path**: Contains the path to target
- **Can break**: If target is deleted, link is broken
- **Cross filesystem**: Can link across different filesystems
- **Can link directories**: Can create symlinks to directories

### Absolute vs Relative Symlinks

```bash
# Absolute symlink (full path)
$ ln -s /home/john/original.txt /tmp/absolute_link.txt

# Relative symlink (relative to link location)
$ ln -s original.txt symlink.txt
$ ln -s ../parent_dir/file.txt link_in_subdir.txt
```

### Broken Symlinks

```bash
$ ln -s nonexistent.txt broken_link.txt
$ ls -l broken_link.txt
lrwxrwxrwx 1 john john 15 Dec  3 08:00 broken_link.txt -> nonexistent.txt

# Trying to access it
$ cat broken_link.txt
cat: broken_link.txt: No such file or directory

# Find broken symlinks
$ find . -xtype l
./broken_link.txt
```

### Common Uses

```bash
# Point to current version
$ ln -s app-v2.1 current
$ ls -l current
lrwxrwxrwx 1 john john 8 Dec  3 08:00 current -> app-v2.1

# Create shortcut
$ ln -s /very/long/path/to/directory ~/shortcut

# Switch between versions
$ rm current && ln -s app-v2.2 current
```

---

## Comparison

### Side-by-Side

| Feature | Hard Link | Symbolic Link |
|---------|-----------|---------------|
| Points to | Inode | Filename |
| Own inode | No (shares) | Yes |
| Cross filesystem | No | Yes |
| Link to directory | No | Yes |
| Breaks if target deleted | No | Yes |
| Size | Same as original | Size of path string |
| Permissions | Same as original | Always lrwxrwxrwx |
| readlink command | N/A | Shows target |

### Visual Comparison

```
HARD LINK                           SYMBOLIC LINK
─────────                           ─────────────
file.txt  ─────┐                    file.txt ─────> Inode ───> DATA
               ├─> Inode ───> DATA
hardlink  ─────┘                    symlink  ─────> "file.txt"
                                              (stores path, not inode)

Delete file.txt:                    Delete file.txt:
• hardlink still works              • symlink is BROKEN
• data still exists
```

---

## Practical Applications

### Version Management

```bash
# Application directory structure
apps/
├── myapp-1.0/
├── myapp-2.0/
├── myapp-2.1/
└── current -> myapp-2.1

# Upgrade: just change the symlink
$ ln -sfn myapp-2.1 current

# Rollback: point back to old version
$ ln -sfn myapp-2.0 current
```

### Configuration Management

```bash
# Shared configuration
$ ln -s /shared/config/database.yml /app/config/database.yml

# Development/production configs
$ ln -s config/production.yml config/active.yml
```

### Save Disk Space (Hard Links)

```bash
# Backup with hard links (rsync style)
# Files that haven't changed share the same data blocks
$ cp -al backup-yesterday/ backup-today/
```

### Alternative Names

```bash
# Multiple names for same command
$ ls -l /usr/bin/vi /usr/bin/vim
lrwxrwxrwx 1 root root 20 Dec  3 08:00 /usr/bin/vi -> /etc/alternatives/vi
lrwxrwxrwx 1 root root 21 Dec  3 08:00 /usr/bin/vim -> /etc/alternatives/vim
```

---

## Useful Commands

### readlink - Read Symbolic Link Target

```bash
$ readlink symlink.txt
original.txt

# Full (absolute) path
$ readlink -f symlink.txt
/home/john/original.txt
```

### Find Links

```bash
# Find symbolic links
$ find . -type l

# Find hard links to a file
$ find . -samefile original.txt

# Find broken symlinks
$ find . -xtype l
```

### Update Symlink

```bash
# Force overwrite existing symlink
$ ln -sf new_target existing_symlink

# Force and no-dereference (for directories)
$ ln -sfn new_directory directory_link
```

---

## 🏋️ Practice Exercises

1. Create a file and make a hard link to it. Verify they share the same inode.
2. Create a symbolic link to a file. Delete the original and observe what happens.
3. Create a symbolic link to a directory and navigate through it.
4. Create a relative symlink and verify it works when moved together with its target.

### Solutions

```bash
# Exercise 1
echo "test" > original.txt
ln original.txt hardlink.txt
ls -li original.txt hardlink.txt
# Same inode number, link count is 2

# Exercise 2
echo "test" > original.txt
ln -s original.txt symlink.txt
cat symlink.txt  # Works
rm original.txt
cat symlink.txt  # Error: No such file

# Exercise 3
mkdir mydir
touch mydir/file.txt
ln -s mydir dirlink
ls dirlink/       # Shows file.txt
cd dirlink && pwd # Inside the linked directory

# Exercise 4
mkdir project
echo "content" > project/file.txt
cd project
ln -s file.txt link.txt
cat link.txt  # Works
cd ..
mv project newproject
cat newproject/link.txt  # Still works (relative link)
```

---

## 🔗 Next Topic

Continue to [Streams and Redirection](streams-and-redirection.md) →
