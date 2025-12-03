# 🔤 Regular Expressions Cheatsheet

> Quick reference for regex patterns in UNIX/Linux

---

## 📚 Basic Syntax

### Literal Characters

| Pattern | Matches |
|---------|---------|
| `a` | The character 'a' |
| `abc` | The string "abc" |
| `123` | The string "123" |

### Metacharacters

| Character | Meaning | Example | Matches |
|-----------|---------|---------|---------|
| `.` | Any single character | `a.c` | "abc", "a1c", "a c" |
| `^` | Start of line | `^Hello` | "Hello world" (at start) |
| `$` | End of line | `world$` | "Hello world" (at end) |
| `*` | Zero or more | `ab*c` | "ac", "abc", "abbc" |
| `+` | One or more (ERE) | `ab+c` | "abc", "abbc" (not "ac") |
| `?` | Zero or one (ERE) | `ab?c` | "ac", "abc" |
| `\` | Escape character | `\.` | Literal "." |
| `\|` | Alternation (OR) | `cat\|dog` | "cat" or "dog" |

---

## 📦 Character Classes

### Basic Classes

| Pattern | Matches | Example |
|---------|---------|---------|
| `[abc]` | Any of a, b, or c | `[aeiou]` matches vowels |
| `[^abc]` | Not a, b, or c | `[^0-9]` matches non-digits |
| `[a-z]` | Range a to z | `[a-zA-Z]` matches letters |
| `[0-9]` | Any digit | `[0-9]+` matches numbers |

### POSIX Classes

| Class | Equivalent | Matches |
|-------|------------|---------|
| `[:alnum:]` | `[a-zA-Z0-9]` | Alphanumeric |
| `[:alpha:]` | `[a-zA-Z]` | Letters |
| `[:digit:]` | `[0-9]` | Digits |
| `[:lower:]` | `[a-z]` | Lowercase |
| `[:upper:]` | `[A-Z]` | Uppercase |
| `[:space:]` | `[ \t\n\r\f\v]` | Whitespace |
| `[:blank:]` | `[ \t]` | Space and tab |
| `[:punct:]` | Punctuation | !"#$%&'()*+,-./ etc. |

```bash
# Usage with grep
grep '[[:digit:]]' file.txt
grep '[[:alpha:]]' file.txt
```

---

## 🔢 Quantifiers

### Basic Quantifiers

| Pattern | Meaning | Example | Matches |
|---------|---------|---------|---------|
| `*` | 0 or more | `ab*` | "a", "ab", "abb" |
| `+` | 1 or more | `ab+` | "ab", "abb" (not "a") |
| `?` | 0 or 1 | `ab?` | "a", "ab" |
| `{n}` | Exactly n | `a{3}` | "aaa" |
| `{n,}` | n or more | `a{2,}` | "aa", "aaa", "aaaa" |
| `{n,m}` | Between n and m | `a{2,4}` | "aa", "aaa", "aaaa" |

### Greedy vs Non-Greedy

```bash
# Greedy (default) - matches as much as possible
echo "aaaaaa" | grep -o 'a*'    # "aaaaaa"

# In some tools, use ? for non-greedy
# Perl/Python: a*? matches as little as possible
```

---

## 🎯 Anchors and Boundaries

| Pattern | Meaning | Example |
|---------|---------|---------|
| `^` | Start of line | `^Start` |
| `$` | End of line | `end$` |
| `\b` | Word boundary | `\bword\b` |
| `\B` | Non-word boundary | `\Bword\B` |
| `\<` | Start of word | `\<word` |
| `\>` | End of word | `word\>` |

```bash
# Match lines starting with "Error"
grep '^Error' log.txt

# Match lines ending with period
grep '\.$' file.txt

# Match whole word "cat" only
grep '\bcat\b' file.txt
```

---

## 🔀 Grouping and Capturing

### Groups

| Pattern | Meaning | Example |
|---------|---------|---------|
| `(abc)` | Group | `(ab)+` matches "ab", "abab" |
| `\1` | Backreference | `(a)\1` matches "aa" |
| `(?:abc)` | Non-capturing group | Used in Perl/Python |

### Examples

```bash
# Match repeated word
grep '\(word\)\1' file.txt

# Match date format
grep '\([0-9]\{2\}\)/\([0-9]\{2\}\)/\([0-9]\{4\}\)' file.txt

# With ERE (-E flag)
grep -E '([0-9]{2})/([0-9]{2})/([0-9]{4})' file.txt
```

---

## 🛠️ BRE vs ERE

### Basic Regular Expressions (BRE)

Used by: `grep`, `sed` (default)

```bash
# Metacharacters that need escaping
\+    \?    \{    \}    \(    \)    \|
```

### Extended Regular Expressions (ERE)

Used by: `grep -E`, `egrep`, `sed -E`, `awk`

```bash
# Metacharacters work without escaping
+    ?    {    }    (    )    |
```

### Comparison

| Feature | BRE | ERE |
|---------|-----|-----|
| One or more | `\+` | `+` |
| Zero or one | `\?` | `?` |
| Alternation | `\|` | `\|` |
| Grouping | `\( \)` | `( )` |
| Quantifier | `\{n\}` | `{n}` |

---

## 💻 Common Tools

### grep

```bash
# Basic grep
grep 'pattern' file.txt

# Extended regex
grep -E 'pattern' file.txt
# or
egrep 'pattern' file.txt

# Case insensitive
grep -i 'pattern' file.txt

# Show line numbers
grep -n 'pattern' file.txt

# Invert match
grep -v 'pattern' file.txt

# Only matching part
grep -o 'pattern' file.txt

# Count matches
grep -c 'pattern' file.txt
```

### sed

```bash
# Substitute first occurrence
sed 's/old/new/' file.txt

# Substitute all occurrences
sed 's/old/new/g' file.txt

# Case insensitive
sed 's/old/new/gi' file.txt

# Extended regex
sed -E 's/pattern/replacement/g' file.txt

# Delete lines matching pattern
sed '/pattern/d' file.txt

# Print only matching lines
sed -n '/pattern/p' file.txt
```

### awk

```bash
# Print lines matching pattern
awk '/pattern/' file.txt

# Print specific field of matching lines
awk '/pattern/ {print $1}' file.txt

# Field separator
awk -F':' '/pattern/ {print $1}' file.txt

# Regular expression match
awk '$1 ~ /pattern/' file.txt
```

---

## 📋 Common Patterns

### Validation Patterns

```bash
# Email (simplified)
[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}

# IP Address (basic)
[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}

# Phone (US format)
\([0-9]{3}\)[- ]?[0-9]{3}[- ]?[0-9]{4}

# Date (MM/DD/YYYY)
[0-9]{2}/[0-9]{2}/[0-9]{4}

# Time (HH:MM)
[0-2][0-9]:[0-5][0-9]

# URL (basic)
https?://[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}(/.*)?
```

### Search Patterns

```bash
# Blank lines
^$

# Lines with only whitespace
^[[:space:]]*$

# Comment lines (# style)
^[[:space:]]*#

# Lines starting with specific word
^word

# Lines ending with specific word
word$

# Lines containing word
.*word.*

# Whole word match
\bword\b
```

### Log File Patterns

```bash
# Error messages
grep -i 'error\|fail\|warn' log.txt

# IP addresses
grep -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' log.txt

# Timestamps
grep -E '[0-9]{2}:[0-9]{2}:[0-9]{2}' log.txt

# HTTP status codes
grep -E 'HTTP/[0-9.]+ [0-9]{3}' access.log
```

---

## 🎓 Practical Examples

### Find and Replace

```bash
# Replace all occurrences of "foo" with "bar"
sed 's/foo/bar/g' file.txt

# Remove trailing whitespace
sed 's/[[:space:]]*$//' file.txt

# Remove blank lines
sed '/^$/d' file.txt

# Add prefix to each line
sed 's/^/PREFIX: /' file.txt
```

### Extract Information

```bash
# Extract email addresses
grep -oE '[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}' file.txt

# Extract URLs
grep -oE 'https?://[^[:space:]]+' file.txt

# Extract numbers
grep -oE '[0-9]+' file.txt

# Extract words starting with capital
grep -oE '\b[A-Z][a-z]+\b' file.txt
```

### File Processing

```bash
# Find files containing pattern
grep -rl 'pattern' directory/

# Count occurrences in multiple files
grep -c 'pattern' *.txt

# Show lines before and after match
grep -B2 -A2 'pattern' file.txt

# Process CSV (extract column)
awk -F',' '{print $2}' file.csv
```

---

## ⚠️ Special Characters to Escape

In BRE, escape these when you want them literal:
```
. * [ ] ^ $ \
```

In ERE, also escape:
```
+ ? { } | ( )
```

Always escape when literal:
```
. * [ ] ^ $ \ + ? { } | ( )
```

---

## 💡 Tips and Tricks

```bash
# Test regex interactively
echo "test string" | grep -E 'pattern'

# Use online tools to build/test regex
# - regex101.com
# - regexr.com

# Start simple, build up complexity
# First: match literal text
# Then: add wildcards
# Finally: add quantifiers and anchors

# Use verbose mode when possible (Perl, Python)
# Break complex patterns into parts

# Remember: different tools have different flavors
# Always test with your specific tool
```

---

**📖 Related Resources:**
- [Essential Commands Cheatsheet](essential-commands.md)
- [Regular Expressions Module](../04-text-processing/regular-expressions.md)
- [Text Processing Commands](../04-text-processing/processing-commands.md)
