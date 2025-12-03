# 📜 Shell Scripting Cheatsheet

> Quick reference for Bash shell scripting

---

## 🚀 Script Basics

### Shebang

```bash
#!/bin/bash          # Bash script
#!/usr/bin/env bash  # More portable
#!/bin/sh            # POSIX shell
```

### Running Scripts

```bash
# Make executable and run
chmod +x script.sh
./script.sh

# Run with bash
bash script.sh

# Run with source (in current shell)
source script.sh
. script.sh
```

---

## 📊 Variables

### Declaration and Assignment

```bash
# No spaces around =
name="John"
age=25
readonly CONSTANT="value"

# Command substitution
current_date=$(date)
current_date=`date`

# Arithmetic
count=$((count + 1))
result=$((5 * 3))
```

### Using Variables

```bash
echo $name
echo ${name}
echo "${name}_suffix"

# Default values
echo ${var:-default}      # Use default if unset
echo ${var:=default}      # Set and use default if unset
echo ${var:+alternate}    # Use alternate if set
echo ${var:?error msg}    # Error if unset
```

### String Operations

```bash
str="Hello World"

# Length
echo ${#str}              # 11

# Substring
echo ${str:0:5}           # Hello
echo ${str:6}             # World

# Replace
echo ${str/World/Universe}   # Hello Universe
echo ${str//o/0}             # Hell0 W0rld

# Remove pattern
echo ${str#Hello }        # World (from start)
echo ${str%World}         # Hello (from end)

# Case conversion (Bash 4+)
echo ${str^^}             # HELLO WORLD
echo ${str,,}             # hello world
```

---

## 🎯 Special Variables

| Variable | Description |
|----------|-------------|
| `$0` | Script name |
| `$1` - `$9` | Positional parameters |
| `${10}` | 10th parameter and beyond |
| `$#` | Number of parameters |
| `$*` | All parameters as single string |
| `$@` | All parameters as separate strings |
| `$?` | Exit status of last command |
| `$$` | Current process ID |
| `$!` | PID of last background command |
| `$_` | Last argument of previous command |

```bash
echo "Script: $0"
echo "First arg: $1"
echo "All args: $@"
echo "Arg count: $#"
echo "Exit status: $?"
```

---

## 📥 Input/Output

### Reading Input

```bash
# Basic read
read name
echo "Hello, $name"

# With prompt
read -p "Enter name: " name

# Silent input (passwords)
read -sp "Password: " pass

# With timeout
read -t 5 -p "Quick! " answer

# Read into array
read -a array
```

### Output

```bash
# Print
echo "Hello"
printf "Name: %s, Age: %d\n" "$name" "$age"

# Redirect
echo "text" > file.txt      # Overwrite
echo "text" >> file.txt     # Append

# Error output
echo "Error" >&2

# Both stdout and stderr
command > output.txt 2>&1
command &> output.txt       # Bash shorthand
```

---

## 🔀 Conditionals

### If Statement

```bash
if [ condition ]; then
    commands
elif [ condition ]; then
    commands
else
    commands
fi
```

### Test Conditions

#### String Comparisons

```bash
[ "$str1" = "$str2" ]     # Equal
[ "$str1" != "$str2" ]    # Not equal
[ -z "$str" ]             # Empty/zero length
[ -n "$str" ]             # Not empty
```

#### Numeric Comparisons

```bash
[ "$a" -eq "$b" ]         # Equal
[ "$a" -ne "$b" ]         # Not equal
[ "$a" -lt "$b" ]         # Less than
[ "$a" -le "$b" ]         # Less than or equal
[ "$a" -gt "$b" ]         # Greater than
[ "$a" -ge "$b" ]         # Greater than or equal
```

#### File Tests

```bash
[ -e "$file" ]            # Exists
[ -f "$file" ]            # Is regular file
[ -d "$dir" ]             # Is directory
[ -r "$file" ]            # Is readable
[ -w "$file" ]            # Is writable
[ -x "$file" ]            # Is executable
[ -s "$file" ]            # Size > 0
[ -L "$file" ]            # Is symlink
[ "$f1" -nt "$f2" ]       # f1 newer than f2
[ "$f1" -ot "$f2" ]       # f1 older than f2
```

#### Logical Operators

```bash
[ cond1 ] && [ cond2 ]    # AND
[ cond1 ] || [ cond2 ]    # OR
[ ! condition ]           # NOT

# Inside [[ ]]
[[ cond1 && cond2 ]]
[[ cond1 || cond2 ]]
```

### Double Brackets [[ ]]

```bash
# Supports pattern matching
[[ "$str" == pattern* ]]

# Supports regex
[[ "$str" =~ ^[0-9]+$ ]]

# Safer with unquoted variables
[[ $var == "value" ]]
```

### Case Statement

```bash
case "$var" in
    pattern1)
        commands
        ;;
    pattern2|pattern3)
        commands
        ;;
    *)
        default commands
        ;;
esac
```

---

## 🔄 Loops

### For Loop

```bash
# List iteration
for item in item1 item2 item3; do
    echo "$item"
done

# Range
for i in {1..5}; do
    echo "$i"
done

# C-style
for ((i=0; i<5; i++)); do
    echo "$i"
done

# Files
for file in *.txt; do
    echo "$file"
done

# Array
for item in "${array[@]}"; do
    echo "$item"
done
```

### While Loop

```bash
# Basic
while [ condition ]; do
    commands
done

# Counter
count=0
while [ $count -lt 5 ]; do
    echo $count
    ((count++))
done

# Read lines from file
while IFS= read -r line; do
    echo "$line"
done < file.txt

# Infinite loop
while true; do
    commands
done
```

### Until Loop

```bash
# Execute until condition is true
until [ condition ]; do
    commands
done
```

### Loop Control

```bash
break       # Exit loop
continue    # Skip to next iteration
break 2     # Exit 2 levels
```

---

## 📦 Arrays

### Declaration

```bash
# Indexed array
arr=(one two three)
arr[0]="first"
declare -a arr

# Associative array (Bash 4+)
declare -A assoc
assoc[key]="value"
assoc=([key1]=val1 [key2]=val2)
```

### Array Operations

```bash
arr=(one two three four)

# Access
echo ${arr[0]}            # First element
echo ${arr[-1]}           # Last element (Bash 4.3+)
echo ${arr[@]}            # All elements
echo ${arr[*]}            # All as single string

# Length
echo ${#arr[@]}           # Number of elements
echo ${#arr[0]}           # Length of first element

# Slice
echo ${arr[@]:1:2}        # Elements 1-2

# Add element
arr+=(five)
arr[4]="five"

# Delete element
unset arr[1]

# Loop
for item in "${arr[@]}"; do
    echo "$item"
done
```

---

## 🔧 Functions

### Definition

```bash
# Method 1
function_name() {
    commands
}

# Method 2
function function_name {
    commands
}
```

### Parameters and Return

```bash
greet() {
    local name="$1"       # Local variable
    echo "Hello, $name"
    return 0              # Exit status
}

# Call function
greet "John"

# Capture output
result=$(greet "John")

# Check return status
if greet "John"; then
    echo "Success"
fi
```

### Local Variables

```bash
my_func() {
    local var="local value"
    global_var="global value"
}
```

---

## 🛡️ Error Handling

### Exit Status

```bash
# Check last command
if [ $? -eq 0 ]; then
    echo "Success"
else
    echo "Failed"
fi

# Inline check
command && echo "Success" || echo "Failed"

# Exit with status
exit 0    # Success
exit 1    # Error
```

### Set Options

```bash
set -e        # Exit on error
set -u        # Error on undefined variable
set -o pipefail  # Pipeline error propagation
set -x        # Debug mode (print commands)

# Common combination
set -euo pipefail

# Disable
set +e
```

### Trap

```bash
# Cleanup on exit
cleanup() {
    rm -f "$temp_file"
}
trap cleanup EXIT

# Handle signals
trap "echo 'Interrupted'; exit" INT TERM

# Ignore signal
trap '' SIGINT
```

---

## 📋 Common Patterns

### Argument Parsing

```bash
# Simple
while [ $# -gt 0 ]; do
    case "$1" in
        -h|--help)
            show_help
            exit 0
            ;;
        -v|--verbose)
            verbose=true
            ;;
        -f|--file)
            file="$2"
            shift
            ;;
        *)
            echo "Unknown: $1"
            exit 1
            ;;
    esac
    shift
done
```

### getopts

```bash
while getopts "hvf:" opt; do
    case $opt in
        h) show_help; exit 0 ;;
        v) verbose=true ;;
        f) file="$OPTARG" ;;
        ?) exit 1 ;;
    esac
done
shift $((OPTIND - 1))
```

### Temporary Files

```bash
temp_file=$(mktemp)
temp_dir=$(mktemp -d)

# Cleanup
trap "rm -f $temp_file; rm -rf $temp_dir" EXIT
```

### Check Dependencies

```bash
command -v git >/dev/null 2>&1 || {
    echo "git required"
    exit 1
}

# Or
if ! command -v git &>/dev/null; then
    echo "git not found"
    exit 1
fi
```

### Script Directory

```bash
# Get script's directory
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
```

---

## 📝 Arithmetic

### Methods

```bash
# $(( ))
result=$((5 + 3))
((count++))
((a = b + c))

# let
let "result = 5 + 3"
let count++

# expr (legacy)
result=$(expr 5 + 3)

# bc (floating point)
result=$(echo "5.5 + 3.2" | bc)
```

### Operators

| Operator | Description |
|----------|-------------|
| `+` | Addition |
| `-` | Subtraction |
| `*` | Multiplication |
| `/` | Division |
| `%` | Modulo |
| `**` | Exponentiation |
| `++` | Increment |
| `--` | Decrement |

---

## 🎨 Text Formatting

### Colors

```bash
# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'  # No Color

echo -e "${RED}Error${NC}"
echo -e "${GREEN}Success${NC}"
```

### tput

```bash
# Using tput
bold=$(tput bold)
normal=$(tput sgr0)
red=$(tput setaf 1)

echo "${bold}Bold text${normal}"
echo "${red}Red text${normal}"
```

---

## 💡 Best Practices

```bash
#!/bin/bash
set -euo pipefail

# Always quote variables
echo "$var"

# Use [[ ]] instead of [ ]
[[ -f "$file" ]]

# Use $() instead of backticks
result=$(command)

# Check if running as root
if [[ $EUID -ne 0 ]]; then
    echo "Must run as root"
    exit 1
fi

# Use functions for organization
main() {
    # Main logic here
}

main "$@"
```

---

## 🔗 Useful One-Liners

```bash
# Process each line of file
while IFS= read -r line; do echo "$line"; done < file.txt

# Find and process files
find . -name "*.txt" -exec command {} \;

# Parallel execution
for f in *.txt; do process "$f" & done; wait

# Check if variable is set
[[ -v varname ]]

# Default value
: ${var:=default}

# Check if array is empty
[[ ${#arr[@]} -eq 0 ]]

# Check if running interactively
[[ $- == *i* ]]
```

---

## 📁 File Operations

### Reading Files

```bash
# Read entire file into variable
content=$(<file.txt)

# Read file line by line
while IFS= read -r line; do
    echo "$line"
done < file.txt

# Read with line number
while IFS= read -r line; do
    ((n++))
    echo "$n: $line"
done < file.txt

# Read fields from CSV
while IFS=',' read -r col1 col2 col3; do
    echo "Column 1: $col1"
done < file.csv

# Read into array
mapfile -t arr < file.txt
readarray -t arr < file.txt
```

### Writing Files

```bash
# Write to file
echo "content" > file.txt

# Append to file
echo "content" >> file.txt

# Here document
cat > file.txt << EOF
Line 1
Line 2
Line 3
EOF

# Here document with variable expansion disabled
cat > file.txt << 'EOF'
$variable is not expanded
EOF

# Here string
cat <<< "Single line"
```

---

## 🔀 Process Substitution

```bash
# Compare two command outputs
diff <(ls dir1) <(ls dir2)

# Process command output
while read -r line; do
    echo "$line"
done < <(find . -name "*.txt")

# Write to multiple files
echo "content" | tee >(cmd1) >(cmd2) > /dev/null
```

---

## 🧪 Debugging

```bash
# Debug entire script
bash -x script.sh

# Debug section of script
set -x
# commands to debug
set +x

# Print variable values
echo "DEBUG: var=$var" >&2

# Use PS4 for better trace output
export PS4='+(${BASH_SOURCE}:${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'

# Check syntax without running
bash -n script.sh

# Verbose mode
set -v

# Trace function calls
#!/bin/bash
set -euo pipefail
trap 'echo "Error on line $LINENO"' ERR
```

---

## 📦 Subshells and Command Groups

```bash
# Subshell (separate environment)
(cd /tmp && ls)
echo $PWD  # Still in original directory

# Command group (same environment)
{ cd /tmp; ls; }
echo $PWD  # Now in /tmp

# Capture subshell output
result=$(command)

# Background subshell
(long_running_command) &
```

---

## 🌐 Network Operations

```bash
# Download file
curl -O http://example.com/file.txt
wget http://example.com/file.txt

# Send HTTP request
curl -X POST -H "Content-Type: application/json" \
     -d '{"key":"value"}' http://api.example.com

# Check port availability
nc -zv hostname 80

# Simple HTTP server
python3 -m http.server 8080

# Get external IP
curl ifconfig.me
curl icanhazip.com
```

---

## 🎮 Interactive Menus

```bash
# Select menu
PS3="Choose an option: "
options=("Option 1" "Option 2" "Quit")
select opt in "${options[@]}"; do
    case $opt in
        "Option 1") echo "Selected 1" ;;
        "Option 2") echo "Selected 2" ;;
        "Quit") break ;;
        *) echo "Invalid option" ;;
    esac
done

# Yes/No prompt
read -p "Continue? [y/N] " answer
if [[ "$answer" =~ ^[Yy]$ ]]; then
    echo "Continuing..."
fi
```

---

## 📊 Data Processing

```bash
# JSON parsing (with jq)
curl -s api.example.com | jq '.data.name'

# CSV processing
awk -F',' '{print $1, $3}' file.csv

# XML processing (with xmllint)
xmllint --xpath "//element" file.xml

# Calculate statistics
awk '{sum+=$1; sq+=$1*$1} END {
    print "Mean:", sum/NR
    print "StdDev:", sqrt(sq/NR - (sum/NR)^2)
}' numbers.txt

# Frequency count
sort file.txt | uniq -c | sort -rn

# Top N items
sort file.txt | uniq -c | sort -rn | head -10
```

---

## 🔐 Security

```bash
# Generate random password
openssl rand -base64 32 | tr -d '/+=' | cut -c1-16

# Generate random string
cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 16

# Hash file
sha256sum file.txt
md5sum file.txt

# Encrypt file
openssl enc -aes-256-cbc -salt -in file.txt -out file.enc

# Decrypt file
openssl enc -aes-256-cbc -d -in file.enc -out file.txt

# Check if running as root
if [[ $EUID -ne 0 ]]; then
    echo "Must run as root"
    exit 1
fi
```

---

## 📋 Complete Script Template

```bash
#!/usr/bin/env bash
#
# Script: script_name.sh
# Description: Brief description
# Author: Your Name
# Date: YYYY-MM-DD
# Version: 1.0
#

set -euo pipefail
IFS=$'\n\t'

# Constants
readonly SCRIPT_NAME=$(basename "$0")
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Default values
verbose=false
output_file=""

# Usage function
usage() {
    cat << EOF
Usage: $SCRIPT_NAME [OPTIONS] <arguments>

Description of what this script does.

OPTIONS:
    -h, --help      Show this help message
    -v, --verbose   Enable verbose output
    -o, --output    Output file (default: stdout)

EXAMPLES:
    $SCRIPT_NAME input.txt
    $SCRIPT_NAME -v -o result.txt input.txt

EOF
}

# Logging functions
log() { echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*"; }
info() { log "INFO: $*"; }
warn() { log "WARN: $*" >&2; }
error() { log "ERROR: $*" >&2; }
die() { error "$*"; exit 1; }

# Cleanup function
cleanup() {
    # Cleanup code here
    [[ -f "$temp_file" ]] && rm -f "$temp_file"
}
trap cleanup EXIT

# Parse arguments
parse_args() {
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -h|--help)
                usage
                exit 0
                ;;
            -v|--verbose)
                verbose=true
                shift
                ;;
            -o|--output)
                output_file="$2"
                shift 2
                ;;
            --)
                shift
                break
                ;;
            -*)
                die "Unknown option: $1"
                ;;
            *)
                break
                ;;
        esac
    done
    
    # Remaining arguments
    args=("$@")
}

# Main function
main() {
    parse_args "$@"
    
    # Validate arguments
    [[ ${#args[@]} -eq 0 ]] && die "No arguments provided"
    
    # Your logic here
    for arg in "${args[@]}"; do
        $verbose && info "Processing: $arg"
        # Process each argument
    done
}

# Run main
main "$@"
```

---

**📖 Related Resources:**
- [Essential Commands Cheatsheet](essential-commands.md)
- [Shell Scripting Module](../06-shell-scripting/)
- [Shell Scripting Basics](../06-shell-scripting/basics.md)
