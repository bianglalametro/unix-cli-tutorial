# 🟢 Beginner Exercises

> Start your command-line journey here!

---

## Exercise 1: Navigation Basics

### Objective
Learn to navigate the file system using `pwd`, `cd`, and `ls`.

### Tasks

1. **Print your current directory**
   ```bash
   # Your command here
   ```
   <details>
   <summary>💡 Hint</summary>
   Use the `pwd` command
   </details>

   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   pwd
   ```
   </details>

2. **Navigate to your home directory**
   ```bash
   # Your command here
   ```
   <details>
   <summary>💡 Hint</summary>
   Use `cd` with `~` or no argument
   </details>

   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   cd ~
   # or simply
   cd
   ```
   </details>

3. **List all files (including hidden) in your home directory**
   ```bash
   # Your command here
   ```
   <details>
   <summary>💡 Hint</summary>
   Use `ls` with the `-a` flag
   </details>

   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   ls -a
   # or for more detail
   ls -la
   ```
   </details>

4. **Navigate to `/var/log` and list files sorted by modification time**
   ```bash
   # Your commands here
   ```
   <details>
   <summary>💡 Hint</summary>
   Combine `cd` and `ls -t`
   </details>

   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   cd /var/log
   ls -lt
   ```
   </details>

5. **Return to your previous directory**
   ```bash
   # Your command here
   ```
   <details>
   <summary>💡 Hint</summary>
   Use `cd -`
   </details>

   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   cd -
   ```
   </details>

---

## Exercise 2: Creating and Organizing Files

### Objective
Practice creating files and directories.

### Setup
First, create a practice directory:
```bash
mkdir -p ~/practice
cd ~/practice
```

### Tasks

1. **Create an empty file called `notes.txt`**
   ```bash
   # Your command here
   ```
   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   touch notes.txt
   ```
   </details>

2. **Create a directory structure: `projects/web/css` (all at once)**
   ```bash
   # Your command here
   ```
   <details>
   <summary>💡 Hint</summary>
   Use `mkdir -p`
   </details>

   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   mkdir -p projects/web/css
   ```
   </details>

3. **Create three files at once: `file1.txt`, `file2.txt`, `file3.txt`**
   ```bash
   # Your command here
   ```
   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   touch file1.txt file2.txt file3.txt
   ```
   </details>

4. **Create a hidden file called `.config`**
   ```bash
   # Your command here
   ```
   <details>
   <summary>💡 Hint</summary>
   Files starting with `.` are hidden
   </details>

   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   touch .config
   ```
   </details>

5. **Verify all files exist (including hidden)**
   ```bash
   # Your command here
   ```
   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   ls -la
   ```
   </details>

---

## Exercise 3: Copying and Moving Files

### Objective
Practice copying, moving, and renaming files.

### Tasks

1. **Copy `notes.txt` to `notes_backup.txt`**
   ```bash
   # Your command here
   ```
   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   cp notes.txt notes_backup.txt
   ```
   </details>

2. **Move `file1.txt` into the `projects` directory**
   ```bash
   # Your command here
   ```
   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   mv file1.txt projects/
   ```
   </details>

3. **Rename `file2.txt` to `document.txt`**
   ```bash
   # Your command here
   ```
   <details>
   <summary>💡 Hint</summary>
   Use `mv` to rename
   </details>

   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   mv file2.txt document.txt
   ```
   </details>

4. **Copy the entire `projects` directory to `projects_backup`**
   ```bash
   # Your command here
   ```
   <details>
   <summary>💡 Hint</summary>
   Use `cp -r` for recursive copy
   </details>

   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   cp -r projects projects_backup
   ```
   </details>

---

## Exercise 4: Viewing File Contents

### Objective
Learn different ways to view file contents.

### Setup
Create a sample file:
```bash
cd ~/practice
seq 1 100 > numbers.txt
echo -e "Line 1\nLine 2\nLine 3\nLine 4\nLine 5" > sample.txt
```

### Tasks

1. **Display the entire contents of `sample.txt`**
   ```bash
   # Your command here
   ```
   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   cat sample.txt
   ```
   </details>

2. **Display the first 5 lines of `numbers.txt`**
   ```bash
   # Your command here
   ```
   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   head -n 5 numbers.txt
   ```
   </details>

3. **Display the last 10 lines of `numbers.txt`**
   ```bash
   # Your command here
   ```
   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   tail -n 10 numbers.txt
   ```
   </details>

4. **Display `numbers.txt` with line numbers**
   ```bash
   # Your command here
   ```
   <details>
   <summary>💡 Hint</summary>
   Use `cat -n` or `nl`
   </details>

   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   cat -n numbers.txt
   # or
   nl numbers.txt
   ```
   </details>

5. **View `numbers.txt` one page at a time**
   ```bash
   # Your command here
   ```
   <details>
   <summary>💡 Hint</summary>
   Use `less` (press `q` to quit)
   </details>

   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   less numbers.txt
   ```
   </details>

---

## Exercise 5: Removing Files and Directories

### Objective
Practice safe deletion of files and directories.

### Tasks

1. **Remove `file3.txt`**
   ```bash
   # Your command here
   ```
   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   rm file3.txt
   ```
   </details>

2. **Remove `projects_backup` directory and all its contents**
   ```bash
   # Your command here
   ```
   <details>
   <summary>💡 Hint</summary>
   Use `rm -r`
   </details>

   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   rm -r projects_backup
   ```
   </details>

3. **Try to remove an empty directory using `rmdir`**
   ```bash
   # First create an empty directory
   mkdir empty_dir
   # Now remove it
   # Your command here
   ```
   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   rmdir empty_dir
   ```
   </details>

---

## Exercise 6: Basic Commands Practice

### Objective
Practice various basic commands.

### Tasks

1. **Display today's date**
   ```bash
   # Your command here
   ```
   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   date
   ```
   </details>

2. **Display a calendar for the current month**
   ```bash
   # Your command here
   ```
   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   cal
   ```
   </details>

3. **Display your username**
   ```bash
   # Your command here
   ```
   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   whoami
   ```
   </details>

4. **Display the hostname of your machine**
   ```bash
   # Your command here
   ```
   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   hostname
   ```
   </details>

5. **Clear the terminal screen**
   ```bash
   # Your command here
   ```
   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   clear
   # or press Ctrl+L
   ```
   </details>

---

## Exercise 7: Putting It All Together

### Challenge
Create the following directory structure and files:

```
my_project/
├── src/
│   ├── main.c
│   └── utils.c
├── include/
│   └── header.h
├── docs/
│   └── readme.txt
└── Makefile
```

<details>
<summary>💡 Hint</summary>

Break it down:
1. Create the main directory and subdirectories
2. Create the files in each directory
</details>

<details>
<summary>✅ Solution</summary>

```bash
# Create directories
mkdir -p my_project/src my_project/include my_project/docs

# Create files
touch my_project/src/main.c
touch my_project/src/utils.c
touch my_project/include/header.h
touch my_project/docs/readme.txt
touch my_project/Makefile

# Verify
ls -R my_project
```
</details>

---

## 🏆 Mini Project: Organize Downloads

### Scenario
Create a script-like sequence of commands to organize files by type.

### Setup
```bash
cd ~/practice
mkdir downloads
cd downloads
touch document.pdf report.pdf image.jpg photo.png video.mp4 song.mp3
```

### Task
Create subdirectories and move files into appropriate folders:
- PDFs → `documents/`
- Images (jpg, png) → `images/`
- Videos → `videos/`
- Audio → `audio/`

<details>
<summary>✅ Solution</summary>

```bash
# Create directories
mkdir documents images videos audio

# Move files
mv *.pdf documents/
mv *.jpg *.png images/
mv *.mp4 videos/
mv *.mp3 audio/

# Verify
ls -R
```
</details>

---

## 🧹 Cleanup

When you're done practicing, clean up:

```bash
cd ~
rm -rf ~/practice
```

---

## ✅ Checklist

- [ ] I can navigate using `cd`, `pwd`, and `ls`
- [ ] I can create files with `touch` and directories with `mkdir`
- [ ] I can copy files and directories with `cp`
- [ ] I can move and rename with `mv`
- [ ] I can view file contents with `cat`, `head`, `tail`, and `less`
- [ ] I can remove files with `rm` and directories with `rmdir` or `rm -r`

---

**Next Steps:** Continue to [Intermediate Exercises](../intermediate/)
