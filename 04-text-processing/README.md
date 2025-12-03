# Module 04: Text Processing

Master text viewing, searching, and manipulation commands.

## 🎯 Learning Objectives

By the end of this module, you will be able to:
- Find commands and files using `man`, `which`, `locate`, and `find`
- View and navigate text files with `cat`, `less`, `head`, and `tail`
- Process text using `grep`, `sed`, `awk`, `cut`, `sort`, and `uniq`
- Use basic regular expressions for pattern matching
- Work with text editors like `nano` and `vim`

## 📖 Topics Covered

| File | Description | Time |
|------|-------------|------|
| [search-commands.md](search-commands.md) | Finding commands and files | 20 min |
| [text-editors.md](text-editors.md) | Using nano and vim | 30 min |
| [viewing-text.md](viewing-text.md) | Viewing file contents | 20 min |
| [processing-commands.md](processing-commands.md) | Text processing tools | 40 min |
| [regular-expressions.md](regular-expressions.md) | Regex patterns | 35 min |
| [exercises.md](exercises.md) | Practice exercises | 45 min |

## 🔧 Text Processing Overview

```
┌─────────────────────────────────────────────────────────────────┐
│                TEXT PROCESSING PIPELINE                        │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│   INPUT                                                         │
│     │                                                           │
│     ▼                                                           │
│   ┌─────────────────────────────────────────────────────────┐  │
│   │  cat / less / head / tail    (VIEW)                     │  │
│   └─────────────────────────────────────────────────────────┘  │
│     │                                                           │
│     ▼                                                           │
│   ┌─────────────────────────────────────────────────────────┐  │
│   │  grep / sed / awk            (FILTER & TRANSFORM)       │  │
│   └─────────────────────────────────────────────────────────┘  │
│     │                                                           │
│     ▼                                                           │
│   ┌─────────────────────────────────────────────────────────┐  │
│   │  sort / uniq / cut / paste   (ORGANIZE)                 │  │
│   └─────────────────────────────────────────────────────────┘  │
│     │                                                           │
│     ▼                                                           │
│   OUTPUT                                                        │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

## 🛠️ Command Quick Reference

### Viewing Files

| Command | Description | Example |
|---------|-------------|---------|
| `cat` | Display entire file | `cat file.txt` |
| `less` | Paginated viewer | `less file.txt` |
| `head` | Show first lines | `head -n 10 file.txt` |
| `tail` | Show last lines | `tail -n 10 file.txt` |

### Searching

| Command | Description | Example |
|---------|-------------|---------|
| `grep` | Search for patterns | `grep "error" log.txt` |
| `find` | Find files | `find . -name "*.txt"` |
| `locate` | Fast file search | `locate myfile` |

### Processing

| Command | Description | Example |
|---------|-------------|---------|
| `sed` | Stream editor | `sed 's/old/new/g' file` |
| `awk` | Pattern processing | `awk '{print $1}' file` |
| `cut` | Extract columns | `cut -d: -f1 /etc/passwd` |
| `sort` | Sort lines | `sort file.txt` |
| `uniq` | Remove duplicates | `sort file \| uniq` |
| `wc` | Count words/lines | `wc -l file.txt` |
| `tr` | Translate characters | `tr 'a-z' 'A-Z'` |

## 💡 Tips for Text Processing

1. **Build pipelines incrementally** - Add one command at a time
2. **Use `head`** - Preview output before processing large files
3. **Learn regex basics** - Essential for `grep`, `sed`, and `awk`
4. **Quote patterns** - Prevent shell interpretation
5. **Test on small data** - Validate before running on large files

## ⚠️ Common Mistakes

- Forgetting to quote patterns with special characters
- Using `grep` without `-E` for extended regex
- Not using `-i` for case-insensitive searches when needed
- Forgetting that `sort` is needed before `uniq`

## 🔗 Next Steps

Start with:
1. [Search Commands](search-commands.md) - Find files and commands
2. [Text Editors](text-editors.md) - Edit files efficiently
3. [Viewing Text](viewing-text.md) - View and navigate files
4. [Processing Commands](processing-commands.md) - Transform text
5. [Regular Expressions](regular-expressions.md) - Pattern matching

After completing this module, continue to:
- [Module 05: Processes and Jobs](../05-processes-and-jobs/)

## 📚 Additional Resources

- [GNU Grep Manual](https://www.gnu.org/software/grep/manual/)
- [GNU Sed Manual](https://www.gnu.org/software/sed/manual/)
- [AWK Tutorial](https://www.gnu.org/software/gawk/manual/gawk.html)
- [Regular Expressions Quick Reference](https://quickref.me/regex)
