# 🐧 UNIX/Linux Command Line Tutorial

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

> A comprehensive, well-organized repository for mastering UNIX/Linux command-line skills. From absolute beginner to advanced scripting, this tutorial provides hands-on learning with real-world examples.

## 🎯 Why Learn the Command Line?

The command line is a powerful interface that allows you to:
- 🚀 Work faster and more efficiently than with GUIs
- 🔧 Automate repetitive tasks
- 💻 Access remote servers and cloud infrastructure
- 🛠️ Understand how your system really works
- 📊 Process and analyze data at scale

---

## 📚 Table of Contents

### Core Modules

| Module | Topics Covered | Level |
|--------|---------------|-------|
| [01. Introduction to CLI](01-introduction/) | Basic commands, user management, communication, shortcuts | 🟢 Beginner |
| [02. Files and Directories](02-files-and-directories/) | Navigation, file/directory operations, paths | 🟢 Beginner |
| [03. Permissions and Links](03-permissions-and-links/) | Ownership, chmod, links, redirection | 🟡 Intermediate |
| [04. Text Processing](04-text-processing/) | grep, sed, awk, regex, text editors | 🟡 Intermediate |
| [05. Processes and Jobs](05-processes-and-jobs/) | Process management, job control, monitoring | 🟡 Intermediate |
| [06. Shell Scripting](06-shell-scripting/) | Variables, control flow, functions, automation | 🔴 Advanced |
| [07. Advanced Topics](07-advanced-topics/) | Compression, file conversion, system info | 🔴 Advanced |

### Quick References

| Resource | Description |
|----------|-------------|
| [📋 Cheatsheets](cheatsheets/) | Quick reference guides for essential commands |
| [✏️ Exercises](exercises/) | Practice exercises by difficulty level |
| [📖 Resources](resources/) | Books, websites, troubleshooting guides |

---

## 🚀 Quick Start

### Prerequisites

- Access to a UNIX/Linux terminal (Linux, macOS, or WSL on Windows)
- Basic computer literacy
- Curiosity and willingness to learn!

### Getting Started

```bash
# Clone this repository
git clone https://github.com/bianglalametro/unix-cli-tutorial.git

# Navigate to the tutorial
cd unix-cli-tutorial

# Start with the introduction
cd 01-introduction
```

### Recommended Learning Path

```
┌─────────────────────────────────────────────────────────────────┐
│                     LEARNING PATH                               │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  🟢 BEGINNER (Week 1-2)                                        │
│  ├── 01-introduction/                                          │
│  │   ├── Basic commands (echo, date, cal)                      │
│  │   ├── User management                                       │
│  │   └── Keyboard shortcuts                                    │
│  └── 02-files-and-directories/                                 │
│      ├── Navigation (pwd, cd, ls)                              │
│      ├── File operations (touch, cp, mv, rm)                   │
│      └── Directory operations                                  │
│                                                                 │
│  🟡 INTERMEDIATE (Week 3-4)                                    │
│  ├── 03-permissions-and-links/                                 │
│  │   ├── File permissions (chmod, chown)                       │
│  │   ├── Links (hard, symbolic)                                │
│  │   └── I/O redirection and pipes                             │
│  ├── 04-text-processing/                                       │
│  │   ├── Text viewing (cat, less, head, tail)                  │
│  │   ├── Text processing (grep, sed, awk)                      │
│  │   └── Regular expressions                                   │
│  └── 05-processes-and-jobs/                                    │
│      ├── Process management (ps, top, kill)                    │
│      └── Job control (jobs, fg, bg)                            │
│                                                                 │
│  🔴 ADVANCED (Week 5-6)                                        │
│  ├── 06-shell-scripting/                                       │
│  │   ├── Variables and parameters                              │
│  │   ├── Control flow and loops                                │
│  │   └── Functions and automation                              │
│  └── 07-advanced-topics/                                       │
│      ├── Compression (tar, gzip, zip)                          │
│      └── System information                                    │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

## 📖 How to Use This Repository

### For Self-Study
1. **Follow the modules in order** - Each builds on previous concepts
2. **Type every command** - Don't just read; practice!
3. **Complete the exercises** - Practice is key to mastery
4. **Use the cheatsheets** - Quick references when you forget

### For Instructors
- Each module has a README with learning objectives
- Exercises are organized by difficulty
- Example scripts demonstrate real-world applications

### Interactive Learning Tips

💡 **Tip**: Open two terminal windows side-by-side:
- One for reading the tutorial
- One for practicing commands

```bash
# Use 'less' to read markdown files in terminal
less 01-introduction/basic-commands.md

# Or use a markdown viewer
# (install with: pip install grip)
grip README.md
```

---

## 📁 Repository Structure

```
unix-cli-tutorial/
├── README.md                          # You are here!
├── 01-introduction/                   # CLI basics
│   ├── README.md
│   ├── basic-commands.md
│   ├── user-management.md
│   ├── communication.md
│   └── shortcuts.md
├── 02-files-and-directories/          # File system navigation
│   ├── README.md
│   ├── navigation.md
│   ├── file-operations.md
│   ├── directory-operations.md
│   ├── paths-and-symbols.md
│   └── exercises.md
├── 03-permissions-and-links/          # Permissions and linking
│   ├── README.md
│   ├── ownership.md
│   ├── permissions.md
│   ├── links.md
│   ├── streams-and-redirection.md
│   └── exercises.md
├── 04-text-processing/                # Text manipulation
│   ├── README.md
│   ├── search-commands.md
│   ├── text-editors.md
│   ├── viewing-text.md
│   ├── processing-commands.md
│   ├── regular-expressions.md
│   └── exercises.md
├── 05-processes-and-jobs/             # Process management
│   ├── README.md
│   ├── process-management.md
│   ├── process-control.md
│   ├── job-control.md
│   ├── monitoring.md
│   └── exercises.md
├── 06-shell-scripting/                # Bash scripting
│   ├── README.md
│   ├── basics.md
│   ├── control-flow.md
│   ├── functions.md
│   ├── examples/
│   │   ├── backup.sh
│   │   ├── system-info.sh
│   │   ├── file-organizer.sh
│   │   ├── top-words.sh
│   │   └── monitor.sh
│   └── exercises.md
├── 07-advanced-topics/                # Advanced concepts
│   ├── README.md
│   ├── compression.md
│   ├── file-conversion.md
│   ├── system-info.md
│   └── exercises.md
├── cheatsheets/                       # Quick references
│   ├── essential-commands.md
│   ├── file-permissions.md
│   ├── regex-cheatsheet.md
│   ├── vim-cheatsheet.md
│   └── scripting-cheatsheet.md
├── exercises/                         # Practice exercises
│   ├── README.md
│   ├── beginner/
│   ├── intermediate/
│   └── advanced/
├── resources/                         # Additional materials
│   ├── README.md
│   ├── books.md
│   ├── websites.md
│   └── troubleshooting.md
└── LICENSE                            # MIT License
```

---

## 🎓 Command Index

Quick lookup for common commands covered in this tutorial:

<details>
<summary><strong>File Operations</strong></summary>

| Command | Description | Module |
|---------|-------------|--------|
| `ls` | List directory contents | [02](02-files-and-directories/navigation.md) |
| `cd` | Change directory | [02](02-files-and-directories/navigation.md) |
| `pwd` | Print working directory | [02](02-files-and-directories/navigation.md) |
| `cp` | Copy files/directories | [02](02-files-and-directories/file-operations.md) |
| `mv` | Move/rename files | [02](02-files-and-directories/file-operations.md) |
| `rm` | Remove files/directories | [02](02-files-and-directories/file-operations.md) |
| `touch` | Create empty file | [02](02-files-and-directories/file-operations.md) |
| `mkdir` | Create directory | [02](02-files-and-directories/directory-operations.md) |
| `rmdir` | Remove empty directory | [02](02-files-and-directories/directory-operations.md) |

</details>

<details>
<summary><strong>Text Processing</strong></summary>

| Command | Description | Module |
|---------|-------------|--------|
| `cat` | Display file contents | [04](04-text-processing/viewing-text.md) |
| `less` | Page through text | [04](04-text-processing/viewing-text.md) |
| `head` | Show beginning of file | [04](04-text-processing/viewing-text.md) |
| `tail` | Show end of file | [04](04-text-processing/viewing-text.md) |
| `grep` | Search text patterns | [04](04-text-processing/processing-commands.md) |
| `sed` | Stream editor | [04](04-text-processing/processing-commands.md) |
| `awk` | Pattern processing | [04](04-text-processing/processing-commands.md) |
| `sort` | Sort lines | [04](04-text-processing/processing-commands.md) |
| `uniq` | Remove duplicates | [04](04-text-processing/processing-commands.md) |

</details>

<details>
<summary><strong>Process Management</strong></summary>

| Command | Description | Module |
|---------|-------------|--------|
| `ps` | List processes | [05](05-processes-and-jobs/process-management.md) |
| `top` | Real-time process viewer | [05](05-processes-and-jobs/process-management.md) |
| `kill` | Terminate processes | [05](05-processes-and-jobs/process-management.md) |
| `jobs` | List background jobs | [05](05-processes-and-jobs/job-control.md) |
| `fg` | Bring job to foreground | [05](05-processes-and-jobs/job-control.md) |
| `bg` | Send job to background | [05](05-processes-and-jobs/job-control.md) |

</details>

---

## 🤝 Contributing

Contributions are welcome! Here's how you can help:

1. **Report Issues**: Found an error or have a suggestion? [Open an issue](../../issues)
2. **Submit PRs**: Fix typos, add examples, or improve explanations
3. **Share**: Star this repo and share with others learning CLI

### Contribution Guidelines

- Keep explanations clear and beginner-friendly
- Include practical examples for new commands
- Test all commands before submitting
- Follow the existing formatting style

---

## 💬 Interview Questions

Preparing for a technical interview? Check out our collection of common CLI-related interview questions in each module's exercises section.

---

## 🙏 Acknowledgments

This tutorial is inspired by and builds upon excellent educational resources:

- **[auriza/os-lab](https://github.com/auriza/os-lab)** - Operating System Lab materials
- The Linux Documentation Project
- GNU Coreutils documentation
- The broader open-source community

---

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## ⭐ Star History

If you find this tutorial helpful, please consider giving it a star! It helps others discover this resource.

---

<div align="center">

**Happy Learning! 🎉**

*"The command line is not just a tool, it's a superpower."*

</div>
