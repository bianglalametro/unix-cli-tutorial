# 📝 Vim Cheatsheet

> Quick reference for Vi/Vim text editor commands

---

## 🎯 Modes

| Mode | Description | How to Enter |
|------|-------------|--------------|
| **Normal** | Navigation and commands | `Esc` |
| **Insert** | Text input | `i`, `a`, `o`, etc. |
| **Visual** | Text selection | `v`, `V`, `Ctrl+v` |
| **Command** | Ex commands | `:` |

---

## 🚀 Getting Started

```bash
# Open file
vim filename.txt

# Open file at line number
vim +10 filename.txt

# Open file at pattern
vim +/pattern filename.txt

# Open multiple files
vim file1.txt file2.txt
```

---

## 🔤 Entering Insert Mode

| Key | Action |
|-----|--------|
| `i` | Insert before cursor |
| `I` | Insert at beginning of line |
| `a` | Append after cursor |
| `A` | Append at end of line |
| `o` | Open line below |
| `O` | Open line above |
| `s` | Substitute character |
| `S` | Substitute entire line |
| `c` | Change (with motion) |
| `C` | Change to end of line |

**Exit Insert Mode**: Press `Esc`

---

## 🧭 Navigation (Normal Mode)

### Basic Movement

| Key | Action |
|-----|--------|
| `h` | Move left |
| `j` | Move down |
| `k` | Move up |
| `l` | Move right |
| `0` | Beginning of line |
| `$` | End of line |
| `^` | First non-blank character |

### Word Movement

| Key | Action |
|-----|--------|
| `w` | Next word (beginning) |
| `W` | Next WORD (space-delimited) |
| `e` | End of word |
| `E` | End of WORD |
| `b` | Previous word |
| `B` | Previous WORD |

### Line Movement

| Key | Action |
|-----|--------|
| `gg` | Go to first line |
| `G` | Go to last line |
| `5G` or `:5` | Go to line 5 |
| `H` | Top of screen |
| `M` | Middle of screen |
| `L` | Bottom of screen |

### Screen Movement

| Key | Action |
|-----|--------|
| `Ctrl+f` | Page down |
| `Ctrl+b` | Page up |
| `Ctrl+d` | Half page down |
| `Ctrl+u` | Half page up |
| `Ctrl+e` | Scroll down one line |
| `Ctrl+y` | Scroll up one line |
| `zz` | Center current line |
| `zt` | Current line to top |
| `zb` | Current line to bottom |

### Jump Movement

| Key | Action |
|-----|--------|
| `%` | Jump to matching bracket |
| `*` | Next occurrence of word |
| `#` | Previous occurrence of word |
| `Ctrl+o` | Jump back |
| `Ctrl+i` | Jump forward |
| `` ` `` | Jump to mark |
| `''` | Jump to last position |

---

## ✂️ Editing (Normal Mode)

### Delete

| Key | Action |
|-----|--------|
| `x` | Delete character |
| `X` | Delete character before |
| `dd` | Delete line |
| `D` | Delete to end of line |
| `dw` | Delete word |
| `d$` | Delete to end of line |
| `d0` | Delete to beginning of line |
| `dG` | Delete to end of file |
| `dgg` | Delete to beginning of file |

### Copy (Yank)

| Key | Action |
|-----|--------|
| `yy` or `Y` | Yank (copy) line |
| `yw` | Yank word |
| `y$` | Yank to end of line |
| `y0` | Yank to beginning of line |

### Paste

| Key | Action |
|-----|--------|
| `p` | Paste after cursor |
| `P` | Paste before cursor |

### Change

| Key | Action |
|-----|--------|
| `cc` | Change entire line |
| `cw` | Change word |
| `c$` or `C` | Change to end of line |
| `c0` | Change to beginning of line |
| `ci"` | Change inside quotes |
| `ci(` | Change inside parentheses |
| `ca"` | Change around quotes |

### Other Edits

| Key | Action |
|-----|--------|
| `r` | Replace single character |
| `R` | Replace mode (overwrite) |
| `J` | Join lines |
| `~` | Toggle case |
| `u` | Undo |
| `Ctrl+r` | Redo |
| `.` | Repeat last command |

---

## 👁️ Visual Mode

### Enter Visual Mode

| Key | Action |
|-----|--------|
| `v` | Character-wise visual |
| `V` | Line-wise visual |
| `Ctrl+v` | Block visual |

### Visual Mode Actions

| Key | Action |
|-----|--------|
| `d` | Delete selected |
| `y` | Yank selected |
| `c` | Change selected |
| `>` | Indent right |
| `<` | Indent left |
| `u` | Lowercase |
| `U` | Uppercase |
| `~` | Toggle case |

---

## 🔍 Search and Replace

### Search

| Command | Action |
|---------|--------|
| `/pattern` | Search forward |
| `?pattern` | Search backward |
| `n` | Next match |
| `N` | Previous match |
| `*` | Search word under cursor |
| `#` | Search word backward |

### Search Options

```vim
" Case insensitive search
/pattern\c

" Case sensitive search
/pattern\C

" Very magic mode (regex)
/\vpattern
```

### Replace (Substitute)

```vim
" Replace first occurrence on line
:s/old/new/

" Replace all on line
:s/old/new/g

" Replace all in file
:%s/old/new/g

" Replace with confirmation
:%s/old/new/gc

" Replace case insensitive
:%s/old/new/gi

" Replace in range (lines 5-10)
:5,10s/old/new/g

" Replace in visual selection
:'<,'>s/old/new/g
```

---

## 📁 File Operations

### Save and Quit

| Command | Action |
|---------|--------|
| `:w` | Save |
| `:w filename` | Save as |
| `:q` | Quit |
| `:q!` | Quit without saving |
| `:wq` or `:x` | Save and quit |
| `ZZ` | Save and quit (normal mode) |
| `ZQ` | Quit without saving (normal mode) |
| `:wa` | Save all files |
| `:qa` | Quit all files |

### File Navigation

| Command | Action |
|---------|--------|
| `:e filename` | Edit file |
| `:e!` | Reload current file |
| `:bn` | Next buffer |
| `:bp` | Previous buffer |
| `:ls` | List buffers |
| `:b1` | Go to buffer 1 |
| `:bd` | Close buffer |

### Split Windows

| Command | Action |
|---------|--------|
| `:sp` or `:split` | Horizontal split |
| `:vsp` or `:vsplit` | Vertical split |
| `Ctrl+w s` | Horizontal split |
| `Ctrl+w v` | Vertical split |
| `Ctrl+w w` | Switch windows |
| `Ctrl+w h/j/k/l` | Navigate windows |
| `Ctrl+w q` | Close window |
| `Ctrl+w =` | Equal size windows |
| `Ctrl+w +/-` | Resize height |
| `Ctrl+w >/<` | Resize width |

### Tabs

| Command | Action |
|---------|--------|
| `:tabnew` | New tab |
| `:tabedit file` | Edit in new tab |
| `:tabn` or `gt` | Next tab |
| `:tabp` or `gT` | Previous tab |
| `:tabclose` | Close tab |

---

## 📋 Registers

### Using Registers

| Command | Action |
|---------|--------|
| `"ayy` | Yank line to register 'a' |
| `"ap` | Paste from register 'a' |
| `"+y` | Yank to system clipboard |
| `"+p` | Paste from system clipboard |
| `:reg` | Show all registers |

### Special Registers

| Register | Content |
|----------|---------|
| `"` | Default register |
| `0` | Last yank |
| `1-9` | Delete history |
| `+` | System clipboard |
| `*` | Primary selection |
| `/` | Last search |
| `:` | Last command |
| `.` | Last inserted text |
| `%` | Current filename |

---

## 📍 Marks

| Command | Action |
|---------|--------|
| `ma` | Set mark 'a' |
| `` `a `` | Jump to mark 'a' |
| `'a` | Jump to line of mark 'a' |
| `:marks` | List all marks |
| `` `. `` | Jump to last change |
| `` `" `` | Jump to last exit position |

---

## 🔧 Useful Commands

### Text Objects

Use with operators like `d`, `c`, `y`:

| Object | Meaning |
|--------|---------|
| `iw` | Inner word |
| `aw` | A word (with space) |
| `is` | Inner sentence |
| `as` | A sentence |
| `ip` | Inner paragraph |
| `ap` | A paragraph |
| `i"` | Inside quotes |
| `a"` | Around quotes |
| `i(` or `ib` | Inside parentheses |
| `a(` or `ab` | Around parentheses |
| `i{` or `iB` | Inside braces |
| `a{` or `aB` | Around braces |
| `it` | Inside tag |
| `at` | Around tag |

```vim
" Delete inside quotes
di"

" Change inside parentheses
ci(

" Yank around word
yaw

" Delete paragraph
dap
```

### Macros

| Command | Action |
|---------|--------|
| `qa` | Start recording to 'a' |
| `q` | Stop recording |
| `@a` | Play macro 'a' |
| `@@` | Repeat last macro |
| `10@a` | Play macro 10 times |

### Folding

| Command | Action |
|---------|--------|
| `zf` | Create fold |
| `zo` | Open fold |
| `zc` | Close fold |
| `za` | Toggle fold |
| `zR` | Open all folds |
| `zM` | Close all folds |

---

## ⚙️ Configuration

### Common Settings

```vim
" Show line numbers
:set number
:set nu

" Relative line numbers
:set relativenumber

" Syntax highlighting
:syntax on

" Search highlighting
:set hlsearch

" Incremental search
:set incsearch

" Ignore case in search
:set ignorecase

" Smart case search
:set smartcase

" Auto indent
:set autoindent
:set smartindent

" Tab settings
:set tabstop=4
:set shiftwidth=4
:set expandtab

" Show matching brackets
:set showmatch

" Word wrap
:set wrap
:set nowrap
```

### vimrc Example

```vim
" ~/.vimrc
set number
set relativenumber
syntax on
set hlsearch
set incsearch
set ignorecase
set smartcase
set autoindent
set tabstop=4
set shiftwidth=4
set expandtab
set showmatch
set cursorline
set wildmenu
```

---

## 🎓 Quick Tips

```vim
" Indent multiple lines
>> " Indent current line
3>> " Indent 3 lines
Vjj> " Visual select and indent

" Sort lines
:sort

" Remove duplicate lines
:sort u

" Execute shell command
:!ls

" Insert shell output
:r !date

" Open file under cursor
gf

" Open URL under cursor
gx

" Spell check
:set spell
]s " Next misspelling
[s " Previous misspelling
z= " Suggest corrections
zg " Add word to dictionary

" Format paragraph
gq}

" Count occurrences
:%s/pattern//gn

" Delete all blank lines
:g/^$/d

" Delete lines matching pattern
:g/pattern/d

" Delete lines NOT matching pattern
:v/pattern/d

" Run command on all lines matching pattern
:g/pattern/normal @q

" Reverse all lines
:g/^/m0

" Number all lines
:%!nl

" Convert tabs to spaces
:retab

" Remove trailing whitespace
:%s/\s\+$//e

" Join all lines into one
:%j

" Split line at cursor
i<Enter><Esc>

" Duplicate current line
yyp

" Duplicate and comment
yypkI// <Esc>j

" Swap two characters
xp

" Swap two lines
ddp

" Swap two words
dawwP

" Change word under cursor globally
* cw <new_word> <Esc> n.n.n.

" Record and replay complex edit
qa ... q  (record)
@a        (replay)
@@        (repeat)

" Increment/decrement number
Ctrl+a    (increment)
Ctrl+x    (decrement)

" Insert sequence of numbers
:put =range(1,10)
```

---

## 🔌 Plugins (Popular)

### Plugin Managers

```vim
" vim-plug (recommended)
" Install: curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"   https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

" In .vimrc:
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-sensible'
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf.vim'
call plug#end()

" Commands: :PlugInstall, :PlugUpdate, :PlugClean
```

### Essential Plugins

| Plugin | Description |
|--------|-------------|
| `vim-sensible` | Sensible defaults |
| `NERDTree` | File explorer |
| `fzf.vim` | Fuzzy finder |
| `vim-airline` | Status bar |
| `vim-gitgutter` | Git diff markers |
| `vim-surround` | Surround text objects |
| `vim-commentary` | Easy commenting |
| `coc.nvim` | Autocomplete |

---

## 🎨 Color Schemes

```vim
" Set colorscheme
:colorscheme desert

" Popular schemes
:colorscheme molokai
:colorscheme solarized
:colorscheme gruvbox
:colorscheme dracula
:colorscheme nord

" View available schemes
:colorscheme <Tab>
```

---

## ⚡ Advanced Features

### Multiple Files

```vim
" Open multiple files
vim file1.txt file2.txt file3.txt

" Navigate between files
:n          " Next file
:N          " Previous file
:args       " List files

" Add file to argument list
:argadd file.txt

" Edit all .txt files
:args *.txt
```

### Diff Mode

```vim
" Open vim diff
vimdiff file1.txt file2.txt

" In vim:
:diffthis   " Add buffer to diff
:diffoff    " Remove from diff

" Navigate differences
]c          " Next change
[c          " Previous change
do          " Obtain (get change from other)
dp          " Put (push change to other)
```

### Session Management

```vim
" Save session
:mksession! session.vim

" Load session
vim -S session.vim
:source session.vim
```

### Encryption

```vim
" Encrypt file
:X
(enter password twice)
:w

" Open encrypted file
vim encrypted.txt
(enter password)

" Remove encryption
:set key=
:w
```

---

## 🆘 Help

```vim
" Open help
:help

" Help for command
:help :w
:help dd

" Help for key
:help i
:help CTRL-R

" Search help
:helpgrep pattern
```

---

**📖 Related Resources:**
- [Essential Commands Cheatsheet](essential-commands.md)
- [Text Editors Module](../04-text-processing/text-editors.md)
