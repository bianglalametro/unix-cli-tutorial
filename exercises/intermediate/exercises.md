# 🟡 Intermediate Exercises

> Build on your foundation with these challenging exercises

---

## Exercise 1: File Permissions

### Objective
Master file permissions and ownership.

### Setup
```bash
mkdir -p ~/practice-intermediate
cd ~/practice-intermediate
touch script.sh data.txt config.conf
```

### Tasks

1. **View the current permissions of all files**
   ```bash
   # Your command here
   ```
   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   ls -l
   ```
   </details>

2. **Make `script.sh` executable for the owner**
   ```bash
   # Your command here
   ```
   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   chmod u+x script.sh
   # or
   chmod 744 script.sh
   ```
   </details>

3. **Set `data.txt` to read-only for everyone**
   ```bash
   # Your command here
   ```
   <details>
   <summary>💡 Hint</summary>
   Permission 444 or a-w+r
   </details>

   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   chmod 444 data.txt
   # or
   chmod a=r data.txt
   ```
   </details>

4. **Set `config.conf` permissions to: owner (rw), group (r), others (none)**
   ```bash
   # Your command here
   ```
   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   chmod 640 config.conf
   # or
   chmod u=rw,g=r,o= config.conf
   ```
   </details>

5. **What permissions does 755 represent? Verify by applying it to `script.sh`**
   <details>
   <summary>✅ Solution</summary>
   
   755 = rwxr-xr-x (owner: all, group: read+execute, others: read+execute)
   ```bash
   chmod 755 script.sh
   ls -l script.sh
   ```
   </details>

---

## Exercise 2: Text Processing with grep

### Objective
Learn to search and filter text with grep.

### Setup
```bash
cd ~/practice-intermediate
cat > logfile.txt << 'EOF'
2023-12-01 10:00:01 INFO Server started
2023-12-01 10:05:23 ERROR Connection failed
2023-12-01 10:05:24 INFO Retrying connection
2023-12-01 10:05:30 INFO Connection established
2023-12-01 10:10:00 WARNING High memory usage
2023-12-01 10:15:00 ERROR Database timeout
2023-12-01 10:15:01 INFO Reconnecting to database
2023-12-01 10:15:05 INFO Database connection restored
2023-12-01 10:20:00 DEBUG Cleanup routine started
2023-12-01 10:30:00 INFO Server shutdown initiated
EOF
```

### Tasks

1. **Find all ERROR lines**
   ```bash
   # Your command here
   ```
   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   grep "ERROR" logfile.txt
   ```
   </details>

2. **Find all lines containing "connection" (case-insensitive)**
   ```bash
   # Your command here
   ```
   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   grep -i "connection" logfile.txt
   ```
   </details>

3. **Count the number of INFO messages**
   ```bash
   # Your command here
   ```
   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   grep -c "INFO" logfile.txt
   ```
   </details>

4. **Show line numbers for all WARNING and ERROR lines**
   ```bash
   # Your command here
   ```
   <details>
   <summary>💡 Hint</summary>
   Use `grep -n` with pattern alternation
   </details>

   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   grep -n "WARNING\|ERROR" logfile.txt
   # or with extended regex
   grep -En "WARNING|ERROR" logfile.txt
   ```
   </details>

5. **Find lines that do NOT contain "INFO"**
   ```bash
   # Your command here
   ```
   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   grep -v "INFO" logfile.txt
   ```
   </details>

---

## Exercise 3: Pipelines

### Objective
Combine commands using pipes to create powerful data processing chains.

### Setup
```bash
cd ~/practice-intermediate
cat > employees.csv << 'EOF'
name,department,salary
John Smith,Engineering,75000
Jane Doe,Marketing,65000
Bob Wilson,Engineering,80000
Alice Brown,HR,55000
Charlie Davis,Marketing,70000
Eve Johnson,Engineering,90000
Frank Miller,HR,52000
Grace Lee,Marketing,68000
EOF
```

### Tasks

1. **Display only the names of employees (first column)**
   ```bash
   # Your command here
   ```
   <details>
   <summary>💡 Hint</summary>
   Use `cut` with field delimiter
   </details>

   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   cut -d',' -f1 employees.csv | tail -n +2
   ```
   </details>

2. **Find all Engineering department employees**
   ```bash
   # Your command here
   ```
   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   grep "Engineering" employees.csv
   ```
   </details>

3. **Sort employees by salary (highest first)**
   ```bash
   # Your command here
   ```
   <details>
   <summary>💡 Hint</summary>
   Use `sort -t',' -k3 -n -r`
   </details>

   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   tail -n +2 employees.csv | sort -t',' -k3 -n -r
   ```
   </details>

4. **Count employees in each department**
   ```bash
   # Your command here
   ```
   <details>
   <summary>💡 Hint</summary>
   Combine `cut`, `sort`, and `uniq -c`
   </details>

   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   tail -n +2 employees.csv | cut -d',' -f2 | sort | uniq -c
   ```
   </details>

5. **Find the highest paid employee**
   ```bash
   # Your command here
   ```
   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   tail -n +2 employees.csv | sort -t',' -k3 -n -r | head -1
   ```
   </details>

---

## Exercise 4: I/O Redirection

### Objective
Master input/output redirection.

### Tasks

1. **Redirect the output of `ls -la` to a file called `directory_listing.txt`**
   ```bash
   # Your command here
   ```
   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   ls -la > directory_listing.txt
   ```
   </details>

2. **Append the current date to `directory_listing.txt`**
   ```bash
   # Your command here
   ```
   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   date >> directory_listing.txt
   ```
   </details>

3. **Redirect errors from a command to `errors.log`**
   ```bash
   # Your command here
   ```
   <details>
   <summary>💡 Hint</summary>
   Use `2>` for stderr
   </details>

   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   ls /nonexistent 2> errors.log
   ```
   </details>

4. **Redirect both stdout and stderr to `all_output.log`**
   ```bash
   # Your command here
   ```
   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   ls -la /tmp /nonexistent > all_output.log 2>&1
   # or in bash
   ls -la /tmp /nonexistent &> all_output.log
   ```
   </details>

5. **Use `tee` to display output and save it to a file simultaneously**
   ```bash
   # Your command here
   ```
   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   ls -la | tee listing.txt
   ```
   </details>

---

## Exercise 5: Process Management

### Objective
Monitor and manage system processes.

### Tasks

1. **List all running processes**
   ```bash
   # Your command here
   ```
   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   ps aux
   # or
   ps -ef
   ```
   </details>

2. **Find the process ID (PID) of a specific process (e.g., bash)**
   ```bash
   # Your command here
   ```
   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   pgrep bash
   # or
   ps aux | grep bash
   ```
   </details>

3. **Start a background process and verify it's running**
   ```bash
   # Your command here
   ```
   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   sleep 100 &
   jobs
   ```
   </details>

4. **Bring the background job to foreground**
   ```bash
   # Your command here
   ```
   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   fg %1
   # Then Ctrl+C to stop it
   ```
   </details>

5. **View processes in real-time**
   ```bash
   # Your command here
   ```
   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   top
   # or
   htop
   ```
   Press `q` to quit.
   </details>

---

## Exercise 6: Find Command

### Objective
Master the powerful `find` command.

### Setup
```bash
cd ~/practice-intermediate
mkdir -p project/{src,docs,tests}
touch project/src/{main.py,utils.py,config.py}
touch project/docs/{readme.md,api.md}
touch project/tests/{test_main.py,test_utils.py}
touch project/.gitignore
```

### Tasks

1. **Find all `.py` files in the project directory**
   ```bash
   # Your command here
   ```
   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   find project -name "*.py"
   ```
   </details>

2. **Find all directories in project**
   ```bash
   # Your command here
   ```
   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   find project -type d
   ```
   </details>

3. **Find files modified in the last 24 hours**
   ```bash
   # Your command here
   ```
   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   find project -mtime -1
   ```
   </details>

4. **Find all hidden files**
   ```bash
   # Your command here
   ```
   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   find project -name ".*" -type f
   ```
   </details>

5. **Find all `.md` files and display their contents**
   ```bash
   # Your command here
   ```
   <details>
   <summary>💡 Hint</summary>
   Use `-exec` with `cat`
   </details>

   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   find project -name "*.md" -exec cat {} \;
   # or
   find project -name "*.md" | xargs cat
   ```
   </details>

---

## Exercise 7: sed Basics

### Objective
Learn stream editing with sed.

### Setup
```bash
cd ~/practice-intermediate
cat > message.txt << 'EOF'
Hello World
Welcome to Linux
This is a test file
Hello again
goodbye world
EOF
```

### Tasks

1. **Replace "Hello" with "Hi" on all lines**
   ```bash
   # Your command here
   ```
   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   sed 's/Hello/Hi/g' message.txt
   ```
   </details>

2. **Replace "world" with "Universe" (case-insensitive)**
   ```bash
   # Your command here
   ```
   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   sed 's/world/Universe/gi' message.txt
   ```
   </details>

3. **Delete lines containing "test"**
   ```bash
   # Your command here
   ```
   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   sed '/test/d' message.txt
   ```
   </details>

4. **Print only lines containing "Hello"**
   ```bash
   # Your command here
   ```
   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   sed -n '/Hello/p' message.txt
   ```
   </details>

5. **Add line numbers to each line**
   ```bash
   # Your command here
   ```
   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   sed '=' message.txt | sed 'N; s/\n/. /'
   # or simply use nl
   nl message.txt
   ```
   </details>

---

## Exercise 8: awk Basics

### Objective
Learn pattern processing with awk.

### Setup
Use the `employees.csv` file from Exercise 3.

### Tasks

1. **Print only names and salaries**
   ```bash
   # Your command here
   ```
   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   awk -F',' '{print $1, $3}' employees.csv
   ```
   </details>

2. **Print employees with salary > 70000**
   ```bash
   # Your command here
   ```
   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   awk -F',' 'NR>1 && $3>70000 {print $1, $3}' employees.csv
   ```
   </details>

3. **Calculate the total salary**
   ```bash
   # Your command here
   ```
   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   awk -F',' 'NR>1 {sum+=$3} END {print "Total:", sum}' employees.csv
   ```
   </details>

4. **Calculate the average salary**
   ```bash
   # Your command here
   ```
   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   awk -F',' 'NR>1 {sum+=$3; count++} END {print "Average:", sum/count}' employees.csv
   ```
   </details>

5. **Print formatted output with header**
   ```bash
   # Your command here
   ```
   <details>
   <summary>✅ Solution</summary>
   
   ```bash
   awk -F',' 'BEGIN {printf "%-15s %-15s %s\n", "Name", "Dept", "Salary"; print "---"} 
              NR>1 {printf "%-15s %-15s $%d\n", $1, $2, $3}' employees.csv
   ```
   </details>

---

## 🏆 Challenge: Log Analysis

### Scenario
Analyze a web server log file.

### Setup
```bash
cd ~/practice-intermediate
cat > access.log << 'EOF'
192.168.1.100 - - [01/Dec/2023:10:00:01] "GET /index.html HTTP/1.1" 200 1234
192.168.1.101 - - [01/Dec/2023:10:00:02] "GET /about.html HTTP/1.1" 200 5678
192.168.1.100 - - [01/Dec/2023:10:00:03] "POST /api/login HTTP/1.1" 200 100
192.168.1.102 - - [01/Dec/2023:10:00:04] "GET /products.html HTTP/1.1" 404 0
192.168.1.100 - - [01/Dec/2023:10:00:05] "GET /index.html HTTP/1.1" 200 1234
192.168.1.103 - - [01/Dec/2023:10:00:06] "GET /contact.html HTTP/1.1" 500 0
192.168.1.101 - - [01/Dec/2023:10:00:07] "GET /about.html HTTP/1.1" 200 5678
192.168.1.104 - - [01/Dec/2023:10:00:08] "GET /index.html HTTP/1.1" 200 1234
EOF
```

### Tasks

1. **Find all requests that returned 404 status**
2. **Count requests from each IP address**
3. **Find the most requested page**
4. **Calculate total bytes transferred (last column) for successful (200) requests**
5. **List unique IP addresses**

<details>
<summary>✅ Solutions</summary>

```bash
# 1. 404 requests
grep '" 404 ' access.log

# 2. Requests per IP
awk '{print $1}' access.log | sort | uniq -c | sort -rn

# 3. Most requested page
awk '{print $7}' access.log | sort | uniq -c | sort -rn | head -1

# 4. Total bytes for 200 status
awk '$9==200 {sum+=$10} END {print "Total bytes:", sum}' access.log

# 5. Unique IPs
awk '{print $1}' access.log | sort -u
```
</details>

---

## 🧹 Cleanup

```bash
cd ~
rm -rf ~/practice-intermediate
```

---

## ✅ Checklist

- [ ] I understand and can change file permissions
- [ ] I can search text with grep and its options
- [ ] I can create pipelines combining multiple commands
- [ ] I understand I/O redirection (>, >>, 2>, &>)
- [ ] I can manage processes (ps, jobs, fg, bg)
- [ ] I can use find to locate files
- [ ] I can perform basic text transformations with sed
- [ ] I can process columnar data with awk

---

**Next Steps:** Continue to [Advanced Exercises](../advanced/)
