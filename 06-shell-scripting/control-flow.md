# Control Flow

Learn conditionals and loops in shell scripting.

## 📖 Table of Contents

- [if Statements](#if-statements)
- [Test Conditions](#test-conditions)
- [case Statements](#case-statements)
- [for Loops](#for-loops)
- [while Loops](#while-loops)
- [until Loops](#until-loops)
- [Loop Control](#loop-control)

---

## if Statements

### Basic Syntax

```bash
if condition; then
    # commands
fi

# With else
if condition; then
    # commands if true
else
    # commands if false
fi

# With elif
if condition1; then
    # commands
elif condition2; then
    # commands
else
    # commands
fi
```

### Examples

```bash
#!/bin/bash

# Simple condition
if [ "$USER" = "root" ]; then
    echo "You are root"
else
    echo "You are $USER"
fi

# Using [[ ]] (preferred in bash)
if [[ -f "$FILE" ]]; then
    echo "File exists"
fi

# Multiple conditions
if [[ $AGE -ge 18 ]] && [[ $AGE -lt 65 ]]; then
    echo "Working age"
fi
```

### [ ] vs [[ ]]

```bash
# [ ] - POSIX compatible, older
if [ "$a" = "$b" ]; then
    echo "equal"
fi

# [[ ]] - Bash extension, more features
if [[ $a == $b ]]; then
    echo "equal"
fi

# [[ ]] advantages:
# - Pattern matching: [[ $string == *.txt ]]
# - Regex: [[ $string =~ ^[0-9]+$ ]]
# - No need to quote variables (safer)
# - && and || instead of -a and -o
```

---

## Test Conditions

### File Tests

| Test | Description |
|------|-------------|
| `-e FILE` | File exists |
| `-f FILE` | Is regular file |
| `-d FILE` | Is directory |
| `-r FILE` | Is readable |
| `-w FILE` | Is writable |
| `-x FILE` | Is executable |
| `-s FILE` | File is not empty |
| `-L FILE` | Is symbolic link |
| `FILE1 -nt FILE2` | FILE1 is newer than FILE2 |
| `FILE1 -ot FILE2` | FILE1 is older than FILE2 |

```bash
if [[ -f "$FILE" ]]; then
    echo "File exists"
fi

if [[ -d "$DIR" ]]; then
    echo "Directory exists"
fi

if [[ -x "$SCRIPT" ]]; then
    echo "Script is executable"
fi
```

### String Tests

| Test | Description |
|------|-------------|
| `-z STRING` | String is empty |
| `-n STRING` | String is not empty |
| `STR1 = STR2` | Strings are equal |
| `STR1 != STR2` | Strings are not equal |
| `STR1 < STR2` | STR1 sorts before STR2 |
| `STR1 > STR2` | STR1 sorts after STR2 |

```bash
if [[ -z "$VAR" ]]; then
    echo "Variable is empty"
fi

if [[ -n "$VAR" ]]; then
    echo "Variable is not empty"
fi

if [[ "$NAME" == "John" ]]; then
    echo "Hello John"
fi

# Pattern matching (only in [[ ]])
if [[ "$FILE" == *.txt ]]; then
    echo "Text file"
fi

# Regex matching (only in [[ ]])
if [[ "$EMAIL" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
    echo "Valid email"
fi
```

### Numeric Tests

| Test | Description |
|------|-------------|
| `N1 -eq N2` | Equal |
| `N1 -ne N2` | Not equal |
| `N1 -lt N2` | Less than |
| `N1 -le N2` | Less than or equal |
| `N1 -gt N2` | Greater than |
| `N1 -ge N2` | Greater than or equal |

```bash
if [[ $AGE -ge 18 ]]; then
    echo "Adult"
fi

if [[ $COUNT -eq 0 ]]; then
    echo "Empty"
fi
```

### Logical Operators

```bash
# AND
if [[ $A -gt 0 ]] && [[ $A -lt 100 ]]; then
    echo "Between 0 and 100"
fi

# OR
if [[ $COLOR == "red" ]] || [[ $COLOR == "blue" ]]; then
    echo "Primary color"
fi

# NOT
if [[ ! -f "$FILE" ]]; then
    echo "File doesn't exist"
fi

# Combined
if [[ -f "$FILE" && -r "$FILE" ]]; then
    echo "File exists and is readable"
fi
```

---

## case Statements

Pattern matching for multiple conditions.

### Syntax

```bash
case $VARIABLE in
    pattern1)
        # commands
        ;;
    pattern2|pattern3)
        # commands for pattern2 OR pattern3
        ;;
    *)
        # default case
        ;;
esac
```

### Examples

```bash
#!/bin/bash

case $1 in
    start)
        echo "Starting..."
        ;;
    stop)
        echo "Stopping..."
        ;;
    restart)
        echo "Restarting..."
        ;;
    *)
        echo "Usage: $0 {start|stop|restart}"
        exit 1
        ;;
esac
```

### Pattern Matching

```bash
case $INPUT in
    [Yy]|[Yy][Ee][Ss])
        echo "Affirmative"
        ;;
    [Nn]|[Nn][Oo])
        echo "Negative"
        ;;
    *)
        echo "Unknown"
        ;;
esac

# File extensions
case $FILE in
    *.txt)
        echo "Text file"
        ;;
    *.jpg|*.png|*.gif)
        echo "Image file"
        ;;
    *.sh)
        echo "Shell script"
        ;;
esac
```

---

## for Loops

### List Iteration

```bash
# Basic list
for name in Alice Bob Charlie; do
    echo "Hello, $name"
done

# Array
COLORS=("red" "green" "blue")
for color in "${COLORS[@]}"; do
    echo "Color: $color"
done

# Files in directory
for file in *.txt; do
    echo "Processing $file"
done

# Command output
for user in $(cat /etc/passwd | cut -d: -f1); do
    echo "User: $user"
done
```

### C-style for Loop

```bash
# Traditional for loop
for ((i = 0; i < 10; i++)); do
    echo "Number: $i"
done

# With step
for ((i = 0; i <= 100; i += 10)); do
    echo "Value: $i"
done
```

### Range with seq or {..}

```bash
# Using brace expansion
for i in {1..5}; do
    echo "$i"
done

# With step
for i in {0..100..10}; do
    echo "$i"
done

# Using seq
for i in $(seq 1 5); do
    echo "$i"
done

# seq with start, step, end
for i in $(seq 0 2 10); do
    echo "$i"
done
```

---

## while Loops

Execute while condition is true.

### Syntax

```bash
while condition; do
    # commands
done
```

### Examples

```bash
# Counter
COUNT=0
while [[ $COUNT -lt 5 ]]; do
    echo "Count: $COUNT"
    ((COUNT++))
done

# Read file line by line
while IFS= read -r line; do
    echo "Line: $line"
done < file.txt

# Infinite loop with break
while true; do
    echo "Running..."
    read -p "Continue? (y/n) " answer
    if [[ $answer == "n" ]]; then
        break
    fi
done

# Wait for condition
while [[ ! -f /tmp/ready.flag ]]; do
    echo "Waiting..."
    sleep 1
done
```

### Reading Input

```bash
# Read from user
while read -p "Enter name (or 'quit'): " name; do
    if [[ $name == "quit" ]]; then
        break
    fi
    echo "Hello, $name"
done

# Read from command output
find . -name "*.txt" | while read -r file; do
    echo "Found: $file"
done
```

---

## until Loops

Execute until condition becomes true (opposite of while).

### Syntax

```bash
until condition; do
    # commands
done
```

### Examples

```bash
# Wait until file exists
until [[ -f /tmp/done.flag ]]; do
    echo "Waiting for file..."
    sleep 5
done

# Counter
COUNT=0
until [[ $COUNT -ge 5 ]]; do
    echo "Count: $COUNT"
    ((COUNT++))
done
```

---

## Loop Control

### break

Exit the loop:

```bash
for i in {1..10}; do
    if [[ $i -eq 5 ]]; then
        break
    fi
    echo "$i"
done
# Output: 1 2 3 4
```

### continue

Skip to next iteration:

```bash
for i in {1..5}; do
    if [[ $i -eq 3 ]]; then
        continue
    fi
    echo "$i"
done
# Output: 1 2 4 5
```

### break/continue with Nested Loops

```bash
# Break outer loop
for i in {1..3}; do
    for j in {1..3}; do
        if [[ $j -eq 2 ]]; then
            break 2    # Break out of both loops
        fi
        echo "$i-$j"
    done
done
```

---

## Practical Examples

### Menu System

```bash
#!/bin/bash

while true; do
    echo "=== Menu ==="
    echo "1. Show date"
    echo "2. Show users"
    echo "3. Show disk usage"
    echo "4. Exit"
    read -p "Choice: " choice
    
    case $choice in
        1) date ;;
        2) who ;;
        3) df -h ;;
        4) echo "Goodbye!"; exit 0 ;;
        *) echo "Invalid option" ;;
    esac
    echo
done
```

### File Processing

```bash
#!/bin/bash

# Process all .txt files
for file in *.txt; do
    if [[ -f "$file" ]]; then
        lines=$(wc -l < "$file")
        echo "$file: $lines lines"
    fi
done
```

### Argument Processing

```bash
#!/bin/bash

while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            echo "Usage: $0 [-v] [-o file] input"
            exit 0
            ;;
        -v|--verbose)
            VERBOSE=true
            shift
            ;;
        -o|--output)
            OUTPUT="$2"
            shift 2
            ;;
        *)
            INPUT="$1"
            shift
            ;;
    esac
done
```

---

## 🏋️ Practice Exercises

1. Write a script that checks if a file exists and is readable
2. Write a script that uses case to respond to yes/no/maybe
3. Write a for loop that prints numbers 1-10
4. Write a while loop that counts down from 5
5. Write a script that processes command line arguments

### Solutions

```bash
# Exercise 1
#!/bin/bash
FILE=$1
if [[ -f "$FILE" && -r "$FILE" ]]; then
    echo "File exists and is readable"
else
    echo "File doesn't exist or isn't readable"
fi

# Exercise 2
#!/bin/bash
read -p "Answer (yes/no/maybe): " answer
case $answer in
    yes|YES|y|Y) echo "Affirmative!" ;;
    no|NO|n|N)   echo "Negative!" ;;
    maybe|MAYBE) echo "Uncertain!" ;;
    *)           echo "Unknown response" ;;
esac

# Exercise 3
#!/bin/bash
for i in {1..10}; do
    echo $i
done

# Exercise 4
#!/bin/bash
count=5
while [[ $count -gt 0 ]]; do
    echo $count
    ((count--))
done
echo "Blast off!"

# Exercise 5
#!/bin/bash
while [[ $# -gt 0 ]]; do
    echo "Argument: $1"
    shift
done
```

---

## 🔗 Next Topic

Continue to [Functions](functions.md) →
