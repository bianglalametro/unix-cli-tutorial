# Keyboard Shortcuts Reference

Master these keyboard shortcuts to dramatically increase your productivity in the terminal.

## 📖 Table of Contents

- [Navigation Shortcuts](#navigation-shortcuts)
- [Editing Shortcuts](#editing-shortcuts)
- [History Shortcuts](#history-shortcuts)
- [Process Control](#process-control)
- [Terminal Control](#terminal-control)
- [Tab Completion](#tab-completion)

---

## Navigation Shortcuts

Move around the command line quickly.

| Shortcut | Description |
|----------|-------------|
| `Ctrl + A` | Move to beginning of line |
| `Ctrl + E` | Move to end of line |
| `Ctrl + B` | Move back one character |
| `Ctrl + F` | Move forward one character |
| `Alt + B` | Move back one word |
| `Alt + F` | Move forward one word |
| `Ctrl + XX` | Toggle between start of line and current position |

### Visual Guide

```
$ This is a long command line example
  ^                                  ^
  |                                  |
Ctrl+A                            Ctrl+E
(beginning)                       (end)

$ This is a long command line example
       <---  Alt+B    Alt+F  --->
       (word back)    (word forward)
```

### 💡 Tip

These shortcuts work in many places:
- Bash and other shells (zsh, fish)
- Python interpreter
- Many text editors
- Some GUI text fields

---

## Editing Shortcuts

Edit text without reaching for arrow keys or backspace.

### Deleting Text

| Shortcut | Description |
|----------|-------------|
| `Ctrl + D` | Delete character under cursor |
| `Ctrl + H` | Delete character before cursor (backspace) |
| `Ctrl + W` | Delete word before cursor |
| `Alt + D` | Delete word after cursor |
| `Ctrl + K` | Delete from cursor to end of line |
| `Ctrl + U` | Delete from cursor to beginning of line |

### Transforming Text

| Shortcut | Description |
|----------|-------------|
| `Ctrl + T` | Swap current character with previous |
| `Alt + T` | Swap current word with previous |
| `Alt + U` | Uppercase from cursor to end of word |
| `Alt + L` | Lowercase from cursor to end of word |
| `Alt + C` | Capitalize word and move to next |

### Cut and Paste (Kill and Yank)

| Shortcut | Description |
|----------|-------------|
| `Ctrl + W` | Cut word before cursor |
| `Ctrl + K` | Cut from cursor to end of line |
| `Ctrl + U` | Cut from cursor to beginning of line |
| `Ctrl + Y` | Paste (yank) last cut text |
| `Alt + Y` | Cycle through previous cut texts |

### Example

```bash
$ echo "Hello World"
# Press Ctrl+A to go to beginning
# Press Alt+F twice to move past "echo" and "Hello"
# Press Alt+D to delete "World"
# Type "Universe"
$ echo "Hello Universe"
```

---

## History Shortcuts

Navigate and search your command history efficiently.

### Basic History Navigation

| Shortcut | Description |
|----------|-------------|
| `↑` / `Ctrl + P` | Previous command in history |
| `↓` / `Ctrl + N` | Next command in history |
| `Ctrl + R` | Reverse search history |
| `Ctrl + G` | Exit history search |
| `Ctrl + O` | Execute found command and fetch next |

### History Search (Ctrl + R)

This is one of the most powerful shortcuts!

```bash
$ _                        # Start typing
(reverse-i-search)`': _    # Press Ctrl+R

# Type part of the command you're looking for
(reverse-i-search)`git': git commit -m "Initial commit"
                   ^^^                ^^^^^^^^^^^^^^^
                   Your search        Matching command

# Press Ctrl+R again to find older matches
# Press Enter to execute
# Press Ctrl+G or Esc to cancel
# Press → to edit the command
```

### History Expansion

| Syntax | Description |
|--------|-------------|
| `!!` | Repeat last command |
| `!$` | Last argument of previous command |
| `!^` | First argument of previous command |
| `!*` | All arguments of previous command |
| `!n` | Execute command number n |
| `!-n` | Execute command n lines back |
| `!string` | Execute last command starting with string |

### Examples

```bash
$ mkdir new_directory
$ cd !$              # cd new_directory (uses last argument)

$ cat file1.txt file2.txt file3.txt
$ vim !$             # vim file3.txt

$ vim important_file.txt
$ sudo !!            # sudo vim important_file.txt

$ ls /very/long/path/to/directory
$ cd !$              # cd /very/long/path/to/directory
```

---

## Process Control

Control running processes and jobs.

| Shortcut | Description |
|----------|-------------|
| `Ctrl + C` | Interrupt (kill) current foreground process |
| `Ctrl + Z` | Suspend current foreground process |
| `Ctrl + D` | Send EOF (end of file) / Exit shell |
| `Ctrl + \` | Quit with core dump (SIGQUIT) |
| `Ctrl + S` | Stop output to screen |
| `Ctrl + Q` | Resume output to screen |

### Common Scenarios

```bash
# Running a long process
$ find / -name "*.log"
^C                    # Press Ctrl+C to stop it

# Suspend and resume
$ vim large_file.txt
^Z                    # Press Ctrl+Z to suspend
[1]+  Stopped         vim large_file.txt
$ fg                  # Resume vim in foreground

# Exit shell
$ bash               # Start new shell
$ exit               # or press Ctrl+D to exit back

# Screen frozen? Output stopped?
# Usually means Ctrl+S was pressed accidentally
^Q                   # Press Ctrl+Q to resume
```

### ⚠️ Warning: Ctrl + S

If your terminal appears frozen, you probably pressed `Ctrl + S` by accident. Press `Ctrl + Q` to unfreeze!

---

## Terminal Control

Control the terminal display.

| Shortcut | Description |
|----------|-------------|
| `Ctrl + L` | Clear screen (like `clear` command) |
| `Ctrl + S` | Stop output to screen |
| `Ctrl + Q` | Resume output to screen |
| `Shift + PgUp` | Scroll terminal up |
| `Shift + PgDn` | Scroll terminal down |

---

## Tab Completion

Tab completion saves keystrokes and prevents typos.

### Basic Completion

```bash
$ cd Doc<TAB>           # Completes to Documents/
$ cat REA<TAB>          # Completes to README.md
$ git com<TAB>          # Completes to commit
```

### Multiple Matches

```bash
$ cd D<TAB><TAB>        # Shows all directories starting with D
Desktop/    Documents/    Downloads/

$ git c<TAB><TAB>       # Shows all git commands starting with c
checkout    cherry-pick    clone    commit    config
```

### Advanced Completion

```bash
# Complete command options
$ ls --<TAB><TAB>
--all          --author       --color        --directory    ...

# Complete usernames
$ chown <TAB><TAB>
john    jane    root    www-data    ...

# Complete hostnames (from ssh config)
$ ssh <TAB><TAB>
server1    server2    production    staging
```

### 💡 Tips

- Press Tab once: completes if unique
- Press Tab twice: shows all possibilities
- Type more characters + Tab: narrows down matches

---

## Shortcuts Cheat Sheet

```
┌──────────────────────────────────────────────────────────┐
│                 ESSENTIAL SHORTCUTS                      │
├──────────────────────────────────────────────────────────┤
│  NAVIGATION                   │  EDITING                │
│  Ctrl+A  Beginning of line    │  Ctrl+W  Delete word    │
│  Ctrl+E  End of line          │  Ctrl+U  Delete to start│
│  Alt+B   Back one word        │  Ctrl+K  Delete to end  │
│  Alt+F   Forward one word     │  Ctrl+Y  Paste          │
├──────────────────────────────────────────────────────────┤
│  HISTORY                      │  PROCESS                │
│  Ctrl+R  Search history       │  Ctrl+C  Kill process   │
│  Ctrl+P  Previous command     │  Ctrl+Z  Suspend        │
│  !!      Repeat last command  │  Ctrl+D  Exit / EOF     │
│  !$      Last argument        │  Ctrl+L  Clear screen   │
└──────────────────────────────────────────────────────────┘
```

---

## 🏋️ Practice Exercises

Practice makes perfect! Try these exercises:

1. **Navigation**: Type a long command, then use shortcuts to move to the beginning and end
2. **Editing**: Type "echo Hello World", then delete "World" using shortcuts
3. **History**: Use `Ctrl + R` to find a previous command
4. **Suspend**: Start `top`, suspend it with `Ctrl + Z`, then resume with `fg`
5. **Tab Completion**: Navigate to a directory using only Tab completion

### Practice Commands

```bash
# Type this, then practice navigation
echo "This is a practice command for learning shortcuts"

# Type this, practice deleting words
rm -rf temporary_file_that_does_not_exist.txt

# Run a command, then use !! to repeat
date
!!

# Use history search
# Press Ctrl+R, type "echo", press Enter
```

---

## 🔧 Customization

### Show Current Keybindings

```bash
# List all readline bindings
bind -P

# List all bindings in inputrc format
bind -p
```

### Create Custom Bindings

Add to `~/.inputrc`:

```bash
# Example: Ctrl+J to clear screen
"\C-j": clear-screen

# Example: Alt+. to insert last argument (already default)
"\e.": yank-last-arg
```

---

## 🔗 Next Module

Continue to [Module 02: Files and Directories](../02-files-and-directories/) →
