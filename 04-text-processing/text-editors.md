# Text Editors

Learn to edit files directly from the command line.

## 📖 Table of Contents

- [nano - Simple Editor](#nano---simple-editor)
- [vim - Powerful Editor](#vim---powerful-editor)
- [Choosing an Editor](#choosing-an-editor)

---

## nano - Simple Editor

A user-friendly, beginner-oriented text editor.

### Opening Files

```bash
# Open existing file
$ nano file.txt

# Open file at specific line
$ nano +10 file.txt

# Create new file
$ nano newfile.txt

# Open in read-only mode
$ nano -v file.txt
```

### Interface

```
┌──────────────────────────────────────────────────────────────┐
│  GNU nano 6.0                   file.txt                     │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│  Your file content appears here                              │
│  Line 1                                                      │
│  Line 2                                                      │
│  Line 3                                                      │
│                                                              │
├──────────────────────────────────────────────────────────────┤
│  ^G Help    ^O Write Out  ^W Where Is  ^K Cut     ^U Paste  │
│  ^X Exit    ^R Read File  ^\ Replace   ^J Justify ^T Spell  │
└──────────────────────────────────────────────────────────────┘
  ^ = Ctrl key
```

### Essential Shortcuts

| Shortcut | Action |
|----------|--------|
| `Ctrl + O` | Save file (Write Out) |
| `Ctrl + X` | Exit nano |
| `Ctrl + K` | Cut current line |
| `Ctrl + U` | Paste (Uncut) |
| `Ctrl + W` | Search (Where Is) |
| `Ctrl + \` | Search and replace |
| `Ctrl + G` | Show help |

### Navigation

| Shortcut | Action |
|----------|--------|
| `Ctrl + A` | Go to beginning of line |
| `Ctrl + E` | Go to end of line |
| `Ctrl + Y` | Page up |
| `Ctrl + V` | Page down |
| `Ctrl + _` | Go to line number |
| `Alt + \` | Go to beginning of file |
| `Alt + /` | Go to end of file |

### Editing

| Shortcut | Action |
|----------|--------|
| `Ctrl + K` | Cut line |
| `Ctrl + U` | Paste |
| `Alt + 6` | Copy line |
| `Ctrl + J` | Justify paragraph |
| `Alt + U` | Undo |
| `Alt + E` | Redo |

### Search and Replace

```bash
# Search
Ctrl + W → type search term → Enter

# Search next
Alt + W

# Replace
Ctrl + \ → type search term → Enter → type replacement → Enter
# Then: Y=yes, N=no, A=all
```

### Configuration

Create `~/.nanorc`:
```bash
# Enable line numbers
set linenumbers

# Enable auto-indentation
set autoindent

# Enable syntax highlighting
include "/usr/share/nano/*.nanorc"

# Show cursor position
set constantshow

# Enable mouse support
set mouse
```

---

## vim - Powerful Editor

A highly configurable, modal text editor.

### Modes

```
┌─────────────────────────────────────────────────────────────┐
│                      VIM MODES                              │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│   ┌──────────────┐     i, a, o     ┌──────────────┐        │
│   │              │ ──────────────> │              │        │
│   │    NORMAL    │                 │    INSERT    │        │
│   │              │ <────────────── │              │        │
│   └──────────────┘       Esc       └──────────────┘        │
│         │  │                                                │
│         │  │ :                                              │
│         │  ▼                                                │
│         │  ┌──────────────┐                                 │
│         │  │   COMMAND    │                                 │
│         │  │    LINE      │                                 │
│         │  └──────────────┘                                 │
│         │         │                                         │
│         ▼         │ v                                       │
│   ┌──────────────┐│                                         │
│   │    VISUAL    │◄                                         │
│   └──────────────┘                                          │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### Opening Files

```bash
# Open file
$ vim file.txt

# Open at specific line
$ vim +10 file.txt

# Open multiple files
$ vim file1.txt file2.txt

# Open in read-only mode
$ vim -R file.txt
$ view file.txt
```

### Basic Operations

```bash
# In Normal mode (press Esc first)
:w          # Save file
:q          # Quit
:wq         # Save and quit
:q!         # Quit without saving
:x          # Save and quit (same as :wq)
ZZ          # Save and quit (shortcut)
ZQ          # Quit without saving (shortcut)
```

### Mode Switching

| Key | Enter Mode | Description |
|-----|------------|-------------|
| `i` | Insert | Insert before cursor |
| `a` | Insert | Insert after cursor |
| `I` | Insert | Insert at line beginning |
| `A` | Insert | Insert at line end |
| `o` | Insert | New line below |
| `O` | Insert | New line above |
| `Esc` | Normal | Return to normal mode |
| `v` | Visual | Character selection |
| `V` | Visual | Line selection |
| `Ctrl+v` | Visual | Block selection |

### Navigation (Normal Mode)

| Key | Action |
|-----|--------|
| `h` | Left |
| `j` | Down |
| `k` | Up |
| `l` | Right |
| `w` | Next word |
| `b` | Previous word |
| `0` | Beginning of line |
| `$` | End of line |
| `gg` | Beginning of file |
| `G` | End of file |
| `10G` | Go to line 10 |
| `Ctrl+f` | Page down |
| `Ctrl+b` | Page up |

### Editing (Normal Mode)

| Key | Action |
|-----|--------|
| `x` | Delete character |
| `dd` | Delete line |
| `D` | Delete to end of line |
| `dw` | Delete word |
| `d$` | Delete to end of line |
| `yy` | Copy (yank) line |
| `yw` | Copy word |
| `p` | Paste after cursor |
| `P` | Paste before cursor |
| `u` | Undo |
| `Ctrl+r` | Redo |
| `.` | Repeat last command |

### Search and Replace

```bash
# Search
/pattern        # Search forward
?pattern        # Search backward
n               # Next match
N               # Previous match

# Replace
:s/old/new/     # Replace first on current line
:s/old/new/g    # Replace all on current line
:%s/old/new/g   # Replace all in file
:%s/old/new/gc  # Replace all with confirmation
```

### Multiple Files

```bash
:e filename     # Open another file
:bn             # Next buffer
:bp             # Previous buffer
:ls             # List buffers
:sp             # Horizontal split
:vsp            # Vertical split
Ctrl+w w        # Switch between splits
Ctrl+w q        # Close split
```

### Useful Commands

```bash
# Show line numbers
:set number

# Hide line numbers
:set nonumber

# Enable syntax highlighting
:syntax on

# Set tab width
:set tabstop=4

# Enable auto-indent
:set autoindent

# Search highlighting
:set hlsearch
:nohlsearch     # Clear highlighting
```

### Essential .vimrc

Create `~/.vimrc`:
```vim
" Enable syntax highlighting
syntax on

" Show line numbers
set number

" Enable auto-indentation
set autoindent
set smartindent

" Set tab width
set tabstop=4
set shiftwidth=4
set expandtab

" Enable mouse support
set mouse=a

" Highlight search results
set hlsearch
set incsearch

" Show matching brackets
set showmatch

" Enable file type detection
filetype plugin indent on
```

---

## Choosing an Editor

### nano
✅ **Pros**:
- Easy to learn
- Intuitive keyboard shortcuts
- Good for quick edits
- No mode confusion

❌ **Cons**:
- Limited features
- No advanced text manipulation
- Slower for experienced users

**Best for**: Beginners, quick edits, config files

### vim
✅ **Pros**:
- Extremely powerful
- Efficient once learned
- Available everywhere
- Highly customizable
- Rich plugin ecosystem

❌ **Cons**:
- Steep learning curve
- Modal editing confusing at first
- Takes time to become productive

**Best for**: Programmers, heavy text editing, power users

### When to Use Each

| Scenario | Editor |
|----------|--------|
| Quick config edit | nano |
| Writing code | vim |
| First time editing | nano |
| Remote server work | vim |
| Complex search/replace | vim |
| Learning CLI | nano |

### Other Editors

- **ed** - Original Unix editor
- **vi** - Predecessor to vim
- **emacs** - Alternative to vim (extensive but complex)
- **micro** - Modern, intuitive terminal editor

---

## 🏋️ Practice Exercises

1. Open a file in nano, add some text, save, and exit
2. Open vim, enter insert mode, type text, save and exit
3. In vim, practice navigating using h, j, k, l
4. Use vim to search for a word and replace it
5. Configure nano or vim with basic settings

### Solutions

```bash
# Exercise 1
nano test.txt
# Type: Hello World
# Ctrl+O, Enter (save)
# Ctrl+X (exit)

# Exercise 2
vim test.txt
# Press i (insert mode)
# Type: Hello from Vim
# Press Esc
# Type :wq (save and quit)

# Exercise 3
vim test.txt
# Navigate using h, j, k, l
# Press :q to exit

# Exercise 4
vim test.txt
# Type /Hello (search)
# Type :%s/Hello/Hi/g (replace)
# Type :wq

# Exercise 5
# For nano
echo "set linenumbers" >> ~/.nanorc

# For vim
echo "set number" >> ~/.vimrc
echo "syntax on" >> ~/.vimrc
```

---

## 🔗 Next Topic

Continue to [Viewing Text](viewing-text.md) →
