# User Communication

Learn how to communicate with other users on a UNIX/Linux system.

## 📖 Table of Contents

- [write - Send Messages](#write---send-messages)
- [wall - Broadcast to All](#wall---broadcast-to-all)
- [mesg - Control Messages](#mesg---control-messages)
- [mail - Send Email](#mail---send-email)
- [Modern Alternatives](#modern-alternatives)

---

## write - Send Messages

Send a message to another logged-in user.

### Syntax
```bash
write user [tty]
```

### How It Works

1. Start a write session to another user
2. Type your message
3. Press `Ctrl + D` to end

### Example

```bash
# Send message to user 'jane'
$ write jane
Hello Jane! 
Are you available for a meeting?
^D    # Press Ctrl+D to end
```

The recipient sees:
```
Message from john@hostname on pts/0 at 08:30 ...
Hello Jane!
Are you available for a meeting?
EOF
```

### Specifying Terminal

If a user is logged in multiple times:

```bash
# Find which terminals jane is on
$ who | grep jane
jane     pts/1        2024-12-03 08:00
jane     pts/2        2024-12-03 08:15

# Send to specific terminal
$ write jane pts/1
```

### 💡 Tips

- Both users must be logged in
- Recipient must have messages enabled (`mesg y`)
- The conversation is one-way; recipient must `write` back
- Use for quick questions or alerts

---

## wall - Broadcast to All

Send a message to ALL logged-in users.

### Syntax
```bash
wall [message]
# or
wall < file
```

### Examples

```bash
# Interactive message
$ wall
System maintenance in 10 minutes.
Please save your work!
^D

# One-line message
$ echo "Server rebooting in 5 minutes" | wall

# From a file
$ wall < announcement.txt
```

### Output (to all users)

```
Broadcast message from john@hostname (pts/0) (Wed Dec  3 08:30:00 2024):

System maintenance in 10 minutes.
Please save your work!
```

### ⚠️ Note

- Usually requires root/sudo for system-wide announcements
- Often used by administrators for maintenance notices
- Some systems restrict wall to privileged users

---

## mesg - Control Messages

Control whether other users can send you messages.

### Syntax
```bash
mesg [y|n]
```

### Examples

```bash
# Check current status
$ mesg
is y    # Messages allowed

# Disable messages
$ mesg n

# Enable messages
$ mesg y
```

### When to Disable Messages

- During important work
- When giving presentations
- When running screen-sharing
- During automated scripts (to prevent interruption)

### 💡 Tip

Add to your `~/.bashrc` to set default behavior:
```bash
# Disable messages by default
mesg n
```

---

## mail - Send Email

Send and read email from the command line.

### Basic Syntax
```bash
# Send mail
mail -s "subject" recipient

# Read mail
mail
```

### Sending Email

```bash
# Interactive mode
$ mail -s "Meeting Tomorrow" jane@example.com
Hi Jane,
Just a reminder about our meeting tomorrow at 10 AM.
Best,
John
^D    # Ctrl+D to send, or . on a line by itself

# Using echo/pipe
$ echo "Your report is ready" | mail -s "Report Status" jane

# From a file
$ mail -s "Log Report" admin@example.com < /var/log/report.txt

# With CC and attachments (if mailx/mailutils installed)
$ mail -s "Report" -c manager@example.com -A report.pdf user@example.com
```

### Reading Email

```bash
$ mail
Mail version 8.1. Type ? for help.
"/var/mail/john": 2 messages 2 new
>N  1 jane@example.com   Wed Dec  3 08:00  20/800  "Re: Meeting"
 N  2 admin@example.com  Wed Dec  3 08:15  15/600  "System Update"
& 1          # Read message 1
& d 2        # Delete message 2
& q          # Quit
```

### Mail Commands (inside mail)

| Command | Description |
|---------|-------------|
| `?` | Show help |
| `1` | Read message 1 |
| `d 1` | Delete message 1 |
| `r 1` | Reply to message 1 |
| `s 1 file` | Save message 1 to file |
| `q` | Quit and save changes |
| `x` | Quit without saving |

### Installing Mail Utilities

```bash
# Debian/Ubuntu
$ sudo apt install mailutils

# RHEL/Fedora
$ sudo dnf install mailx

# Alpine
$ apk add mailx
```

### ⚠️ Note on Email

Command-line mail is typically for:
- System notifications
- Automated scripts
- Server administration

For regular email, most users prefer GUI clients or web-based email.

---

## Modern Alternatives

While traditional UNIX communication tools still work, modern systems often use different tools:

### For System Messages

| Tool | Purpose |
|------|---------|
| `notify-send` | Desktop notifications (Linux GUI) |
| `logger` | Write to system log |
| `systemd-cat` | Log to journald |

### Example: Desktop Notification

```bash
# Linux with GUI
$ notify-send "Alert" "Your backup is complete!"

# macOS
$ osascript -e 'display notification "Backup complete" with title "Alert"'
```

### For Team Communication

- **Slack CLI**: `slack-cli`
- **Teams**: Microsoft Teams CLI tools
- **IRC**: `irssi`, `weechat`
- **Matrix**: `matrix-commander`

### For Alerts and Monitoring

```bash
# Send to Slack webhook
$ curl -X POST -H 'Content-type: application/json' \
    --data '{"text":"Server alert!"}' \
    https://hooks.slack.com/services/XXX/YYY/ZZZ

# Send SMS via Twilio
$ curl -X POST https://api.twilio.com/2010-04-01/Accounts/.../Messages.json \
    -d "To=+1234567890" \
    -d "Body=Server down!"
```

---

## 📋 Communication Methods Comparison

| Method | Recipients | Realtime | Persistent |
|--------|------------|----------|------------|
| `write` | One user | Yes | No |
| `wall` | All users | Yes | No |
| `mail` | Anyone | No | Yes |
| `notify-send` | Self (desktop) | Yes | No |

---

## 🏋️ Practice Exercises

1. Check if your terminal is accepting messages
2. Disable messages, then re-enable them
3. Use `who` to find other logged-in users (if any)
4. Send yourself an email using the mail command
5. Send a broadcast message (if you have permission)

### Solutions

```bash
# Exercise 1
mesg

# Exercise 2
mesg n
mesg
mesg y

# Exercise 3
who

# Exercise 4
echo "Test message" | mail -s "Test" $USER

# Exercise 5 (requires appropriate permissions)
echo "Test broadcast" | wall
```

---

## 🔗 Next Topic

Continue to [Keyboard Shortcuts](shortcuts.md) →
