# Module 04 Exercises

Practice text viewing, searching, and processing.

## 🟢 Beginner Exercises

### Exercise 1: Viewing Files
Using a text file of your choice:

1. Display the first 5 lines
2. Display the last 10 lines
3. Count the total number of lines
4. View the file with line numbers

<details>
<summary>Solution</summary>

```bash
# Create a sample file first
seq 1 50 > numbers.txt

# 1. First 5 lines
head -n 5 numbers.txt

# 2. Last 10 lines
tail -n 10 numbers.txt

# 3. Count lines
wc -l numbers.txt

# 4. View with line numbers
cat -n numbers.txt
# or: nl numbers.txt
```
</details>

---

### Exercise 2: Basic Search
Search for patterns in `/etc/passwd`:

1. Find lines containing "root"
2. Find lines containing "bash"
3. Count how many users use bash as their shell

<details>
<summary>Solution</summary>

```bash
# 1. Lines with "root"
grep "root" /etc/passwd

# 2. Lines with "bash"
grep "bash" /etc/passwd

# 3. Count bash users
grep -c "bash" /etc/passwd
# or: grep "bash" /etc/passwd | wc -l
```
</details>

---

### Exercise 3: Extracting Fields
Using `/etc/passwd`:

1. Extract just the usernames (first field)
2. Extract usernames and shells (fields 1 and 7)
3. List all unique shells used

<details>
<summary>Solution</summary>

```bash
# 1. Usernames only
cut -d: -f1 /etc/passwd

# 2. Usernames and shells
cut -d: -f1,7 /etc/passwd
# or: awk -F: '{print $1, $7}' /etc/passwd

# 3. Unique shells
cut -d: -f7 /etc/passwd | sort | uniq
```
</details>

---

## 🟡 Intermediate Exercises

### Exercise 4: Text Transformation
Given a file with mixed case text:

1. Convert all text to uppercase
2. Convert all text to lowercase
3. Replace all spaces with underscores

<details>
<summary>Solution</summary>

```bash
# Create sample file
echo "Hello World from Unix" > sample.txt

# 1. Uppercase
tr 'a-z' 'A-Z' < sample.txt

# 2. Lowercase
tr 'A-Z' 'a-z' < sample.txt

# 3. Spaces to underscores
tr ' ' '_' < sample.txt
# or: sed 's/ /_/g' sample.txt
```
</details>

---

### Exercise 5: Sorting and Counting
Create a file with repeated words and:

1. Sort the words alphabetically
2. Count occurrences of each word
3. Find the top 3 most common words

<details>
<summary>Solution</summary>

```bash
# Create sample file
cat << EOF > words.txt
apple
banana
apple
cherry
banana
apple
date
cherry
apple
EOF

# 1. Sort alphabetically
sort words.txt

# 2. Count occurrences
sort words.txt | uniq -c

# 3. Top 3 most common
sort words.txt | uniq -c | sort -rn | head -3
```
</details>

---

### Exercise 6: Log Analysis
Create a sample log file and analyze it:

1. Find all ERROR lines
2. Count errors vs warnings
3. Extract timestamps of all errors

<details>
<summary>Solution</summary>

```bash
# Create sample log
cat << EOF > app.log
2024-12-03 10:00:00 INFO Application started
2024-12-03 10:00:01 ERROR Database connection failed
2024-12-03 10:00:02 WARN Memory usage high
2024-12-03 10:00:03 INFO Request processed
2024-12-03 10:00:04 ERROR Timeout occurred
2024-12-03 10:00:05 INFO Cleanup complete
2024-12-03 10:00:06 WARN Disk space low
2024-12-03 10:00:07 ERROR File not found
EOF

# 1. Find ERROR lines
grep "ERROR" app.log

# 2. Count errors vs warnings
grep -c "ERROR" app.log
grep -c "WARN" app.log
# or combined:
grep -E "ERROR|WARN" app.log | awk '{print $3}' | sort | uniq -c

# 3. Timestamps of errors
grep "ERROR" app.log | awk '{print $1, $2}'
# or: grep "ERROR" app.log | cut -d' ' -f1,2
```
</details>

---

## 🔴 Advanced Exercises

### Exercise 7: Complex Pipeline
Given a CSV file, create a pipeline that:

1. Skips the header line
2. Extracts the second column
3. Sorts values and removes duplicates
4. Counts total unique values

<details>
<summary>Solution</summary>

```bash
# Create sample CSV
cat << EOF > data.csv
name,department,salary
John,Engineering,75000
Jane,Marketing,65000
Bob,Engineering,80000
Alice,HR,60000
Charlie,Engineering,72000
Diana,Marketing,68000
EOF

# Complete pipeline
tail -n +2 data.csv | cut -d, -f2 | sort -u | wc -l

# Step by step:
# Skip header
tail -n +2 data.csv
# Extract second column
tail -n +2 data.csv | cut -d, -f2
# Sort unique
tail -n +2 data.csv | cut -d, -f2 | sort -u
# Count
tail -n +2 data.csv | cut -d, -f2 | sort -u | wc -l
```
</details>

---

### Exercise 8: AWK Processing
Using the CSV file from Exercise 7:

1. Print names and salaries
2. Calculate the total of all salaries
3. Find the highest paid employee
4. Calculate average salary per department

<details>
<summary>Solution</summary>

```bash
# Use the data.csv from Exercise 7

# 1. Names and salaries
awk -F, 'NR>1 {print $1, $3}' data.csv

# 2. Total salaries
awk -F, 'NR>1 {sum+=$3} END {print "Total:", sum}' data.csv

# 3. Highest paid
awk -F, 'NR>1 && $3>max {max=$3; name=$1} END {print name, max}' data.csv

# 4. Average by department
awk -F, 'NR>1 {sum[$2]+=$3; count[$2]++} END {for (dept in sum) print dept, sum[dept]/count[dept]}' data.csv
```
</details>

---

### Exercise 9: Regular Expressions
Create a file with various patterns and extract:

1. All email addresses
2. All phone numbers (XXX-XXX-XXXX format)
3. All URLs
4. All lines starting with a date (YYYY-MM-DD)

<details>
<summary>Solution</summary>

```bash
# Create sample file
cat << EOF > patterns.txt
Contact: john@example.com
Phone: 555-123-4567
Visit: https://example.com
2024-12-03 Event scheduled
Email sales@company.org for info
Call 800-555-0199 today
http://test.site/page
2024-01-15 Meeting notes
Invalid: notanemail or 123-45-678
EOF

# 1. Email addresses
grep -oE "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}" patterns.txt

# 2. Phone numbers
grep -oE "[0-9]{3}-[0-9]{3}-[0-9]{4}" patterns.txt

# 3. URLs
grep -oE "https?://[A-Za-z0-9./-]+" patterns.txt

# 4. Lines starting with date
grep -E "^[0-9]{4}-[0-9]{2}-[0-9]{2}" patterns.txt
```
</details>

---

### Exercise 10: Comprehensive Challenge
Analyze a web server access log:

1. Extract all unique IP addresses
2. Count requests per IP address
3. Find the top 10 most active IPs
4. Count requests by HTTP status code
5. Find all 404 errors and their URLs

<details>
<summary>Solution</summary>

```bash
# Create sample access log
cat << EOF > access.log
192.168.1.1 - - [03/Dec/2024:10:00:00] "GET /index.html HTTP/1.1" 200 1234
192.168.1.2 - - [03/Dec/2024:10:00:01] "GET /about.html HTTP/1.1" 200 2345
192.168.1.1 - - [03/Dec/2024:10:00:02] "GET /missing.html HTTP/1.1" 404 567
192.168.1.3 - - [03/Dec/2024:10:00:03] "GET /index.html HTTP/1.1" 200 1234
192.168.1.1 - - [03/Dec/2024:10:00:04] "POST /api/data HTTP/1.1" 500 89
192.168.1.2 - - [03/Dec/2024:10:00:05] "GET /contact.html HTTP/1.1" 200 1567
192.168.1.1 - - [03/Dec/2024:10:00:06] "GET /old-page.html HTTP/1.1" 404 567
192.168.1.4 - - [03/Dec/2024:10:00:07] "GET /index.html HTTP/1.1" 200 1234
EOF

# 1. Unique IP addresses
awk '{print $1}' access.log | sort -u

# 2. Count per IP
awk '{print $1}' access.log | sort | uniq -c

# 3. Top 10 most active
awk '{print $1}' access.log | sort | uniq -c | sort -rn | head -10

# 4. Count by status code
awk '{print $9}' access.log | sort | uniq -c

# 5. 404 errors and URLs
grep '" 404 ' access.log | awk '{print $7}'
# or with more details:
awk '$9 == 404 {print $1, $7}' access.log
```
</details>

---

## 💡 Tips

1. **Build pipelines incrementally** - Test each step
2. **Use `head`** - Preview output before processing everything
3. **Quote your patterns** - Prevent shell interpretation
4. **Remember `sort` before `uniq`** - uniq only removes adjacent duplicates
5. **Test regex with simple patterns first** - Build complexity gradually

---

## 📝 Project Ideas

### 1. Word Frequency Analyzer
Create a script that:
- Takes a text file as input
- Counts word frequencies
- Outputs top N words
- Ignores common words (the, a, is, etc.)

### 2. Log Monitor
Build a log analyzer that:
- Watches a log file in real-time
- Alerts on ERROR patterns
- Summarizes activity hourly
- Outputs statistics

### 3. CSV Report Generator
Create a pipeline that:
- Reads a CSV file
- Filters by specific criteria
- Calculates statistics
- Generates a formatted report

---

## 🔗 Continue Learning

- [Module 05: Processes and Jobs](../05-processes-and-jobs/)
- [Cheatsheets: Regex](../cheatsheets/regex-cheatsheet.md)
