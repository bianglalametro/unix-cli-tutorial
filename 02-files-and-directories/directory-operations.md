# Directory Operations

Learn to create and manage directories.

## 📖 Table of Contents

- [mkdir - Create Directories](#mkdir---create-directories)
- [rmdir - Remove Empty Directories](#rmdir---remove-empty-directories)
- [tree - Display Directory Tree](#tree---display-directory-tree)

---

## mkdir - Create Directories

Create new directories.

### Syntax
```bash
mkdir [options] directory...
```

### Basic Usage

```bash
# Create single directory
$ mkdir new_directory

# Create multiple directories
$ mkdir dir1 dir2 dir3

# Create nested directories
$ mkdir -p parent/child/grandchild
```

### Common Options

| Option | Description |
|--------|-------------|
| `-p` | Create parent directories as needed |
| `-v` | Verbose (print each created directory) |
| `-m` | Set permissions (mode) |

### Creating Nested Directories

Without `-p`:
```bash
$ mkdir parent/child
mkdir: cannot create directory 'parent/child': No such file or directory
```

With `-p`:
```bash
$ mkdir -p parent/child/grandchild
$ tree parent
parent
└── child
    └── grandchild
```

### Creating with Specific Permissions

```bash
# Create directory with mode 755
$ mkdir -m 755 public_dir

# Create directory with restricted access
$ mkdir -m 700 private_dir

$ ls -ld public_dir private_dir
drwxr-xr-x 2 john john 4096 Dec  3 08:00 public_dir
drwx------ 2 john john 4096 Dec  3 08:00 private_dir
```

### Creating Project Structures

```bash
# Create a typical project structure
$ mkdir -p project/{src,bin,doc,test,lib}
$ tree project
project
├── bin
├── doc
├── lib
├── src
└── test

# Create with subdirectories
$ mkdir -p webapp/{public/{css,js,images},src/{controllers,models,views},config}
```

### Verbose Mode

```bash
$ mkdir -pv a/b/c
mkdir: created directory 'a'
mkdir: created directory 'a/b'
mkdir: created directory 'a/b/c'
```

### 💡 Tips

1. Use brace expansion for multiple similar directories
2. Use `-p` to avoid "directory exists" errors
3. Combine with `&&` for conditional directory creation

---

## rmdir - Remove Empty Directories

Remove empty directories (safer than `rm -r`).

### Syntax
```bash
rmdir [options] directory...
```

### Basic Usage

```bash
# Remove empty directory
$ rmdir empty_directory

# Remove multiple empty directories
$ rmdir dir1 dir2 dir3
```

### Common Options

| Option | Description |
|--------|-------------|
| `-p` | Remove parents if they become empty |
| `-v` | Verbose |

### Examples

```bash
# Remove empty directory
$ mkdir test
$ rmdir test

# Fails if directory not empty
$ mkdir test
$ touch test/file.txt
$ rmdir test
rmdir: failed to remove 'test': Directory not empty

# Remove nested empty directories
$ mkdir -p a/b/c
$ rmdir -p a/b/c
$ ls a
ls: cannot access 'a': No such file or directory
```

### rmdir vs rm -r

| Command | Behavior |
|---------|----------|
| `rmdir dir` | Only removes if empty |
| `rm -r dir` | Removes directory and ALL contents |

### 💡 When to Use rmdir

- When you expect the directory to be empty
- As a safety check (won't accidentally delete files)
- When cleaning up empty directory structures

---

## tree - Display Directory Tree

Display directory structure as a tree.

### Syntax
```bash
tree [options] [directory...]
```

### Installation

```bash
# Debian/Ubuntu
$ sudo apt install tree

# RHEL/Fedora
$ sudo dnf install tree

# macOS
$ brew install tree
```

### Basic Usage

```bash
$ tree
.
├── Documents
│   ├── report.txt
│   └── notes.md
├── Downloads
│   └── archive.zip
└── Pictures
    ├── photo1.jpg
    └── photo2.jpg

3 directories, 5 files
```

### Common Options

| Option | Description |
|--------|-------------|
| `-L n` | Limit depth to n levels |
| `-d` | Directories only |
| `-a` | Show hidden files |
| `-f` | Print full path |
| `-h` | Human-readable sizes |
| `-p` | Print permissions |
| `--charset ascii` | ASCII characters only |
| `-I pattern` | Exclude pattern |

### Examples

```bash
# Limit depth to 2 levels
$ tree -L 2
.
├── Documents
│   └── work
├── Downloads
│   └── software
└── Pictures
    └── vacation

# Directories only
$ tree -d
.
├── Documents
│   └── work
├── Downloads
│   └── software
└── Pictures
    └── vacation

# Show hidden files
$ tree -a
.
├── .bashrc
├── .profile
├── Documents
└── ...

# With file sizes
$ tree -h
.
├── [4.0K]  Documents
│   └── [1.2K]  report.txt
└── [128K]  large_file.bin

# With permissions
$ tree -p
.
├── [drwxr-xr-x]  Documents
│   └── [-rw-r--r--]  report.txt
└── [-rwx------]  script.sh

# Exclude directories
$ tree -I 'node_modules|__pycache__'

# ASCII output (for compatibility)
$ tree --charset ascii
.
|-- Documents
|   `-- report.txt
`-- Downloads
    `-- file.zip
```

### Alternatives to tree

If `tree` is not installed:

```bash
# Using find
$ find . -print | sed -e 's;[^/]*/;|-- ;g'

# Using ls recursively
$ ls -R

# Simple Python solution
$ python3 -c "import os; [print('  '*r.count(os.sep) + os.path.basename(r)) for r,d,f in os.walk('.') for name in d+f]"
```

---

## 🏋️ Practice Exercises

1. Create a directory structure: `project/src/main`
2. Create multiple directories at once: `backup`, `temp`, `archive`
3. Use brace expansion to create `test/{input,output,logs}`
4. Try to remove a non-empty directory with `rmdir` (observe the error)
5. Use `tree` to display your home directory (limit to 2 levels)

### Solutions

```bash
# Exercise 1
mkdir -p project/src/main

# Exercise 2
mkdir backup temp archive

# Exercise 3
mkdir -p test/{input,output,logs}

# Exercise 4
mkdir nonempty
touch nonempty/file.txt
rmdir nonempty
# rmdir: failed to remove 'nonempty': Directory not empty

# To actually remove it:
rm nonempty/file.txt
rmdir nonempty

# Exercise 5
tree -L 2 ~
```

---

## 🔗 Next Topic

Continue to [Paths and Symbols](paths-and-symbols.md) →
