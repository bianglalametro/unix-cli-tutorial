# Regular Expressions

Master pattern matching with regular expressions (regex).

## 📖 Table of Contents

- [What are Regular Expressions?](#what-are-regular-expressions)
- [Basic Patterns](#basic-patterns)
- [Character Classes](#character-classes)
- [Quantifiers](#quantifiers)
- [Anchors](#anchors)
- [Groups and Alternation](#groups-and-alternation)
- [Extended Regular Expressions](#extended-regular-expressions)
- [Practical Examples](#practical-examples)

---

## What are Regular Expressions?

Regular expressions (regex) are patterns used to match text. They're used in:
- `grep` - Search for patterns
- `sed` - Find and replace
- `awk` - Pattern processing
- Many programming languages

### Types of Regex

| Type | Flag | Commands |
|------|------|----------|
| Basic (BRE) | Default | grep, sed |
| Extended (ERE) | `-E` | grep -E, sed -E, awk |
| Perl-Compatible (PCRE) | `-P` | grep -P |

---

## Basic Patterns

### Literal Characters

```bash
# Match exact text
$ grep "hello" file.txt     # Lines containing "hello"
$ grep "Hello World" file.txt
```

### Special Characters (Metacharacters)

| Character | Meaning |
|-----------|---------|
| `.` | Any single character |
| `*` | Zero or more of previous |
| `^` | Start of line |
| `$` | End of line |
| `[]` | Character class |
| `\` | Escape special character |

### The Dot (.)

Matches any single character except newline:

```bash
$ echo -e "cat\ncut\ncot\ncart" | grep "c.t"
cat
cut
cot
# "cart" doesn't match (two characters between c and t)
```

### Escaping Special Characters

```bash
# Match a literal dot
$ grep "\." file.txt

# Match a literal asterisk
$ grep "\*" file.txt

# Match literal brackets
$ grep "\[" file.txt
```

---

## Character Classes

Match one character from a set.

### Basic Classes

```bash
# Match a, b, or c
$ grep "[abc]" file.txt

# Match any digit
$ grep "[0-9]" file.txt

# Match any letter
$ grep "[A-Za-z]" file.txt

# Match anything NOT in the class
$ grep "[^0-9]" file.txt
```

### Common Character Classes

| Pattern | Matches |
|---------|---------|
| `[0-9]` | Any digit |
| `[a-z]` | Lowercase letter |
| `[A-Z]` | Uppercase letter |
| `[A-Za-z]` | Any letter |
| `[A-Za-z0-9]` | Alphanumeric |
| `[^0-9]` | Non-digit |

### POSIX Character Classes

| Class | Equivalent | Meaning |
|-------|------------|---------|
| `[[:alpha:]]` | `[A-Za-z]` | Letters |
| `[[:digit:]]` | `[0-9]` | Digits |
| `[[:alnum:]]` | `[A-Za-z0-9]` | Alphanumeric |
| `[[:space:]]` | `[ \t\n\r]` | Whitespace |
| `[[:upper:]]` | `[A-Z]` | Uppercase |
| `[[:lower:]]` | `[a-z]` | Lowercase |
| `[[:punct:]]` | | Punctuation |
| `[[:blank:]]` | `[ \t]` | Space/Tab |

```bash
# Match any digit
$ grep "[[:digit:]]" file.txt

# Match any alphanumeric
$ grep "[[:alnum:]]" file.txt
```

---

## Quantifiers

Control how many times a pattern matches.

### Basic Quantifiers

| Quantifier | Meaning | Example |
|------------|---------|---------|
| `*` | Zero or more | `go*d` matches gd, god, good |
| `\+` | One or more (BRE) | `go\+d` matches god, good |
| `+` | One or more (ERE) | `go+d` matches god, good |
| `\?` | Zero or one (BRE) | `colou\?r` matches color, colour |
| `?` | Zero or one (ERE) | `colou?r` matches color, colour |

### Examples

```bash
# Zero or more 'o'
$ echo -e "gd\ngod\ngood\ngoood" | grep "go*d"
gd
god
good
goood

# One or more 'o' (use -E for extended)
$ echo -e "gd\ngod\ngood" | grep -E "go+d"
god
good

# Optional 'u'
$ echo -e "color\ncolour" | grep -E "colou?r"
color
colour
```

### Specific Counts (ERE)

| Pattern | Meaning |
|---------|---------|
| `{n}` | Exactly n times |
| `{n,}` | n or more times |
| `{n,m}` | Between n and m times |

```bash
# Exactly 3 digits
$ grep -E "[0-9]{3}" file.txt

# Phone number pattern (XXX-XXX-XXXX)
$ grep -E "[0-9]{3}-[0-9]{3}-[0-9]{4}" contacts.txt

# 2 to 4 letters
$ grep -E "[A-Za-z]{2,4}" file.txt
```

---

## Anchors

Match positions, not characters.

| Anchor | Meaning |
|--------|---------|
| `^` | Start of line |
| `$` | End of line |
| `\b` | Word boundary |
| `\B` | Not word boundary |

### Examples

```bash
# Lines starting with "Error"
$ grep "^Error" log.txt

# Lines ending with "failed"
$ grep "failed$" log.txt

# Empty lines
$ grep "^$" file.txt

# Lines containing only digits
$ grep "^[0-9]*$" file.txt

# Word boundary
$ grep -E "\bcat\b" file.txt   # Matches "cat" but not "catalog"
```

---

## Groups and Alternation

### Alternation (OR)

Match one pattern or another:

```bash
# BRE (escaped)
$ grep "error\|warning" log.txt

# ERE (cleaner)
$ grep -E "error|warning" log.txt
$ grep -E "(error|warning|critical)" log.txt
```

### Grouping

Group patterns for quantifiers or backreferences:

```bash
# Match "ab" repeated
$ grep -E "(ab)+" file.txt

# Match "ha" repeated
$ echo "hahaha" | grep -E "(ha){2,}"
```

### Backreferences

Reference captured groups:

```bash
# Match repeated words
$ grep -E "\b([a-z]+) \1\b" file.txt
# Matches: "the the", "is is"

# In sed, swap words
$ echo "hello world" | sed 's/\([a-z]*\) \([a-z]*\)/\2 \1/'
world hello

# ERE version
$ echo "hello world" | sed -E 's/([a-z]+) ([a-z]+)/\2 \1/'
world hello
```

---

## Extended Regular Expressions

Use `grep -E` or `egrep` for extended regex:

| Feature | BRE | ERE |
|---------|-----|-----|
| One or more | `\+` | `+` |
| Zero or one | `\?` | `?` |
| Alternation | `\|` | `|` |
| Grouping | `\(\)` | `()` |
| Counts | `\{n\}` | `{n}` |

```bash
# Same pattern, different syntax
$ grep "go\+d" file.txt       # BRE
$ grep -E "go+d" file.txt     # ERE (cleaner)
```

---

## Practical Examples

### Email Addresses

```bash
# Basic email pattern
$ grep -E "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}" file.txt

# Extract emails
$ grep -oE "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}" file.txt
```

### IP Addresses

```bash
# Basic IPv4 pattern
$ grep -E "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}" file.txt

# More precise (not perfect)
$ grep -E "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" file.txt
```

### URLs

```bash
# Basic URL pattern
$ grep -E "https?://[A-Za-z0-9./-]+" file.txt
```

### Phone Numbers

```bash
# US phone: (XXX) XXX-XXXX or XXX-XXX-XXXX
$ grep -E "\(?[0-9]{3}\)?[-. ]?[0-9]{3}[-. ]?[0-9]{4}" contacts.txt
```

### Dates

```bash
# YYYY-MM-DD
$ grep -E "[0-9]{4}-[0-9]{2}-[0-9]{2}" file.txt

# MM/DD/YYYY
$ grep -E "[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}" file.txt
```

### Log Processing

```bash
# Error lines with timestamp
$ grep -E "^[0-9]{4}-[0-9]{2}-[0-9]{2}.*ERROR" log.txt

# IP addresses followed by status code
$ grep -E "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+.*\" [45][0-9]{2}" access.log
```

### Code Patterns

```bash
# Function definitions (Python)
$ grep -E "^def [a-z_]+\(" *.py

# TODO comments
$ grep -E "//\s*TODO:|#\s*TODO:" *.js *.py

# Variable assignments
$ grep -E "^[a-zA-Z_][a-zA-Z0-9_]*\s*=" file.txt
```

---

## Regex Cheat Sheet

```
┌───────────────────────────────────────────────────────────────┐
│                    REGEX QUICK REFERENCE                      │
├───────────────────────────────────────────────────────────────┤
│  ANCHORS                  │  QUANTIFIERS (ERE)               │
│  ^       Start of line    │  *      Zero or more             │
│  $       End of line      │  +      One or more              │
│  \b      Word boundary    │  ?      Zero or one              │
│                           │  {n}    Exactly n                │
│  CHARACTERS               │  {n,}   n or more                │
│  .       Any character    │  {n,m}  Between n and m          │
│  [abc]   a, b, or c       │                                  │
│  [^abc]  Not a, b, c      │  GROUPS                          │
│  [a-z]   Range a-z        │  (...)  Capture group            │
│                           │  |      Alternation (OR)         │
│  ESCAPE                   │  \1     Backreference            │
│  \       Escape next char │                                  │
└───────────────────────────────────────────────────────────────┘
```

---

## 🏋️ Practice Exercises

1. Find all lines starting with a capital letter
2. Find all lines ending with a number
3. Find all phone numbers in format XXX-XXX-XXXX
4. Find all words that are exactly 5 letters long
5. Extract all email addresses from a file

### Solutions

```bash
# Exercise 1
grep "^[A-Z]" file.txt

# Exercise 2
grep "[0-9]$" file.txt

# Exercise 3
grep -E "[0-9]{3}-[0-9]{3}-[0-9]{4}" file.txt

# Exercise 4
grep -E "\b[A-Za-z]{5}\b" file.txt

# Exercise 5
grep -oE "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}" file.txt
```

---

## 🔗 Next Topic

Continue to [Exercises](exercises.md) →
