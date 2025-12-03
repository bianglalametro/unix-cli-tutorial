# File Operations

Learn to create, copy, move, and delete files.

## 📖 Table of Contents

- [touch - Create Empty Files](#touch---create-empty-files)
- [cp - Copy Files](#cp---copy-files)
- [mv - Move or Rename Files](#mv---move-or-rename-files)
- [rm - Remove Files](#rm---remove-files)
- [file - Determine File Type](#file---determine-file-type)
- [stat - File Statistics](#stat---file-statistics)

---

## touch - Create Empty Files

Creates empty files or updates timestamps of existing files.

### Syntax
```bash
touch [options] file...
```

### Creating Files

```bash
# Create single file
$ touch newfile.txt
$ ls -l newfile.txt
-rw-r--r-- 1 john john 0 Dec  3 08:00 newfile.txt

# Create multiple files
$ touch file1.txt file2.txt file3.txt

# Create with specific name patterns
$ touch report_{jan,feb,mar}.txt
$ ls
report_feb.txt  report_jan.txt  report_mar.txt
```

### Updating Timestamps

```bash
# Update modification time to now
$ touch existing_file.txt

# Set specific time
$ touch -t 202412251200 file.txt    # Dec 25, 2024, 12:00

# Copy timestamp from another file
$ touch -r reference.txt target.txt
```

### Options

| Option | Description |
|--------|-------------|
| `-a` | Change only access time |
| `-m` | Change only modification time |
| `-t` | Use specific timestamp |
| `-r` | Use reference file's timestamp |
| `-c` | Don't create if doesn't exist |

### 💡 Use Cases

- Create empty files for later use
- Update file timestamps
- Create placeholder files
- Reset modification times

---

## cp - Copy Files

Copy files and directories.

### Syntax
```bash
cp [options] source destination
cp [options] source... directory
```

### Basic Copying

```bash
# Copy file
$ cp original.txt copy.txt

# Copy file to directory
$ cp file.txt /tmp/

# Copy multiple files to directory
$ cp file1.txt file2.txt file3.txt /backup/

# Copy using glob patterns
$ cp *.txt /backup/
```

### Common Options

| Option | Description |
|--------|-------------|
| `-i` | Interactive (prompt before overwrite) |
| `-r, -R` | Recursive (for directories) |
| `-v` | Verbose (show what's being done) |
| `-u` | Update (only newer files) |
| `-p` | Preserve permissions and timestamps |
| `-a` | Archive mode (preserve all attributes) |
| `-n` | No overwrite |

### Copying Directories

```bash
# Copy directory recursively
$ cp -r Documents/ Documents_backup/

# Copy preserving all attributes
$ cp -a /source/dir /destination/

# Copy with progress (verbose)
$ cp -rv Documents/ /backup/
'Documents/file1.txt' -> '/backup/Documents/file1.txt'
'Documents/file2.txt' -> '/backup/Documents/file2.txt'
```

### Safe Copying

```bash
# Interactive mode - ask before overwriting
$ cp -i important.txt backup/
cp: overwrite 'backup/important.txt'? y

# Only copy if source is newer
$ cp -u *.txt /backup/

# Never overwrite
$ cp -n source.txt destination.txt
```

### Examples

```bash
# Backup a file
$ cp config.conf config.conf.bak

# Copy with new name
$ cp /etc/hosts ~/hosts_backup

# Copy entire directory structure
$ cp -rp /var/www /backup/www_$(date +%Y%m%d)

# Copy only certain files
$ cp ~/Documents/*.pdf /backup/pdfs/
```

### ⚠️ Warning

`cp` will overwrite existing files without warning (unless using `-i` or `-n`).

---

## mv - Move or Rename Files

Move files/directories or rename them.

### Syntax
```bash
mv [options] source destination
mv [options] source... directory
```

### Renaming Files

```bash
# Rename a file
$ mv oldname.txt newname.txt

# Rename a directory
$ mv old_dir/ new_dir/
```

### Moving Files

```bash
# Move file to directory
$ mv file.txt /tmp/

# Move multiple files
$ mv file1.txt file2.txt file3.txt /backup/

# Move using patterns
$ mv *.log /var/log/archive/

# Move directory
$ mv Documents/ /home/john/Backup/
```

### Common Options

| Option | Description |
|--------|-------------|
| `-i` | Interactive (prompt before overwrite) |
| `-v` | Verbose |
| `-u` | Update (only if source is newer) |
| `-n` | No overwrite |
| `-f` | Force (don't prompt) |

### Examples

```bash
# Rename with timestamp
$ mv report.txt report_$(date +%Y%m%d).txt

# Move and rename
$ mv /tmp/download.zip ~/Downloads/software.zip

# Interactive move
$ mv -i important.txt /backup/
mv: overwrite '/backup/important.txt'? n

# Move all except one file (using extglob)
$ shopt -s extglob
$ mv !(keep.txt) /other/
```

### 💡 Tip: Rename Multiple Files

For bulk renaming, use the `rename` command:

```bash
# Rename all .txt to .md
$ rename 's/.txt$/.md/' *.txt

# Add prefix
$ rename 's/^/backup_/' *.txt

# Change case
$ rename 'y/A-Z/a-z/' *.TXT
```

---

## rm - Remove Files

Delete files and directories. **Be careful - there's no recycle bin!**

### Syntax
```bash
rm [options] file...
```

### Basic Removal

```bash
# Remove single file
$ rm file.txt

# Remove multiple files
$ rm file1.txt file2.txt file3.txt

# Remove with pattern
$ rm *.tmp
```

### Common Options

| Option | Description |
|--------|-------------|
| `-i` | Interactive (prompt for each file) |
| `-r, -R` | Recursive (remove directories) |
| `-f` | Force (no prompts, ignore nonexistent) |
| `-v` | Verbose |
| `-d` | Remove empty directories |

### Removing Directories

```bash
# Remove empty directory (or use rmdir)
$ rm -d empty_dir/

# Remove directory and contents
$ rm -r directory/

# Remove directory with confirmation
$ rm -ri directory/
rm: descend into directory 'directory/'? y
rm: remove regular file 'directory/file.txt'? y
rm: remove directory 'directory/'? y
```

### ⚠️ Dangerous Commands

```bash
# DANGEROUS: Remove without confirmation
$ rm -rf directory/

# EXTREMELY DANGEROUS: Never do this!
$ rm -rf /                    # Deletes entire system
$ rm -rf /*                   # Same effect
$ rm -rf ~                    # Deletes home directory

# Be VERY careful with variables
$ rm -rf $UNDEFINED_VAR/*     # If empty, could be dangerous!
```

### Safe Removal Practices

```bash
# Always use -i for important operations
$ rm -ri important_directory/

# Preview what will be deleted
$ ls *.tmp                     # See files first
$ rm *.tmp                     # Then delete

# Use verbose mode
$ rm -rv old_data/

# Move to trash instead (if available)
$ gio trash file.txt          # GNOME
$ trash-put file.txt          # trash-cli package
```

### 💡 Tip: Safer rm Alias

Add to `~/.bashrc`:
```bash
# Prompt before removing more than 3 files
alias rm='rm -I'

# Or always interactive
alias rm='rm -i'
```

### Remove Files with Special Names

```bash
# File starting with -
$ rm -- -filename
$ rm ./-filename

# File with spaces
$ rm "file with spaces.txt"
$ rm file\ with\ spaces.txt

# File with special characters
$ rm 'file$with#special!chars.txt'
```

---

## file - Determine File Type

Identify what type a file is.

### Syntax
```bash
file [options] file...
```

### Examples

```bash
$ file document.txt
document.txt: ASCII text

$ file image.jpg
image.jpg: JPEG image data, JFIF standard 1.01

$ file script.sh
script.sh: Bourne-Again shell script, ASCII text executable

$ file /bin/ls
/bin/ls: ELF 64-bit LSB shared object, x86-64

$ file archive.tar.gz
archive.tar.gz: gzip compressed data

$ file symlink
symlink: symbolic link to /etc/hosts
```

### 💡 Use Case

Useful when file extension is missing or wrong:
```bash
$ file unknown_file
unknown_file: PNG image data, 800 x 600
```

---

## stat - File Statistics

Display detailed file information.

### Syntax
```bash
stat [options] file...
```

### Example

```bash
$ stat document.txt
  File: document.txt
  Size: 1234        Blocks: 8          IO Block: 4096   regular file
Device: 801h/2049d  Inode: 12345678    Links: 1
Access: (0644/-rw-r--r--)  Uid: ( 1000/   john)   Gid: ( 1000/   john)
Access: 2024-12-03 08:00:00.000000000 +0000
Modify: 2024-12-03 07:30:00.000000000 +0000
Change: 2024-12-03 07:30:00.000000000 +0000
 Birth: 2024-12-01 10:00:00.000000000 +0000
```

### Custom Format

```bash
# Show only size
$ stat -c %s file.txt
1234

# Show modification time
$ stat -c %y file.txt
2024-12-03 07:30:00.000000000 +0000

# Show permissions in octal
$ stat -c %a file.txt
644
```

### Format Options

| Format | Description |
|--------|-------------|
| `%n` | File name |
| `%s` | Size in bytes |
| `%a` | Permission (octal) |
| `%A` | Permission (readable) |
| `%U` | Owner name |
| `%G` | Group name |
| `%y` | Modification time |

---

## 🏋️ Practice Exercises

1. Create three empty files: `test1.txt`, `test2.txt`, `test3.txt`
2. Copy `test1.txt` to `test1_backup.txt`
3. Rename `test2.txt` to `renamed.txt`
4. Create a directory `practice/` and move all `.txt` files into it
5. Remove the `practice/` directory and all its contents
6. Determine the file type of `/bin/ls`

### Solutions

```bash
# Exercise 1
touch test1.txt test2.txt test3.txt

# Exercise 2
cp test1.txt test1_backup.txt

# Exercise 3
mv test2.txt renamed.txt

# Exercise 4
mkdir practice
mv *.txt practice/

# Exercise 5
rm -r practice/

# Exercise 6
file /bin/ls
```

---

## 🔗 Next Topic

Continue to [Directory Operations](directory-operations.md) →
