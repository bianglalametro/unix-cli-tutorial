# Module 03: Permissions and Links

Learn about file ownership, permissions, links, and I/O redirection.

## 🎯 Learning Objectives

By the end of this module, you will be able to:
- Understand file ownership and groups
- Read and modify file permissions
- Create hard links and symbolic links
- Use input/output redirection and pipes
- Build command pipelines

## 📖 Topics Covered

| File | Description | Time |
|------|-------------|------|
| [ownership.md](ownership.md) | Understanding file ownership | 15 min |
| [permissions.md](permissions.md) | File permissions and chmod | 25 min |
| [links.md](links.md) | Hard links and symbolic links | 20 min |
| [streams-and-redirection.md](streams-and-redirection.md) | I/O redirection and pipes | 25 min |
| [exercises.md](exercises.md) | Practice exercises | 30 min |

## 🔐 Why Permissions Matter

UNIX/Linux is a multi-user system where:
- Multiple users can access the same computer
- Files must be protected from unauthorized access
- System files need to be secured

```
┌──────────────────────────────────────────────────────────────┐
│                    PERMISSION MODEL                          │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│   Every file has:                                            │
│   ┌─────────────┐  ┌─────────────┐  ┌──────────────────────┐│
│   │    Owner    │  │    Group    │  │     Permissions      ││
│   │   (user)    │  │             │  │  (read/write/exec)   ││
│   └─────────────┘  └─────────────┘  └──────────────────────┘│
│                                                              │
│   Three permission levels:                                   │
│   • User (u)  - the file owner                              │
│   • Group (g) - members of the file's group                 │
│   • Others (o) - everyone else                              │
│                                                              │
│   Three permission types:                                    │
│   • Read (r)   - view contents                              │
│   • Write (w)  - modify contents                            │
│   • Execute (x) - run as program / enter directory          │
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

## 🔗 Understanding Links

Links allow one file to be referenced by multiple names:

```
┌────────────────────────────────────────────────────────────┐
│                        HARD LINK                           │
├────────────────────────────────────────────────────────────┤
│                                                            │
│   file1.txt  ─────┐                                        │
│                   ├────> [INODE] ────> [DATA ON DISK]     │
│   file2.txt  ─────┘                                        │
│                                                            │
│   Both names point to the SAME data                        │
│   Deleting one doesn't affect the other                    │
│                                                            │
└────────────────────────────────────────────────────────────┘

┌────────────────────────────────────────────────────────────┐
│                     SYMBOLIC LINK                          │
├────────────────────────────────────────────────────────────┤
│                                                            │
│   symlink ────> file.txt ────> [INODE] ────> [DATA]       │
│                                                            │
│   Symlink points to the filename                           │
│   If file.txt is deleted, symlink is broken               │
│                                                            │
└────────────────────────────────────────────────────────────┘
```

## 📝 I/O Streams

Every process has three standard streams:

| Stream | Number | Description | Default |
|--------|--------|-------------|---------|
| stdin | 0 | Standard input | Keyboard |
| stdout | 1 | Standard output | Terminal |
| stderr | 2 | Standard error | Terminal |

```
              ┌─────────────┐
   stdin ───> │             │ ───> stdout
  (input)     │   PROCESS   │    (output)
              │             │ ───> stderr
              └─────────────┘    (errors)
```

## 💡 Quick Reference

### Permission Notation

| Symbolic | Octal | Description |
|----------|-------|-------------|
| `rwx` | 7 | Read, write, execute |
| `rw-` | 6 | Read, write |
| `r-x` | 5 | Read, execute |
| `r--` | 4 | Read only |
| `-wx` | 3 | Write, execute |
| `-w-` | 2 | Write only |
| `--x` | 1 | Execute only |
| `---` | 0 | No permissions |

### Redirection Quick Reference

| Operator | Description |
|----------|-------------|
| `>` | Redirect stdout (overwrite) |
| `>>` | Redirect stdout (append) |
| `<` | Redirect stdin |
| `2>` | Redirect stderr |
| `&>` | Redirect both stdout and stderr |
| `\|` | Pipe stdout to another command |

## ⚠️ Common Mistakes

- **Forgetting execute on directories**: You need `x` to `cd` into a directory
- **Overly permissive**: Don't use `chmod 777` unnecessarily
- **Broken symlinks**: Deleting the target breaks symbolic links
- **Wrong redirection**: `>` overwrites, `>>` appends

## 🔗 Next Steps

Start with:
1. [Ownership](ownership.md) - Understand who owns files
2. [Permissions](permissions.md) - Control access to files
3. [Links](links.md) - Create hard and symbolic links
4. [Streams and Redirection](streams-and-redirection.md) - Control I/O

After completing this module, continue to:
- [Module 04: Text Processing](../04-text-processing/)

## 📚 Additional Resources

- [GNU Coreutils: File permissions](https://www.gnu.org/software/coreutils/manual/html_node/File-permissions.html)
- [Linux Documentation Project: Permissions](https://tldp.org/LDP/intro-linux/html/sect_03_04.html)
