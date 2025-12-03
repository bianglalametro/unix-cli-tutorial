# Module 06: Shell Scripting

Learn to automate tasks with Bash scripts.

## 🎯 Learning Objectives

By the end of this module, you will be able to:
- Create and run shell scripts
- Use variables and command substitution
- Implement control flow (if, case, loops)
- Write and use functions
- Build practical automation scripts

## 📖 Topics Covered

| File | Description | Time |
|------|-------------|------|
| [basics.md](basics.md) | Variables, parameters, substitution | 30 min |
| [control-flow.md](control-flow.md) | Conditionals and loops | 35 min |
| [functions.md](functions.md) | Function definitions and usage | 25 min |
| [examples/](examples/) | Ready-to-use example scripts | 40 min |
| [exercises.md](exercises.md) | Practice exercises | 45 min |

## 🚀 Getting Started

### Your First Script

```bash
#!/bin/bash
# my_first_script.sh - My first shell script

echo "Hello, World!"
echo "Today is $(date)"
echo "You are: $USER"
```

### Running Scripts

```bash
# Method 1: Make executable
$ chmod +x script.sh
$ ./script.sh

# Method 2: Run with interpreter
$ bash script.sh

# Method 3: Source it (runs in current shell)
$ source script.sh
$ . script.sh
```

## 📋 Script Structure

```bash
#!/bin/bash
#
# Script: script_name.sh
# Description: What this script does
# Author: Your Name
# Date: YYYY-MM-DD
#

# Exit on error
set -e

# Variables
VARIABLE="value"

# Functions
function_name() {
    # Function body
    echo "Doing something"
}

# Main script
main() {
    function_name
    # More code
}

# Run main
main "$@"
```

## 🔧 Key Concepts

### Variables

```bash
# Assignment (no spaces!)
NAME="John"
COUNT=10

# Using variables
echo $NAME
echo ${NAME}
echo "Hello, $NAME"
```

### Command Substitution

```bash
# Modern syntax
TODAY=$(date)
FILES=$(ls *.txt)

# Old syntax (backticks)
TODAY=`date`
```

### Exit Codes

```bash
# Check last command's exit status
$ ls
$ echo $?    # 0 = success

$ ls nonexistent
$ echo $?    # Non-zero = failure
```

## 💡 Best Practices

1. **Always use shebang** - `#!/bin/bash` on first line
2. **Quote variables** - `"$variable"` prevents word splitting
3. **Use meaningful names** - `file_count` not `fc`
4. **Add comments** - Explain complex logic
5. **Check exit codes** - Handle errors properly
6. **Use `set -e`** - Exit on first error
7. **Use shellcheck** - Lint your scripts

## ⚠️ Common Mistakes

- Spaces around `=` in assignments
- Forgetting to quote variables
- Using `[ ]` instead of `[[ ]]`
- Not handling edge cases
- Ignoring exit codes
- Hard-coding values that should be variables

## 📁 Example Scripts

This module includes practical example scripts:

| Script | Description |
|--------|-------------|
| [backup.sh](examples/backup.sh) | Automated backup with timestamps |
| [system-info.sh](examples/system-info.sh) | Display system information |
| [file-organizer.sh](examples/file-organizer.sh) | Organize files by extension |
| [top-words.sh](examples/top-words.sh) | Find most frequent words |
| [monitor.sh](examples/monitor.sh) | Simple system monitoring |

## 🔗 Next Steps

Start with:
1. [Basics](basics.md) - Variables and fundamentals
2. [Control Flow](control-flow.md) - Conditionals and loops
3. [Functions](functions.md) - Modular code
4. [Examples](examples/) - Study working scripts

After completing this module, continue to:
- [Module 07: Advanced Topics](../07-advanced-topics/)

## 📚 Additional Resources

- [Bash Manual](https://www.gnu.org/software/bash/manual/)
- [ShellCheck](https://www.shellcheck.net/) - Script linter
- [Bash Hackers Wiki](https://wiki.bash-hackers.org/)
- [Google Shell Style Guide](https://google.github.io/styleguide/shellguide.html)
