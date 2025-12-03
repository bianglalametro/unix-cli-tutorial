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

## 📱 Phone and Credit Card Patterns

```bash
# US Phone formats
grep -E '^\([0-9]{3}\) [0-9]{3}-[0-9]{4}$'           # (555) 123-4567
grep -E '^[0-9]{3}-[0-9]{3}-[0-9]{4}$'               # 555-123-4567
grep -E '^\+1[0-9]{10}$'                              # +15551234567

# International format
grep -E '^\+[0-9]{1,3}[0-9]{4,14}$'

# Credit card (basic validation)
grep -E '^4[0-9]{15}$'                                # Visa (16 digits)
grep -E '^5[1-5][0-9]{14}$'                           # MasterCard
grep -E '^3[47][0-9]{13}$'                            # American Express
```

---

## 🌐 Network Patterns

```bash
# IPv4 Address (strict)
grep -E '^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$'

# IPv4 Address (simple)
grep -E '^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$'

# MAC Address
grep -E '^([0-9A-Fa-f]{2}:){5}[0-9A-Fa-f]{2}$'

# Domain name
grep -E '^[a-zA-Z0-9]([a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(\.[a-zA-Z]{2,})+$'

# URL with protocol
grep -E '^https?://[a-zA-Z0-9]([a-zA-Z0-9-]*[a-zA-Z0-9])?(\.[a-zA-Z]{2,})+(:[0-9]+)?(/.*)?$'
```

---

## 📅 Date and Time Patterns

```bash
# Date formats
grep -E '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'               # YYYY-MM-DD
grep -E '^[0-9]{2}/[0-9]{2}/[0-9]{4}$'               # MM/DD/YYYY
grep -E '^[0-9]{2}\.[0-9]{2}\.[0-9]{4}$'             # DD.MM.YYYY

# Time formats
grep -E '^[0-2][0-9]:[0-5][0-9]$'                    # HH:MM
grep -E '^[0-2][0-9]:[0-5][0-9]:[0-5][0-9]$'         # HH:MM:SS
grep -E '^(0?[1-9]|1[0-2]):[0-5][0-9] [AP]M$'        # 12-hour format

# ISO 8601 datetime
grep -E '^[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}(Z|[+-][0-9]{2}:[0-9]{2})?$'
```

---

## 🔤 Text Validation Patterns

```bash
# Username (alphanumeric, 3-16 chars)
grep -E '^[a-zA-Z0-9_]{3,16}$'

# Strong password (8+ chars, upper, lower, digit, special)
grep -E '^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[@$!%*?&])[A-Za-z0-9@$!%*?&]{8,}$'

# Hex color code
grep -E '^#([0-9A-Fa-f]{3}|[0-9A-Fa-f]{6})$'

# UUID
grep -E '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$'

# Slug (URL-friendly string)
grep -E '^[a-z0-9]+(-[a-z0-9]+)*$'
```

---

## 🗂️ File Path Patterns

```bash
# Unix absolute path
grep -E '^/([a-zA-Z0-9._-]+/?)*$'

# Unix relative path
grep -E '^\.?\.?(/[a-zA-Z0-9._-]+)+/?$'

# File extension
grep -E '\.[a-zA-Z0-9]+$'

# Specific extensions
grep -E '\.(txt|md|rst)$'                            # Text files
grep -E '\.(jpg|jpeg|png|gif|bmp)$'                  # Images
grep -E '\.(mp3|wav|flac|ogg)$'                      # Audio
grep -E '\.(mp4|avi|mkv|mov)$'                       # Video
grep -E '\.(sh|bash|zsh)$'                           # Shell scripts
```

---

## 🔧 Advanced Sed Patterns

```bash
# Replace only in specific lines
sed '5,10s/old/new/g' file.txt                       # Lines 5-10
sed '/^#/!s/old/new/g' file.txt                      # Non-comment lines

# Multiple replacements
sed 's/foo/bar/g; s/baz/qux/g' file.txt

# Add line numbers
sed = file.txt | sed 'N; s/\n/\t/'

# Remove HTML tags
sed 's/<[^>]*>//g' file.html

# Extract between patterns
sed -n '/START/,/END/p' file.txt

# Insert line before/after pattern
sed '/pattern/i\New line before' file.txt
sed '/pattern/a\New line after' file.txt

# Delete lines between patterns
sed '/START/,/END/d' file.txt

# Reverse line order
sed '1!G;h;$!d' file.txt

# Convert to uppercase/lowercase
sed 's/[a-z]/\U&/g' file.txt                         # Uppercase
sed 's/[A-Z]/\L&/g' file.txt                         # Lowercase
```

---

## 🔧 Advanced AWK Patterns

```bash
# Print specific columns
awk '{print $1, $3}' file.txt

# Print last column
awk '{print $NF}' file.txt

# Print line count
awk 'END {print NR}' file.txt

# Sum column
awk '{sum += $1} END {print sum}' file.txt

# Average column
awk '{sum += $1} END {print sum/NR}' file.txt

# Print lines matching pattern
awk '/pattern/' file.txt

# Print lines where field matches
awk '$3 == "value"' file.txt
awk '$3 ~ /pattern/' file.txt

# Field separator
awk -F':' '{print $1}' /etc/passwd

# Multiple conditions
awk '$1 > 100 && $2 < 50' file.txt

# Format output
awk '{printf "%-10s %5d\n", $1, $2}' file.txt

# Process CSV
awk -F',' '{print $1, $3}' file.csv

# Count occurrences
awk '{count[$1]++} END {for (i in count) print i, count[i]}' file.txt

# Find max value
awk 'BEGIN {max=0} $1>max {max=$1} END {print max}' file.txt
```

---

## 📝 Lookahead and Lookbehind (Perl/Python)

> Note: These work in Perl, Python, and some other tools, but NOT in basic grep/sed.

```bash
# Lookahead (?=pattern) - match if followed by
foo(?=bar)                    # "foo" only if followed by "bar"

# Negative lookahead (?!pattern) - match if NOT followed by
foo(?!bar)                    # "foo" only if NOT followed by "bar"

# Lookbehind (?<=pattern) - match if preceded by
(?<=foo)bar                   # "bar" only if preceded by "foo"

# Negative lookbehind (?<!pattern) - match if NOT preceded by
(?<!foo)bar                   # "bar" only if NOT preceded by "foo"

# Using with grep -P (Perl regex)
grep -P 'foo(?=bar)' file.txt
grep -P '(?<=foo)bar' file.txt
```

---

**📖 Related Resources:**
- [Essential Commands Cheatsheet](essential-commands.md)
- [Regular Expressions Module](../04-text-processing/regular-expressions.md)
- [Text Processing Commands](../04-text-processing/processing-commands.md)
