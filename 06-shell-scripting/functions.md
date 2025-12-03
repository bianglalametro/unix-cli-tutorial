# Functions

Create reusable code blocks in your scripts.

## 📖 Table of Contents

- [Defining Functions](#defining-functions)
- [Function Parameters](#function-parameters)
- [Return Values](#return-values)
- [Local Variables](#local-variables)
- [Practical Examples](#practical-examples)

---

## Defining Functions

### Syntax Options

```bash
# Method 1: Classic
function_name() {
    commands
}

# Method 2: With 'function' keyword
function function_name {
    commands
}

# Method 3: Combined
function function_name() {
    commands
}
```

### Basic Example

```bash
#!/bin/bash

# Define function
greet() {
    echo "Hello, World!"
}

# Call function
greet
```

### Function Must Be Defined Before Use

```bash
# This works
greet() { echo "Hello"; }
greet

# This fails
# greet   # Error: command not found
# greet() { echo "Hello"; }
```

---

## Function Parameters

Functions receive arguments like scripts: `$1`, `$2`, etc.

### Accessing Parameters

```bash
greet() {
    local name=$1
    echo "Hello, $name!"
}

greet "Alice"    # Hello, Alice!
greet "Bob"      # Hello, Bob!
```

### All Parameter Variables

```bash
show_params() {
    echo "Function name: $0"     # Still the script name!
    echo "First param: $1"
    echo "Second param: $2"
    echo "All params: $@"
    echo "Param count: $#"
}

show_params "arg1" "arg2" "arg3"
```

### Default Values

```bash
greet() {
    local name=${1:-"World"}
    echo "Hello, $name!"
}

greet              # Hello, World!
greet "Alice"      # Hello, Alice!
```

### Variable Arguments

```bash
# Process all arguments
process_files() {
    for file in "$@"; do
        echo "Processing: $file"
    done
}

process_files file1.txt file2.txt file3.txt
```

---

## Return Values

### Exit Status

Functions return an exit status (0-255), not a value.

```bash
# Return success/failure
is_file() {
    if [[ -f "$1" ]]; then
        return 0    # Success
    else
        return 1    # Failure
    fi
}

if is_file "/etc/passwd"; then
    echo "File exists"
fi

# Check return value
is_file "/nonexistent"
echo "Exit status: $?"    # 1
```

### Returning Data

Use `echo` and command substitution to return data:

```bash
# Return via stdout
add() {
    local sum=$(( $1 + $2 ))
    echo $sum
}

result=$(add 5 3)
echo "5 + 3 = $result"    # 5 + 3 = 8
```

### Multiple Return Values

```bash
# Return multiple values
get_dimensions() {
    local width=1920
    local height=1080
    echo "$width $height"
}

# Capture into array
read -r width height <<< "$(get_dimensions)"
echo "Width: $width, Height: $height"

# Or use array
dimensions=($(get_dimensions))
echo "Width: ${dimensions[0]}, Height: ${dimensions[1]}"
```

### Return vs Echo

```bash
# Use return for status
is_valid() {
    [[ $1 -gt 0 ]] && return 0 || return 1
}

# Use echo for data
get_count() {
    echo 42
}

# Combined
process() {
    local result=$(some_calculation)
    if [[ $? -ne 0 ]]; then
        return 1
    fi
    echo "$result"
    return 0
}
```

---

## Local Variables

Use `local` to create function-scoped variables.

### Why Use Local?

```bash
# Without local - DANGEROUS
counter=0
increment() {
    counter=$((counter + 1))    # Modifies global!
}

# With local - SAFE
increment_safe() {
    local counter=0
    counter=$((counter + 1))
    echo $counter
}
```

### Local Examples

```bash
global_var="I'm global"

my_function() {
    local local_var="I'm local"
    local shadow_var="I shadow the global"
    
    echo "Inside function:"
    echo "  global_var: $global_var"
    echo "  local_var: $local_var"
}

my_function
echo "Outside function:"
echo "  global_var: $global_var"
echo "  local_var: $local_var"    # Empty - local vars don't exist here
```

### Declare vs Local

```bash
my_function() {
    local name="Alice"           # Local string
    local -i count=10            # Local integer
    local -a arr=(1 2 3)         # Local array
    local -A map                 # Local associative array
    local -r constant="value"    # Local readonly
}
```

---

## Practical Examples

### Logging Function

```bash
#!/bin/bash

# Logging levels
log() {
    local level=$1
    shift
    local message="$@"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] [$level] $message"
}

log_info() { log "INFO" "$@"; }
log_warn() { log "WARN" "$@"; }
log_error() { log "ERROR" "$@"; }

# Usage
log_info "Script started"
log_warn "Low disk space"
log_error "Failed to connect"
```

### Error Handling

```bash
#!/bin/bash

die() {
    local message=$1
    local code=${2:-1}
    echo "ERROR: $message" >&2
    exit $code
}

require_command() {
    command -v "$1" &> /dev/null || die "Required command not found: $1"
}

# Usage
require_command git
require_command docker
```

### Input Validation

```bash
#!/bin/bash

validate_email() {
    local email=$1
    if [[ $email =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
        return 0
    fi
    return 1
}

validate_number() {
    local num=$1
    [[ $num =~ ^[0-9]+$ ]]
}

# Usage
if validate_email "user@example.com"; then
    echo "Valid email"
fi

if validate_number "123"; then
    echo "Valid number"
fi
```

### File Operations

```bash
#!/bin/bash

backup_file() {
    local file=$1
    local backup="${file}.$(date +%Y%m%d_%H%M%S).bak"
    
    if [[ ! -f "$file" ]]; then
        echo "File not found: $file" >&2
        return 1
    fi
    
    cp "$file" "$backup" && echo "Backed up to: $backup"
}

ensure_dir() {
    local dir=$1
    if [[ ! -d "$dir" ]]; then
        mkdir -p "$dir"
        echo "Created directory: $dir"
    fi
}

# Usage
backup_file "/etc/hosts"
ensure_dir "/tmp/myapp/logs"
```

### Configuration Loader

```bash
#!/bin/bash

load_config() {
    local config_file=${1:-"config.cfg"}
    
    if [[ ! -f "$config_file" ]]; then
        echo "Config not found: $config_file" >&2
        return 1
    fi
    
    while IFS='=' read -r key value; do
        # Skip comments and empty lines
        [[ $key =~ ^#.*$ ]] && continue
        [[ -z $key ]] && continue
        
        # Export as environment variable
        export "$key=$value"
    done < "$config_file"
    
    return 0
}

# Usage
load_config "myapp.cfg"
echo "Database: $DB_HOST"
```

### Reusable Library

Create a library file `lib.sh`:

```bash
#!/bin/bash
# lib.sh - Reusable functions

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

print_success() { echo -e "${GREEN}✓ $@${NC}"; }
print_error() { echo -e "${RED}✗ $@${NC}" >&2; }

# Confirmation prompt
confirm() {
    local message=${1:-"Continue?"}
    read -p "$message [y/N] " response
    [[ $response =~ ^[Yy]$ ]]
}

# Progress indicator
spinner() {
    local pid=$1
    local delay=0.1
    local spinstr='|/-\'
    while ps -p $pid &>/dev/null; do
        for c in $(echo $spinstr | sed 's/./& /g'); do
            printf "\r[%c] Working..." "$c"
            sleep $delay
        done
    done
    printf "\r[✓] Done!     \n"
}
```

Use the library:

```bash
#!/bin/bash
source ./lib.sh

print_success "Starting process"

if confirm "Delete files?"; then
    sleep 5 &
    spinner $!
    print_success "Files deleted"
else
    print_error "Aborted"
fi
```

---

## Function Best Practices

1. **Always use `local`** for function variables
2. **Validate input** parameters
3. **Return meaningful exit codes**
4. **Document your functions**
5. **Keep functions focused** (single responsibility)
6. **Use descriptive names**

### Documentation Example

```bash
#######################################
# Sends an email notification.
# Globals:
#   SMTP_SERVER - the SMTP server address
# Arguments:
#   $1 - recipient email
#   $2 - subject
#   $3 - body
# Returns:
#   0 on success, 1 on failure
#######################################
send_notification() {
    local recipient=$1
    local subject=$2
    local body=$3
    
    [[ -z "$recipient" ]] && return 1
    
    # ... implementation
}
```

---

## 🏋️ Practice Exercises

1. Write a function that calculates the factorial of a number
2. Write a function that checks if a string is a palindrome
3. Write a function library for common file operations
4. Write a function that recursively processes directories

### Solutions

```bash
# Exercise 1 - Factorial
factorial() {
    local n=$1
    if [[ $n -le 1 ]]; then
        echo 1
    else
        local prev=$(factorial $((n - 1)))
        echo $((n * prev))
    fi
}
echo "5! = $(factorial 5)"  # 120

# Exercise 2 - Palindrome
is_palindrome() {
    local str=$1
    local reversed=$(echo "$str" | rev)
    [[ "$str" == "$reversed" ]]
}
is_palindrome "radar" && echo "Yes" || echo "No"

# Exercise 3 - File library
file_size() {
    [[ -f "$1" ]] && stat -c%s "$1" || echo 0
}

file_age_days() {
    local file=$1
    local now=$(date +%s)
    local file_time=$(stat -c%Y "$file")
    echo $(( (now - file_time) / 86400 ))
}

# Exercise 4 - Recursive directory
process_dir() {
    local dir=$1
    local depth=${2:-0}
    local indent=$(printf '%*s' $((depth * 2)) '')
    
    for item in "$dir"/*; do
        [[ -e "$item" ]] || continue
        echo "${indent}$(basename "$item")"
        if [[ -d "$item" ]]; then
            process_dir "$item" $((depth + 1))
        fi
    done
}
process_dir "/etc" | head -20
```

---

## 🔗 Next Topic

Explore [Example Scripts](examples/) →
