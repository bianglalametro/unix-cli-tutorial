# Shell Scripting Basics

Learn variables, parameters, and command substitution.

## 📖 Table of Contents

- [Script Structure](#script-structure)
- [Variables](#variables)
- [Special Variables](#special-variables)
- [Command Substitution](#command-substitution)
- [Arithmetic](#arithmetic)
- [Arrays](#arrays)
- [Quoting](#quoting)

---

## Script Structure

### The Shebang

Every script should start with a shebang:

```bash
#!/bin/bash
```

This tells the system which interpreter to use.

### Shebang Variations

```bash
#!/bin/bash          # Bash explicitly
#!/bin/sh            # POSIX shell (may not be bash)
#!/usr/bin/env bash  # Find bash in PATH (more portable)
```

### Script Template

```bash
#!/bin/bash
#
# Script: example.sh
# Description: Brief description
# Usage: ./example.sh [options] [arguments]
#

# Safety options
set -euo pipefail

# Constants
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly SCRIPT_NAME="$(basename "$0")"

# Main function
main() {
    echo "Hello from $SCRIPT_NAME"
}

# Run main with all arguments
main "$@"
```

### Making Scripts Executable

```bash
# Add execute permission
$ chmod +x script.sh

# Run it
$ ./script.sh

# Or run without execute permission
$ bash script.sh
```

---

## Variables

### Variable Assignment

```bash
# No spaces around the =
NAME="John"
COUNT=10
FILE_PATH=/home/user/file.txt

# Wrong! (spaces cause errors)
NAME = "John"    # Error: command not found
```

### Using Variables

```bash
# Basic usage
echo $NAME

# Curly braces (recommended)
echo ${NAME}

# In strings
echo "Hello, $NAME"
echo "Hello, ${NAME}!"

# Curly braces required for:
echo "${NAME}_backup"    # Without braces, looks for $NAME_backup
echo "Count: ${COUNT}0"  # Append 0 to value
```

### Default Values

```bash
# Use default if unset
echo ${NAME:-default}     # Use "default" if NAME is unset
echo ${NAME:=default}     # Set to "default" if NAME is unset

# Use alternative if set
echo ${NAME:+alternative} # Use "alternative" if NAME is set

# Error if unset
echo ${NAME:?error message}  # Exit with error if NAME is unset
```

### String Operations

```bash
NAME="Hello World"

# Length
echo ${#NAME}            # 11

# Substring
echo ${NAME:0:5}         # Hello (start:length)
echo ${NAME:6}           # World (from position 6)

# Replacement
echo ${NAME/World/Earth}     # Hello Earth (first match)
echo ${NAME//o/0}            # Hell0 W0rld (all matches)

# Remove pattern
FILE="document.txt.bak"
echo ${FILE%.bak}        # document.txt (remove suffix)
echo ${FILE%.*}          # document.txt (remove last extension)
echo ${FILE%%.*}         # document (remove all extensions)
echo ${FILE#*.}          # txt.bak (remove prefix)
echo ${FILE##*.}         # bak (remove longest prefix)
```

### Variable Scope

```bash
# Global (default)
GLOBAL_VAR="I'm global"

# Local (inside functions)
my_function() {
    local LOCAL_VAR="I'm local"
    echo "$LOCAL_VAR"
}

# Export (available to child processes)
export EXPORTED_VAR="I'm exported"
```

---

## Special Variables

### Positional Parameters

```bash
#!/bin/bash
# script.sh

echo "Script name: $0"
echo "First argument: $1"
echo "Second argument: $2"
echo "All arguments: $@"
echo "All as single string: $*"
echo "Number of arguments: $#"
```

```bash
$ ./script.sh hello world
Script name: ./script.sh
First argument: hello
Second argument: world
All arguments: hello world
All as single string: hello world
Number of arguments: 2
```

### Special Variables Table

| Variable | Description |
|----------|-------------|
| `$0` | Script name |
| `$1-$9` | Positional parameters 1-9 |
| `${10}` | Parameter 10+ (need braces) |
| `$#` | Number of parameters |
| `$@` | All parameters (separate words) |
| `$*` | All parameters (single word) |
| `$?` | Exit status of last command |
| `$$` | Current process ID |
| `$!` | PID of last background job |
| `$_` | Last argument of previous command |

### $@ vs $*

```bash
#!/bin/bash
# Understanding the difference

echo "Using \$@:"
for arg in "$@"; do
    echo "  $arg"
done

echo "Using \$*:"
for arg in "$*"; do
    echo "  $arg"
done
```

```bash
$ ./script.sh "hello world" foo
Using $@:
  hello world
  foo
Using $*:
  hello world foo
```

---

## Command Substitution

Run a command and capture its output.

### Syntax

```bash
# Modern syntax (preferred)
RESULT=$(command)

# Old syntax (backticks)
RESULT=`command`
```

### Examples

```bash
# Get current date
TODAY=$(date +%Y-%m-%d)
echo "Today is $TODAY"

# Count files
FILE_COUNT=$(ls -1 | wc -l)
echo "There are $FILE_COUNT files"

# Get hostname
HOST=$(hostname)

# Nested substitution (easier with $())
OWNER=$(stat -c %U $(which bash))
```

### Process Substitution

Treat command output as a file:

```bash
# Compare outputs of two commands
diff <(ls dir1) <(ls dir2)

# Read from process
while read line; do
    echo "Line: $line"
done < <(cat file.txt)
```

---

## Arithmetic

### Arithmetic Expansion

```bash
# Using $(( ))
echo $((5 + 3))       # 8
echo $((10 - 4))      # 6
echo $((3 * 4))       # 12
echo $((20 / 4))      # 5
echo $((17 % 5))      # 2 (modulo)
echo $((2 ** 3))      # 8 (exponent)

# With variables
A=10
B=3
echo $((A + B))       # 13
echo $((A / B))       # 3 (integer division)
```

### Increment/Decrement

```bash
COUNT=0
((COUNT++))           # Increment
((COUNT--))           # Decrement
((COUNT += 5))        # Add 5
((COUNT *= 2))        # Multiply by 2
```

### let Command

```bash
let "A = 5 + 3"
let "B = A * 2"
let "A++"
```

### bc for Floating Point

```bash
# Bash only does integers
# Use bc for decimals

RESULT=$(echo "scale=2; 10 / 3" | bc)
echo $RESULT          # 3.33

RESULT=$(bc <<< "scale=4; 22/7")
echo $RESULT          # 3.1428
```

---

## Arrays

### Indexed Arrays

```bash
# Declaration
FRUITS=("apple" "banana" "cherry")

# Access elements
echo ${FRUITS[0]}     # apple
echo ${FRUITS[1]}     # banana

# All elements
echo ${FRUITS[@]}     # apple banana cherry
echo ${FRUITS[*]}     # apple banana cherry

# Array length
echo ${#FRUITS[@]}    # 3

# Add element
FRUITS+=("date")

# Iterate
for fruit in "${FRUITS[@]}"; do
    echo "$fruit"
done
```

### Associative Arrays (Bash 4+)

```bash
# Declare
declare -A COLORS

# Assign
COLORS[red]="#FF0000"
COLORS[green]="#00FF00"
COLORS[blue]="#0000FF"

# Access
echo ${COLORS[red]}   # #FF0000

# All keys
echo ${!COLORS[@]}    # red green blue

# All values
echo ${COLORS[@]}     # #FF0000 #00FF00 #0000FF
```

---

## Quoting

Understanding quotes is crucial.

### Types of Quotes

| Quote | Behavior |
|-------|----------|
| `'single'` | Literal - no expansion |
| `"double"` | Variables and commands expand |
| `` `backticks` `` | Command substitution (old style) |
| `$'...'` | Escape sequences |

### Examples

```bash
NAME="World"

# Single quotes - literal
echo 'Hello $NAME'        # Hello $NAME

# Double quotes - expansion
echo "Hello $NAME"        # Hello World

# Escape within double quotes
echo "She said \"Hello\"" # She said "Hello"
echo "Cost: \$100"        # Cost: $100

# ANSI-C quoting
echo $'Line1\nLine2'      # Two lines
echo $'\t Tabbed'         # Tab character
```

### When to Quote

```bash
# Always quote variables!
FILE="my file.txt"
cat "$FILE"               # Correct
cat $FILE                 # Error: 'my' and 'file.txt' as separate args

# Quote command substitution
FILES="$(ls)"
for f in "$FILES"; do     # Treats as single item
    echo "$f"
done
```

---

## 🏋️ Practice Exercises

1. Create a script that prints your username and home directory
2. Create a script that takes a name as argument and greets them
3. Create a script that counts files in the current directory
4. Create a script that calculates the sum of two numbers
5. Create an array of colors and print each one

### Solutions

```bash
# Exercise 1
#!/bin/bash
echo "Username: $USER"
echo "Home: $HOME"

# Exercise 2
#!/bin/bash
NAME=${1:-"World"}
echo "Hello, $NAME!"

# Exercise 3
#!/bin/bash
COUNT=$(ls -1 | wc -l)
echo "Files in $(pwd): $COUNT"

# Exercise 4
#!/bin/bash
A=${1:-0}
B=${2:-0}
SUM=$((A + B))
echo "$A + $B = $SUM"

# Exercise 5
#!/bin/bash
COLORS=("red" "green" "blue" "yellow")
for color in "${COLORS[@]}"; do
    echo "Color: $color"
done
```

---

## 🔗 Next Topic

Continue to [Control Flow](control-flow.md) →
