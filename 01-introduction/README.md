# Module 01: Introduction to the Command Line

Welcome to the first module of the UNIX/Linux Command Line Tutorial! In this module, you'll learn the fundamentals of working with the terminal.

## 🎯 Learning Objectives

By the end of this module, you will be able to:
- Understand what the command line is and why it's powerful
- Execute basic commands like `echo`, `date`, and `cal`
- Identify your user and understand user management
- Communicate with other users on the system
- Use keyboard shortcuts to work more efficiently

## 📖 Topics Covered

| File | Description | Time |
|------|-------------|------|
| [basic-commands.md](basic-commands.md) | Essential first commands | 15 min |
| [user-management.md](user-management.md) | User identity and passwords | 10 min |
| [communication.md](communication.md) | User-to-user communication | 10 min |
| [shortcuts.md](shortcuts.md) | Keyboard shortcuts reference | 15 min |

## 🖥️ What is the Command Line?

The **command line interface (CLI)** is a text-based way to interact with your computer. Instead of clicking icons and menus, you type commands.

```
┌─────────────────────────────────────────────────────────────┐
│  Terminal Window                                      _ □ X │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  user@hostname:~$ _                                         │
│                                                             │
│  ↑                                                          │
│  This is the command prompt                                 │
│  - user: your username                                      │
│  - hostname: your computer's name                           │
│  - ~: your current directory (home)                         │
│  - $: regular user (# for root)                             │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### Why Use the Command Line?

| Advantage | Description |
|-----------|-------------|
| **Speed** | Type faster than clicking through menus |
| **Power** | Access features not available in GUIs |
| **Automation** | Create scripts to repeat tasks |
| **Remote Access** | Control servers over the network |
| **Precision** | Fine-grained control over operations |

## 🔧 Opening a Terminal

### Linux
- **Ubuntu/Debian**: Press `Ctrl + Alt + T` or search for "Terminal"
- **Fedora/RHEL**: Activities → Search "Terminal"
- **Other**: Look in Applications → Utilities

### macOS
- Press `Cmd + Space`, type "Terminal", press Enter
- Or: Applications → Utilities → Terminal

### Windows (WSL)
- Install WSL from Microsoft Store
- Open "Ubuntu" or your chosen distribution

## 📝 Your First Commands

Try these commands to get started:

```bash
# Display a message
echo "Hello, World!"

# Show current date and time
date

# Display a calendar
cal

# Clear the screen
clear

# Show who you are
whoami
```

## 💡 Tips for Beginners

1. **Case Sensitivity**: UNIX commands are case-sensitive
   - `ls` ≠ `LS` ≠ `Ls`

2. **Spaces Matter**: Separate commands and arguments with spaces
   - `ls -l` not `ls-l`

3. **Tab Completion**: Press `Tab` to auto-complete commands and filenames

4. **Command History**: Press `↑` and `↓` to navigate through previous commands

5. **Getting Help**: Most commands have built-in help
   ```bash
   command --help
   man command
   ```

## ⚠️ Common Mistakes

- **Typos**: Double-check your commands before pressing Enter
- **Wrong directory**: Use `pwd` to check where you are
- **Missing spaces**: Ensure proper spacing between arguments
- **Case errors**: Remember commands are lowercase

## 🔗 Next Steps

After completing this module, continue to:
- [Module 02: Files and Directories](../02-files-and-directories/)

## 📚 Additional Resources

- [GNU Coreutils Manual](https://www.gnu.org/software/coreutils/manual/)
- [Linux man pages](https://linux.die.net/man/)
