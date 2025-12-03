# Compression and Archives

Learn to compress and archive files.

## 📖 Table of Contents

- [tar - Tape Archive](#tar---tape-archive)
- [gzip / gunzip](#gzip--gunzip)
- [bzip2 / bunzip2](#bzip2--bunzip2)
- [xz](#xz)
- [zip / unzip](#zip--unzip)
- [Comparison](#comparison)

---

## tar - Tape Archive

The standard archiving tool for Unix/Linux.

### Basic Syntax

```bash
tar [options] archive-name files...
```

### Key Options

| Option | Description |
|--------|-------------|
| `-c` | Create archive |
| `-x` | Extract archive |
| `-v` | Verbose (show files) |
| `-f` | Specify filename |
| `-z` | Use gzip compression |
| `-j` | Use bzip2 compression |
| `-J` | Use xz compression |
| `-t` | List contents |
| `-r` | Append to archive |
| `-u` | Update files in archive |

### Creating Archives

```bash
# Create tar archive
$ tar -cvf archive.tar directory/
$ tar -cvf archive.tar file1.txt file2.txt

# Create compressed archive (gzip)
$ tar -czvf archive.tar.gz directory/

# Create compressed archive (bzip2)
$ tar -cjvf archive.tar.bz2 directory/

# Create compressed archive (xz)
$ tar -cJvf archive.tar.xz directory/
```

### Extracting Archives

```bash
# Extract tar archive
$ tar -xvf archive.tar

# Extract to specific directory
$ tar -xvf archive.tar -C /destination/

# Extract compressed archive
$ tar -xzvf archive.tar.gz
$ tar -xjvf archive.tar.bz2
$ tar -xJvf archive.tar.xz
```

### Listing Contents

```bash
# List without extracting
$ tar -tvf archive.tar
$ tar -tzvf archive.tar.gz
```

### Advanced Operations

```bash
# Extract specific files
$ tar -xvf archive.tar file1.txt path/to/file2.txt

# Exclude patterns
$ tar -czvf archive.tar.gz --exclude='*.log' --exclude='node_modules' directory/

# Preserve permissions
$ tar -cpzvf archive.tar.gz directory/

# Append files to archive
$ tar -rvf archive.tar newfile.txt

# Differential backup (files newer than)
$ tar -czvf backup.tar.gz --newer-mtime="2024-01-01" directory/
```

### Common Extensions

| Extension | Compression | Command |
|-----------|-------------|---------|
| `.tar` | None | `tar -cvf` |
| `.tar.gz`, `.tgz` | gzip | `tar -czvf` |
| `.tar.bz2`, `.tbz` | bzip2 | `tar -cjvf` |
| `.tar.xz`, `.txz` | xz | `tar -cJvf` |

---

## gzip / gunzip

Compress individual files.

### Basic Usage

```bash
# Compress file (replaces original)
$ gzip file.txt
# Creates: file.txt.gz

# Decompress
$ gunzip file.txt.gz
# or
$ gzip -d file.txt.gz

# Keep original file
$ gzip -k file.txt
# Creates both: file.txt and file.txt.gz
```

### Options

| Option | Description |
|--------|-------------|
| `-d` | Decompress |
| `-k` | Keep original file |
| `-l` | List compression info |
| `-r` | Recursive |
| `-1` to `-9` | Compression level |
| `-c` | Write to stdout |

### Examples

```bash
# Maximum compression
$ gzip -9 largefile.txt

# Fastest compression
$ gzip -1 file.txt

# View compressed file without extracting
$ zcat file.txt.gz
$ zless file.txt.gz
$ zgrep "pattern" file.txt.gz

# Compress to stdout (useful for pipes)
$ gzip -c file.txt > file.txt.gz

# Show compression ratio
$ gzip -l file.txt.gz
```

---

## bzip2 / bunzip2

Better compression than gzip, but slower.

### Basic Usage

```bash
# Compress
$ bzip2 file.txt
# Creates: file.txt.bz2

# Decompress
$ bunzip2 file.txt.bz2
# or
$ bzip2 -d file.txt.bz2

# Keep original
$ bzip2 -k file.txt
```

### Examples

```bash
# View without extracting
$ bzcat file.txt.bz2
$ bzless file.txt.bz2
$ bzgrep "pattern" file.txt.bz2

# Compress with best ratio
$ bzip2 -9 file.txt
```

---

## xz

Best compression ratio, but slowest.

### Basic Usage

```bash
# Compress
$ xz file.txt
# Creates: file.txt.xz

# Decompress
$ unxz file.txt.xz
# or
$ xz -d file.txt.xz

# Keep original
$ xz -k file.txt
```

### Examples

```bash
# Extreme compression
$ xz -9e file.txt

# Use multiple threads
$ xz -T 4 file.txt

# View without extracting
$ xzcat file.txt.xz
$ xzless file.txt.xz
```

---

## zip / unzip

Cross-platform archive format.

### Creating Archives

```bash
# Basic zip
$ zip archive.zip file1.txt file2.txt

# Recursive (include directories)
$ zip -r archive.zip directory/

# With password
$ zip -e secure.zip file.txt

# Exclude patterns
$ zip -r archive.zip directory/ -x "*.log" -x "*.tmp"

# Compression levels (0-9)
$ zip -9 archive.zip files/    # Best compression
$ zip -0 archive.zip files/    # Store only (no compression)
```

### Extracting Archives

```bash
# Extract all
$ unzip archive.zip

# Extract to directory
$ unzip archive.zip -d /destination/

# Extract specific files
$ unzip archive.zip file1.txt

# List contents
$ unzip -l archive.zip

# Test integrity
$ unzip -t archive.zip

# Extract with overwrite confirmation
$ unzip -o archive.zip    # Overwrite
$ unzip -n archive.zip    # Never overwrite
```

### Options

| Option | Description |
|--------|-------------|
| `-r` | Recursive |
| `-e` | Encrypt |
| `-9` | Best compression |
| `-l` | List contents |
| `-t` | Test integrity |
| `-d` | Extract directory |
| `-o` | Overwrite |
| `-n` | Never overwrite |

---

## Comparison

### Compression Ratio and Speed

| Format | Compression | Speed | Use Case |
|--------|-------------|-------|----------|
| gzip | Good | Fast | General purpose |
| bzip2 | Better | Medium | Backups |
| xz | Best | Slow | Archival |
| zip | Good | Fast | Cross-platform |

### File Size Comparison (example)

```
Original:  100 MB
gzip:       25 MB (75% reduction)
bzip2:      20 MB (80% reduction)
xz:         15 MB (85% reduction)
zip:        25 MB (75% reduction)
```

### Which to Use?

| Scenario | Recommended |
|----------|-------------|
| Quick backups | tar.gz |
| Long-term archival | tar.xz |
| Sharing with Windows | zip |
| Maximum compatibility | tar.gz |
| Smallest size | tar.xz |

---

## 🏋️ Practice Exercises

1. Create a tar.gz archive of a directory
2. List the contents of a compressed archive without extracting
3. Extract only specific files from an archive
4. Create a zip file with a password
5. Compare compression ratios of different methods

### Solutions

```bash
# Exercise 1
tar -czvf backup.tar.gz mydir/

# Exercise 2
tar -tzvf backup.tar.gz

# Exercise 3
tar -xzvf backup.tar.gz path/to/specific/file.txt

# Exercise 4
zip -e secure.zip important.txt

# Exercise 5
# Create test file
dd if=/dev/urandom of=test.bin bs=1M count=10
gzip -k test.bin
bzip2 -k test.bin
xz -k test.bin
ls -lh test.*
```

---

## 🔗 Next Topic

Continue to [File Conversion](file-conversion.md) →
