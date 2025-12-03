# Basic Commands

Learn the essential commands every CLI user should know.

## 📖 Table of Contents

- [echo - Display Text](#echo---display-text)
- [date - Display Date and Time](#date---display-date-and-time)
- [cal - Display Calendar](#cal---display-calendar)
- [hostname - Display System Name](#hostname---display-system-name)
- [uname - System Information](#uname---system-information)
- [clear - Clear Screen](#clear---clear-screen)
- [history - Command History](#history---command-history)
- [exit - Exit Shell](#exit---exit-shell)

---

## echo - Display Text

The `echo` command displays text or variable values to the terminal.

### Syntax
```bash
echo [options] [string...]
```

### Common Options

| Option | Description |
|--------|-------------|
| `-n` | Don't print trailing newline |
| `-e` | Enable interpretation of escape sequences |

### Examples

```bash
# Simple message
$ echo "Hello, World!"
Hello, World!

# Print without newline
$ echo -n "Loading..."
Loading...$  # Notice cursor stays on same line

# Using escape sequences
$ echo -e "Line 1\nLine 2\nLine 3"
Line 1
Line 2
Line 3

# Tab characters
$ echo -e "Name:\tJohn\nAge:\t25"
Name:	John
Age:	25

# Display environment variables
$ echo $HOME
/home/user

$ echo $USER
user

$ echo "Your shell is: $SHELL"
Your shell is: /bin/bash
```

### Escape Sequences (with -e)

| Sequence | Description |
|----------|-------------|
| `\n` | Newline |
| `\t` | Tab |
| `\a` | Alert (bell) |
| `\\` | Backslash |
| `\b` | Backspace |

### 💡 Tip: Quotes Matter

```bash
# Single quotes: literal text
$ echo '$HOME'
$HOME

# Double quotes: variables expand
$ echo "$HOME"
/home/user
```

---

## date - Display Date and Time

The `date` command displays or sets the system date and time.

### Syntax
```bash
date [options] [+format]
```

### Basic Usage

```bash
$ date
Wed Dec  3 08:30:00 UTC 2024

# Custom format
$ date "+%Y-%m-%d"
2024-12-03

$ date "+%H:%M:%S"
08:30:00

$ date "+%A, %B %d, %Y"
Wednesday, December 03, 2024
```

### Format Specifiers

| Specifier | Description | Example |
|-----------|-------------|---------|
| `%Y` | Year (4 digits) | 2024 |
| `%y` | Year (2 digits) | 24 |
| `%m` | Month (01-12) | 12 |
| `%B` | Month name | December |
| `%b` | Month abbrev | Dec |
| `%d` | Day of month | 03 |
| `%A` | Weekday name | Wednesday |
| `%a` | Weekday abbrev | Wed |
| `%H` | Hour (24h) | 08 |
| `%I` | Hour (12h) | 08 |
| `%M` | Minute | 30 |
| `%S` | Second | 00 |
| `%p` | AM/PM | AM |
| `%Z` | Timezone | UTC |

### Practical Examples

```bash
# Create timestamped filename
$ echo "backup_$(date +%Y%m%d_%H%M%S).tar.gz"
backup_20241203_083000.tar.gz

# Log entry format
$ echo "[$(date '+%Y-%m-%d %H:%M:%S')] Task completed"
[2024-12-03 08:30:00] Task completed

# Show seconds since epoch (Unix timestamp)
$ date +%s
1733218200
```

---

## cal - Display Calendar

The `cal` command displays a calendar.

### Syntax
```bash
cal [options] [[month] year]
```

### Examples

```bash
# Current month
$ cal
   December 2024
Su Mo Tu We Th Fr Sa
 1  2  3  4  5  6  7
 8  9 10 11 12 13 14
15 16 17 18 19 20 21
22 23 24 25 26 27 28
29 30 31

# Specific month and year
$ cal 7 2024
     July 2024
Su Mo Tu We Th Fr Sa
    1  2  3  4  5  6
 7  8  9 10 11 12 13
14 15 16 17 18 19 20
21 22 23 24 25 26 27
28 29 30 31

# Entire year
$ cal 2024

# Three-month view (previous, current, next)
$ cal -3
```

### Options

| Option | Description |
|--------|-------------|
| `-3` | Show 3 months |
| `-y` | Show entire year |
| `-m` | Start week on Monday |
| `-j` | Show Julian days |

---

## hostname - Display System Name

The `hostname` command displays or sets the system's hostname.

### Syntax
```bash
hostname [options]
```

### Examples

```bash
# Display hostname
$ hostname
my-computer

# Display domain name
$ hostname -d
example.com

# Display fully qualified domain name
$ hostname -f
my-computer.example.com

# Display IP address
$ hostname -I
192.168.1.100
```

---

## uname - System Information

The `uname` command displays system information.

### Syntax
```bash
uname [options]
```

### Options

| Option | Description |
|--------|-------------|
| `-a` | All information |
| `-s` | Kernel name |
| `-n` | Network hostname |
| `-r` | Kernel release |
| `-v` | Kernel version |
| `-m` | Machine hardware |
| `-o` | Operating system |

### Examples

```bash
# Kernel name
$ uname -s
Linux

# All information
$ uname -a
Linux my-computer 5.15.0-generic #1 SMP x86_64 GNU/Linux

# Kernel version
$ uname -r
5.15.0-generic

# Machine architecture
$ uname -m
x86_64

# Operating system
$ uname -o
GNU/Linux
```

---

## clear - Clear Screen

The `clear` command clears the terminal screen.

### Usage

```bash
$ clear
```

### 💡 Keyboard Shortcut

Press `Ctrl + L` for the same effect!

---

## history - Command History

The `history` command displays previously executed commands.

### Syntax
```bash
history [options] [n]
```

### Examples

```bash
# Show all history
$ history

# Show last 10 commands
$ history 10

# Execute command #42 from history
$ !42

# Execute the last command
$ !!

# Execute last command starting with 'ls'
$ !ls

# Search history
$ history | grep "pattern"
```

### 💡 Tips

- Press `↑` and `↓` to navigate history
- Press `Ctrl + R` to search history interactively
- History is saved in `~/.bash_history`

---

## exit - Exit Shell

The `exit` command terminates the current shell session.

### Usage

```bash
$ exit

# Exit with specific status code
$ exit 0    # Success
$ exit 1    # General error
```

### 💡 Keyboard Shortcut

Press `Ctrl + D` to exit the shell (sends EOF).

---

## 🏋️ Practice Exercises

1. Display your username using `echo` and the `$USER` variable
2. Show today's date in the format: "Day, Month DD, YYYY"
3. Display the calendar for your birth month and year
4. Find your computer's hostname and kernel version
5. Create a welcome message that includes:
   - Your username
   - Current date
   - Your hostname

### Solution Hint

```bash
# Exercise 5
echo "Welcome, $USER!"
echo "Today is $(date '+%A, %B %d, %Y')"
echo "You are on $(hostname)"
```

---

## 🔗 Next Topic

Continue to [User Management](user-management.md) →
