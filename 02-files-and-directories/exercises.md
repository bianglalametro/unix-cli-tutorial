# Module 02 Exercises

Practice what you've learned about files and directories.

## 🟢 Beginner Exercises

### Exercise 1: Navigation Basics
Navigate the file system and answer these questions:

```bash
# 1. What is your current directory?

# 2. Navigate to /tmp, then back to your home directory

# 3. What files and directories are in /etc? (show hidden too)

# 4. Navigate to /var/log, then use cd - to go back
```

<details>
<summary>Solution</summary>

```bash
# 1
pwd

# 2
cd /tmp
cd ~
# or: cd

# 3
ls -la /etc

# 4
cd /var/log
cd -
```
</details>

---

### Exercise 2: Creating Files and Directories

Create the following structure in a new `practice` directory:

```
practice/
├── documents/
│   ├── notes.txt
│   └── todo.txt
├── images/
└── scripts/
    └── hello.sh
```

<details>
<summary>Solution</summary>

```bash
# Create directories
mkdir -p practice/{documents,images,scripts}

# Create files
touch practice/documents/notes.txt
touch practice/documents/todo.txt
touch practice/scripts/hello.sh

# Verify
tree practice
```
</details>

---

### Exercise 3: Copying and Moving

Using the `practice` directory from Exercise 2:

1. Copy `notes.txt` to `notes_backup.txt`
2. Move `todo.txt` to the `practice/` root
3. Rename `hello.sh` to `greeting.sh`

<details>
<summary>Solution</summary>

```bash
# 1. Copy file
cp practice/documents/notes.txt practice/documents/notes_backup.txt

# 2. Move file
mv practice/documents/todo.txt practice/

# 3. Rename file
mv practice/scripts/hello.sh practice/scripts/greeting.sh

# Verify
tree practice
```
</details>

---

## 🟡 Intermediate Exercises

### Exercise 4: Batch Operations

1. Create 10 numbered files: `file01.txt` through `file10.txt`
2. Move all even-numbered files to a new `even/` directory
3. Copy all odd-numbered files to a new `odd/` directory

<details>
<summary>Solution</summary>

```bash
# 1. Create files
touch file{01..10}.txt

# 2. Create even directory and move files
mkdir even
mv file02.txt file04.txt file06.txt file08.txt file10.txt even/

# 3. Create odd directory and copy files
mkdir odd
cp file01.txt file03.txt file05.txt file07.txt file09.txt odd/

# Verify
ls
ls even
ls odd
```
</details>

---

### Exercise 5: Working with Paths

Given you're in `/home/user/projects/webapp/src/components`:

1. How do you navigate to `/home/user/projects/webapp/config` using relative paths?
2. How do you reference a file `/home/user/data/input.csv` using both absolute and relative paths?
3. What does `cd ../../../..` do?

<details>
<summary>Solution</summary>

```bash
# 1. Navigate to config
cd ../../config

# 2. Reference the file
# Absolute:
cat /home/user/data/input.csv
# Relative (from components):
cat ../../../../data/input.csv
# Using ~:
cat ~/data/input.csv

# 3. cd ../../../.. goes up 4 directories
# From /home/user/projects/webapp/src/components
# ../          -> /home/user/projects/webapp/src
# ../..        -> /home/user/projects/webapp
# ../../..     -> /home/user/projects
# ../../../..  -> /home/user
```
</details>

---

### Exercise 6: Safe File Operations

Practice safe file management:

1. Create a file `important.txt` with some content
2. Make a backup before editing (with timestamp)
3. Create a "trash" directory and move files there instead of deleting

<details>
<summary>Solution</summary>

```bash
# 1. Create file with content
echo "Important data" > important.txt

# 2. Backup with timestamp
cp important.txt important.txt.$(date +%Y%m%d_%H%M%S).bak

# 3. Create trash and move files there
mkdir -p ~/.trash
mv important.txt ~/.trash/

# List backups
ls -la important.txt*

# List trash
ls ~/.trash
```
</details>

---

## 🔴 Advanced Exercises

### Exercise 7: Project Structure

Create a complete project structure for a web application:

```
myapp/
├── README.md
├── package.json
├── src/
│   ├── index.js
│   ├── components/
│   │   └── .gitkeep
│   └── utils/
│       └── .gitkeep
├── public/
│   ├── index.html
│   └── assets/
│       ├── css/
│       ├── js/
│       └── images/
├── tests/
│   └── .gitkeep
└── config/
    ├── default.json
    └── production.json
```

<details>
<summary>Solution</summary>

```bash
# Create all directories at once
mkdir -p myapp/{src/{components,utils},public/assets/{css,js,images},tests,config}

# Create files
touch myapp/README.md
touch myapp/package.json
touch myapp/src/index.js
touch myapp/src/components/.gitkeep
touch myapp/src/utils/.gitkeep
touch myapp/public/index.html
touch myapp/tests/.gitkeep
touch myapp/config/default.json
touch myapp/config/production.json

# Verify
tree myapp
```
</details>

---

### Exercise 8: File Detective

Use file commands to investigate files:

1. Find the type of `/bin/ls`
2. Get detailed statistics of your `.bashrc` file
3. Compare file sizes in `/var/log` (show top 5 largest)

<details>
<summary>Solution</summary>

```bash
# 1. File type
file /bin/ls

# 2. Detailed stats
stat ~/.bashrc

# 3. Top 5 largest files in /var/log
ls -lhS /var/log | head -6
# or
du -h /var/log/* 2>/dev/null | sort -rh | head -5
```
</details>

---

### Exercise 9: Cleanup Script

Write a series of commands to:

1. Find all `.tmp` files in current directory and subdirectories
2. Find all empty directories
3. Create a cleanup script location

<details>
<summary>Solution</summary>

```bash
# 1. Find .tmp files
find . -name "*.tmp" -type f

# 2. Find empty directories
find . -type d -empty

# 3. Commands to clean (be careful!)
# Remove tmp files:
# find . -name "*.tmp" -type f -delete

# Remove empty directories:
# find . -type d -empty -delete

# Safer approach - move to trash:
mkdir -p /tmp/cleanup_$(date +%Y%m%d)
find . -name "*.tmp" -type f -exec mv {} /tmp/cleanup_$(date +%Y%m%d)/ \;
```
</details>

---

### Exercise 10: Challenge - Organize Downloads

Given a Downloads folder with mixed files, organize them by extension:

1. Create subdirectories: `images/`, `documents/`, `archives/`, `other/`
2. Move files based on extension:
   - `.jpg`, `.png`, `.gif` → images/
   - `.pdf`, `.doc`, `.txt` → documents/
   - `.zip`, `.tar`, `.gz` → archives/
   - Everything else → other/

<details>
<summary>Solution</summary>

```bash
# Navigate to Downloads (create test files if needed)
cd ~/Downloads

# Create directories
mkdir -p images documents archives other

# Move files by extension
# Images
mv *.jpg *.jpeg *.png *.gif *.bmp images/ 2>/dev/null

# Documents
mv *.pdf *.doc *.docx *.txt *.md *.odt documents/ 2>/dev/null

# Archives
mv *.zip *.tar *.gz *.bz2 *.7z *.rar archives/ 2>/dev/null

# Move remaining files to other (excluding directories)
find . -maxdepth 1 -type f -exec mv {} other/ \;

# Verify
tree -L 1
```
</details>

---

## 💡 Tips for Exercises

1. **Always verify** - Use `ls` and `tree` to check your work
2. **Use --help** - Commands have built-in help
3. **Start safe** - Use `-i` flag with rm, cp, mv when learning
4. **Practice paths** - Both absolute and relative paths
5. **Tab completion** - Your best friend for avoiding typos

---

## 🔗 Continue Learning

- [Module 03: Permissions and Links](../03-permissions-and-links/)
- [Cheatsheets: Essential Commands](../cheatsheets/essential-commands.md)
