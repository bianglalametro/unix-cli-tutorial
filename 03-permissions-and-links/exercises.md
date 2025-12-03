# Module 03 Exercises

Practice permissions, links, and I/O redirection.

## 🟢 Beginner Exercises

### Exercise 1: Understanding Permissions
Look at the following permission string and answer questions:
```
-rwxr-x--- 1 john developers 4096 Dec  3 08:00 script.sh
```

1. What type of file is this?
2. What can the owner (john) do?
3. What can members of "developers" group do?
4. What can others do?
5. What is the octal notation for these permissions?

<details>
<summary>Solution</summary>

1. Regular file (indicated by `-` at the start)
2. Owner can read, write, and execute (rwx)
3. Group can read and execute (r-x)
4. Others have no permissions (---)
5. Octal: 750 (rwx=7, r-x=5, ---=0)
</details>

---

### Exercise 2: Changing Permissions
Create a file and practice changing its permissions:

1. Create a file called `myfile.txt`
2. Remove all permissions for others
3. Make it readable and writable by group
4. Make it read-only for everyone

<details>
<summary>Solution</summary>

```bash
# 1. Create file
touch myfile.txt

# 2. Remove permissions for others
chmod o-rwx myfile.txt
# or: chmod o= myfile.txt

# 3. Make readable/writable by group
chmod g+rw myfile.txt

# 4. Make read-only for everyone
chmod a=r myfile.txt
# or: chmod 444 myfile.txt
```
</details>

---

### Exercise 3: Basic Redirection
Practice basic I/O redirection:

1. Save the output of `ls -la` to a file
2. Append the current date to that file
3. Count lines in the file

<details>
<summary>Solution</summary>

```bash
# 1. Save ls output
ls -la > listing.txt

# 2. Append date
date >> listing.txt

# 3. Count lines
wc -l < listing.txt
# or: wc -l listing.txt
```
</details>

---

## 🟡 Intermediate Exercises

### Exercise 4: Links Practice
Create and understand different types of links:

1. Create a file with some content
2. Create a hard link to it
3. Create a symbolic link to it
4. Verify they share/don't share inodes
5. Delete the original and check what happens to each link

<details>
<summary>Solution</summary>

```bash
# 1. Create file
echo "Important content" > original.txt

# 2. Create hard link
ln original.txt hardlink.txt

# 3. Create symbolic link
ln -s original.txt symlink.txt

# 4. Check inodes
ls -li original.txt hardlink.txt symlink.txt
# Hard link shares inode with original
# Symbolic link has its own inode

# 5. Delete original
rm original.txt

# Check links
cat hardlink.txt   # Works! Data still accessible
cat symlink.txt    # Error! Broken link
```
</details>

---

### Exercise 5: Building Pipelines
Build command pipelines to:

1. Find all `.txt` files in `/etc` and count them
2. List running processes and find those using the most memory (top 5)
3. Count unique words in a text file

<details>
<summary>Solution</summary>

```bash
# 1. Count .txt files in /etc
find /etc -name "*.txt" 2>/dev/null | wc -l

# 2. Top 5 memory-using processes
ps aux | sort -k4 -rn | head -5

# 3. Count unique words (create test file first)
echo "hello world hello foo bar world" > test.txt
cat test.txt | tr ' ' '\n' | sort | uniq | wc -l
```
</details>

---

### Exercise 6: Error Handling
Practice separating stdout and stderr:

1. Try to list both `/etc` and a non-existent directory
2. Save successful output to one file, errors to another
3. Discard errors and show only successful output

<details>
<summary>Solution</summary>

```bash
# 1 & 2. Separate stdout and stderr
ls /etc /nonexistent_dir > success.txt 2> errors.txt

# Check files
cat success.txt   # Shows /etc listing
cat errors.txt    # Shows error message

# 3. Discard errors
ls /etc /nonexistent_dir 2>/dev/null
```
</details>

---

## 🔴 Advanced Exercises

### Exercise 7: Permission Scenarios

Set up these permission scenarios:

1. **Private file**: Only you can read and write
2. **Shared script**: You can edit, your group can execute, others nothing
3. **Public directory with sticky bit**: Anyone can create files, but only owners can delete them

<details>
<summary>Solution</summary>

```bash
# 1. Private file (600)
touch private.txt
chmod 600 private.txt
ls -l private.txt
# -rw------- ...

# 2. Shared script (750)
touch shared_script.sh
chmod 750 shared_script.sh
ls -l shared_script.sh
# -rwxr-x--- ...

# 3. Sticky directory (1777)
mkdir shared_directory
chmod 1777 shared_directory
ls -ld shared_directory
# drwxrwxrwt ...
```
</details>

---

### Exercise 8: Complex Pipeline

Create a pipeline that:
1. Finds all files modified in the last 7 days in your home directory
2. Filters to only show `.txt` files
3. Counts the total number of lines across all files
4. Saves the count to a file while also displaying it

<details>
<summary>Solution</summary>

```bash
# Create some test files first
echo -e "line1\nline2\nline3" > ~/test1.txt
echo -e "line1\nline2" > ~/test2.txt

# The pipeline
find ~ -type f -name "*.txt" -mtime -7 2>/dev/null | \
    xargs cat 2>/dev/null | \
    wc -l | \
    tee line_count.txt

# Alternative approach
find ~ -type f -name "*.txt" -mtime -7 -exec cat {} \; 2>/dev/null | \
    wc -l | \
    tee line_count.txt
```
</details>

---

### Exercise 9: Process Substitution

Use process substitution to:
1. Compare the files in two directories
2. Join data from two different commands

<details>
<summary>Solution</summary>

```bash
# 1. Compare directory contents
mkdir dir1 dir2
touch dir1/{a,b,c}.txt
touch dir2/{b,c,d}.txt
diff <(ls dir1) <(ls dir2)

# 2. Join data from two commands
# List files with their sizes and modification times side by side
paste <(ls -l | awk '{print $5}') <(ls -l | awk '{print $6, $7, $8}')
```
</details>

---

### Exercise 10: Comprehensive Challenge

Create a log analysis pipeline:

1. Given a simulated log file with entries like:
   ```
   2024-12-03 08:00:00 INFO User logged in
   2024-12-03 08:00:01 ERROR Database connection failed
   2024-12-03 08:00:02 INFO Request processed
   2024-12-03 08:00:03 WARNING Slow response time
   ```

2. Create a pipeline that:
   - Extracts only ERROR and WARNING lines
   - Counts how many of each type
   - Saves results to a report file

<details>
<summary>Solution</summary>

```bash
# Create sample log
cat << 'EOF' > sample.log
2024-12-03 08:00:00 INFO User logged in
2024-12-03 08:00:01 ERROR Database connection failed
2024-12-03 08:00:02 INFO Request processed
2024-12-03 08:00:03 WARNING Slow response time
2024-12-03 08:00:04 ERROR File not found
2024-12-03 08:00:05 INFO Task completed
2024-12-03 08:00:06 WARNING Memory usage high
2024-12-03 08:00:07 ERROR Timeout
EOF

# Analysis pipeline
grep -E "(ERROR|WARNING)" sample.log | \
    awk '{print $3}' | \
    sort | \
    uniq -c | \
    tee report.txt

# More detailed report
{
    echo "=== Log Analysis Report ==="
    echo "Generated: $(date)"
    echo ""
    echo "Error/Warning Summary:"
    grep -E "(ERROR|WARNING)" sample.log | awk '{print $3}' | sort | uniq -c
    echo ""
    echo "Detailed Messages:"
    grep -E "(ERROR|WARNING)" sample.log
} > detailed_report.txt

cat detailed_report.txt
```
</details>

---

## 💡 Tips

1. **Test permissions**: Create test files to practice without risking important data
2. **Use ls -l often**: Check permissions after each change
3. **Understand octal**: Practice converting between symbolic and octal notation
4. **Build incrementally**: Test each part of a pipeline before adding more

---

## 🔗 Continue Learning

- [Module 04: Text Processing](../04-text-processing/)
- [Cheatsheets: File Permissions](../cheatsheets/file-permissions.md)
