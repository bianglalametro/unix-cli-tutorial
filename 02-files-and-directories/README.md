# Module 02: Files and Directories

Learn to navigate the file system and manage files and directories effectively.

## 🎯 Learning Objectives

By the end of this module, you will be able to:
- Navigate the file system using `pwd`, `cd`, and `ls`
- Create, copy, move, and delete files
- Create and remove directories
- Understand absolute and relative paths
- Use special path symbols like `~`, `.`, and `..`

## 📖 Topics Covered

| File | Description | Time |
|------|-------------|------|
| [navigation.md](navigation.md) | Navigate the file system | 20 min |
| [file-operations.md](file-operations.md) | Create, copy, move, delete files | 25 min |
| [directory-operations.md](directory-operations.md) | Work with directories | 15 min |
| [paths-and-symbols.md](paths-and-symbols.md) | Paths and special symbols | 15 min |
| [exercises.md](exercises.md) | Practice exercises | 30 min |

## 🌳 The Linux File System

Linux uses a hierarchical file system with `/` (root) at the top.

```
/                       # Root directory
├── bin/                # Essential binaries (ls, cp, mv)
├── boot/               # Boot loader files
├── dev/                # Device files
├── etc/                # Configuration files
├── home/               # User home directories
│   ├── john/           # John's home (~)
│   └── jane/           # Jane's home
├── lib/                # Shared libraries
├── media/              # Removable media mount points
├── mnt/                # Temporary mount points
├── opt/                # Optional software
├── proc/               # Process information (virtual)
├── root/               # Root user's home
├── sbin/               # System binaries
├── srv/                # Service data
├── sys/                # System information (virtual)
├── tmp/                # Temporary files
├── usr/                # User programs
│   ├── bin/            # User binaries
│   ├── lib/            # Libraries
│   ├── local/          # Locally installed software
│   └── share/          # Shared data
└── var/                # Variable data
    ├── log/            # Log files
    ├── mail/           # Mail storage
    └── www/            # Web server files
```

## 🔑 Key Concepts

### Everything is a File

In UNIX/Linux, everything is represented as a file:
- Regular files (documents, images, executables)
- Directories (special files containing other files)
- Device files (`/dev/sda`, `/dev/null`)
- Process information (`/proc/`)
- Sockets and pipes

### File Types

| Symbol | Type | Example |
|--------|------|---------|
| `-` | Regular file | `document.txt` |
| `d` | Directory | `Documents/` |
| `l` | Symbolic link | `link -> target` |
| `c` | Character device | `/dev/tty` |
| `b` | Block device | `/dev/sda` |
| `s` | Socket | `/var/run/docker.sock` |
| `p` | Pipe (FIFO) | Named pipes |

### Hidden Files

Files starting with `.` are hidden:
```bash
.bashrc        # Bash configuration
.profile       # Profile script
.ssh/          # SSH configuration directory
.gitignore     # Git ignore file
```

## 💡 Tips for File Management

1. **Use Tab completion** - Press Tab to autocomplete file/directory names
2. **Be careful with rm** - There's no "recycle bin"
3. **Use meaningful names** - Avoid spaces; use underscores or hyphens
4. **Keep backups** - Important files should be backed up

## ⚠️ Common Mistakes

- **Deleting without confirmation**: `rm -rf` is dangerous
- **Overwriting files**: `cp` and `mv` can overwrite without warning
- **Case sensitivity**: `File.txt` ≠ `file.txt`
- **Spaces in names**: Use quotes or escape spaces

## 🔗 Next Steps

Start with:
1. [Navigation](navigation.md) - Learn to move around
2. [File Operations](file-operations.md) - Work with files
3. [Directory Operations](directory-operations.md) - Work with directories

After completing this module, continue to:
- [Module 03: Permissions and Links](../03-permissions-and-links/)

## 📚 Additional Resources

- [GNU Coreutils Manual](https://www.gnu.org/software/coreutils/manual/)
- [Linux Filesystem Hierarchy Standard](https://refspecs.linuxfoundation.org/FHS_3.0/fhs/index.html)
