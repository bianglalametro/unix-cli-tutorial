# User Management

Learn to identify users and manage your account on a UNIX/Linux system.

## 📖 Table of Contents

- [whoami - Current User](#whoami---current-user)
- [who - Logged-in Users](#who---logged-in-users)
- [w - User Activity](#w---user-activity)
- [id - User Identity](#id---user-identity)
- [groups - Group Membership](#groups---group-membership)
- [passwd - Change Password](#passwd---change-password)
- [finger - User Information](#finger---user-information)
- [last - Login History](#last---login-history)

---

## whoami - Current User

The simplest way to find out who you're logged in as.

### Syntax
```bash
whoami
```

### Example

```bash
$ whoami
john

# Same result using environment variable
$ echo $USER
john
```

### 💡 Use Case

Useful in scripts to determine which user is running them:

```bash
if [ "$(whoami)" = "root" ]; then
    echo "Running as root"
else
    echo "Running as regular user: $(whoami)"
fi
```

---

## who - Logged-in Users

Shows who is currently logged into the system.

### Syntax
```bash
who [options]
```

### Examples

```bash
# Basic usage
$ who
john     pts/0        2024-12-03 08:00 (192.168.1.10)
jane     pts/1        2024-12-03 08:30 (192.168.1.11)

# Show column headers
$ who -H
NAME     LINE         TIME             COMMENT
john     pts/0        2024-12-03 08:00 (192.168.1.10)
jane     pts/1        2024-12-03 08:30 (192.168.1.11)

# Count logged-in users
$ who -q
john jane
# users=2

# Show current runlevel
$ who -r
         run-level 5  2024-12-03 07:00

# Show boot time
$ who -b
         system boot  2024-12-03 07:00
```

### Output Fields

| Field | Description |
|-------|-------------|
| NAME | Username |
| LINE | Terminal name |
| TIME | Login time |
| COMMENT | Remote host (if any) |

### Options

| Option | Description |
|--------|-------------|
| `-H` | Print column headers |
| `-q` | Quick mode, count users |
| `-b` | Show last system boot time |
| `-r` | Show current runlevel |
| `-a` | Show all information |

---

## w - User Activity

Shows who is logged in AND what they're doing.

### Syntax
```bash
w [options] [user]
```

### Example

```bash
$ w
 08:30:00 up 1:30,  2 users,  load average: 0.15, 0.10, 0.05
USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU WHAT
john     pts/0    192.168.1.10     08:00    0.00s  0.10s  0.01s w
jane     pts/1    192.168.1.11     08:30    5:00   0.05s  0.02s vim report.txt
```

### Output Fields

| Field | Description |
|-------|-------------|
| USER | Username |
| TTY | Terminal |
| FROM | Remote host |
| LOGIN@ | Login time |
| IDLE | Idle time |
| JCPU | Total CPU time for all processes |
| PCPU | CPU time for current process |
| WHAT | Current command |

### Header Information

- **08:30:00** - Current time
- **up 1:30** - System uptime
- **2 users** - Number of logged-in users
- **load average** - System load (1, 5, 15 minutes)

---

## id - User Identity

Shows user and group IDs.

### Syntax
```bash
id [options] [username]
```

### Examples

```bash
# Current user's IDs
$ id
uid=1000(john) gid=1000(john) groups=1000(john),27(sudo),44(video)

# Specific components
$ id -u          # User ID only
1000

$ id -g          # Primary group ID only
1000

$ id -G          # All group IDs
1000 27 44

$ id -un         # Username only
john

$ id -gn         # Primary group name only
john

# Another user's information
$ id jane
uid=1001(jane) gid=1001(jane) groups=1001(jane),27(sudo)
```

### Options

| Option | Description |
|--------|-------------|
| `-u` | Print user ID |
| `-g` | Print primary group ID |
| `-G` | Print all group IDs |
| `-n` | Print name instead of number |

### Understanding the Output

```
uid=1000(john) gid=1000(john) groups=1000(john),27(sudo),44(video)
│         │         │              │              │          │
│         │         │              │              │          └─ video group (ID 44)
│         │         │              │              └─ sudo group (ID 27)
│         │         │              └─ Primary group (john, ID 1000)
│         │         └─ Primary group ID
│         └─ Username
└─ User ID
```

---

## groups - Group Membership

Shows the groups a user belongs to.

### Syntax
```bash
groups [username...]
```

### Examples

```bash
# Current user's groups
$ groups
john sudo video audio

# Specific user's groups
$ groups jane
jane : jane sudo developers
```

### 💡 Why Groups Matter

Groups control access to files and resources. Common groups include:

| Group | Purpose |
|-------|---------|
| `sudo` | Administrative privileges |
| `docker` | Docker container management |
| `www-data` | Web server files |
| `video` | Graphics/video hardware |
| `audio` | Sound hardware |

---

## passwd - Change Password

Change your password or manage other users' passwords.

### Syntax
```bash
passwd [options] [username]
```

### Changing Your Password

```bash
$ passwd
Changing password for john.
Current password: [enter current password]
New password: [enter new password]
Retype new password: [confirm new password]
passwd: password updated successfully
```

### Password Requirements

Most systems enforce:
- Minimum length (usually 8+ characters)
- Mix of uppercase and lowercase
- Numbers and special characters
- Not based on dictionary words
- Different from previous passwords

### Options (for administrators)

| Option | Description |
|--------|-------------|
| `-l` | Lock an account |
| `-u` | Unlock an account |
| `-d` | Delete password (passwordless) |
| `-e` | Expire password (force change) |
| `-S` | Display password status |

### ⚠️ Warning

- Never share your password
- Don't use the same password everywhere
- Consider using a password manager

---

## finger - User Information

Displays information about users (may not be installed by default).

### Syntax
```bash
finger [options] [username...]
```

### Example

```bash
$ finger john
Login: john          		Name: John Doe
Directory: /home/john       	Shell: /bin/bash
On since Wed Dec  3 08:00 (UTC) on pts/0 from 192.168.1.10
   15 seconds idle
No mail.
No Plan.
```

### Installing finger

```bash
# Debian/Ubuntu
$ sudo apt install finger

# RHEL/Fedora
$ sudo dnf install finger
```

---

## last - Login History

Shows the history of user logins.

### Syntax
```bash
last [options] [username] [tty]
```

### Examples

```bash
# Show all login history
$ last
john     pts/0        192.168.1.10     Wed Dec  3 08:00   still logged in
jane     pts/1        192.168.1.11     Wed Dec  3 07:30 - 08:00  (00:30)
reboot   system boot  5.15.0-generic   Wed Dec  3 07:00   still running

# Show specific user
$ last john

# Show last 5 logins
$ last -n 5

# Show bad login attempts
$ sudo lastb
```

### Options

| Option | Description |
|--------|-------------|
| `-n N` | Show only N entries |
| `-x` | Show system shutdowns and runlevel changes |
| `-R` | Don't display hostname |
| `-a` | Display hostname in last column |

---

## 📝 Important Files

| File | Description |
|------|-------------|
| `/etc/passwd` | User account information |
| `/etc/shadow` | Encrypted passwords |
| `/etc/group` | Group information |
| `/etc/login.defs` | Login defaults |

### Viewing /etc/passwd

```bash
$ cat /etc/passwd
root:x:0:0:root:/root:/bin/bash
john:x:1000:1000:John Doe:/home/john:/bin/bash
```

Fields (separated by colons):
1. Username
2. Password (x = stored in /etc/shadow)
3. User ID (UID)
4. Group ID (GID)
5. Full name/comment
6. Home directory
7. Login shell

---

## 🏋️ Practice Exercises

1. Find your username using three different methods
2. List all users currently logged into your system
3. Find out which groups you belong to
4. Display your user ID and group ID numbers
5. View the login history for your system

### Solutions

```bash
# Exercise 1
whoami
echo $USER
id -un

# Exercise 2
who
# or
w

# Exercise 3
groups
# or
id -Gn

# Exercise 4
id -u    # User ID
id -g    # Group ID

# Exercise 5
last
```

---

## 🔗 Next Topic

Continue to [Communication](communication.md) →
