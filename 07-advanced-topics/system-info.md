# System Information

Commands to gather detailed system information.

## 📖 Table of Contents

- [CPU Information](#cpu-information)
- [Memory Information](#memory-information)
- [Disk Information](#disk-information)
- [Hardware Information](#hardware-information)
- [Network Information](#network-information)
- [System Overview](#system-overview)

---

## CPU Information

### lscpu

Detailed CPU architecture information.

```bash
$ lscpu
Architecture:          x86_64
CPU op-mode(s):        32-bit, 64-bit
CPU(s):                8
Thread(s) per core:    2
Core(s) per socket:    4
Socket(s):             1
Model name:            Intel(R) Core(TM) i7-8550U CPU @ 1.80GHz
CPU MHz:               1992.000
CPU max MHz:           4000.0000
CPU min MHz:           400.0000
L1d cache:             32K
L1i cache:             32K
L2 cache:              256K
L3 cache:              8192K
```

### /proc/cpuinfo

```bash
# View all CPU details
$ cat /proc/cpuinfo

# Count CPUs
$ grep -c processor /proc/cpuinfo

# Get model name
$ grep "model name" /proc/cpuinfo | head -1

# Get CPU frequency
$ grep "cpu MHz" /proc/cpuinfo
```

### CPU Usage

```bash
# Real-time CPU usage
$ top
$ htop

# CPU statistics
$ mpstat 1        # Every 1 second
$ mpstat -P ALL   # Per-core stats

# Average load
$ cat /proc/loadavg
$ uptime
```

---

## Memory Information

### free

Display memory usage.

```bash
$ free -h
              total        used        free      shared  buff/cache   available
Mem:          7.8Gi       3.2Gi       1.5Gi       512Mi       3.1Gi       3.8Gi
Swap:         2.0Gi          0B       2.0Gi
```

### Options

```bash
# Human readable
$ free -h

# Show in megabytes
$ free -m

# Show in gigabytes
$ free -g

# Show total
$ free -t

# Continuous update
$ free -s 2    # Every 2 seconds
```

### /proc/meminfo

```bash
# Detailed memory info
$ cat /proc/meminfo

# Specific values
$ grep MemTotal /proc/meminfo
$ grep MemFree /proc/meminfo
$ grep MemAvailable /proc/meminfo
```

### vmstat

Virtual memory statistics.

```bash
$ vmstat
procs -----------memory---------- ---swap-- -----io---- -system-- ------cpu-----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa st
 1  0      0 1574896 245896 3201748    0    0    12    15  187  456  3  1 96  0  0

# Update every 1 second
$ vmstat 1

# With timestamps
$ vmstat -t 1
```

---

## Disk Information

### df

Display disk space usage.

```bash
$ df -h
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda1        50G   25G   23G  53% /
/dev/sda2       200G  150G   40G  79% /home
tmpfs           3.9G  1.2M  3.9G   1% /run

# All filesystems
$ df -ha

# Filesystem type
$ df -hT

# Inode usage
$ df -i
```

### du

Disk usage by directory.

```bash
# Directory size
$ du -sh /home/john
4.2G    /home/john

# All subdirectories
$ du -h /home/john --max-depth=1

# Sort by size
$ du -sh /home/* | sort -h

# Largest directories
$ du -h / --max-depth=1 2>/dev/null | sort -h | tail -10
```

### lsblk

List block devices.

```bash
$ lsblk
NAME   MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
sda      8:0    0 256.2G  0 disk
├─sda1   8:1    0    50G  0 part /
├─sda2   8:2    0   200G  0 part /home
└─sda3   8:3    0   6.2G  0 part [SWAP]
nvme0n1 259:0    0 476.9G  0 disk
└─nvme0n1p1 259:1  0 476.9G  0 part /data

# With filesystem info
$ lsblk -f

# All info
$ lsblk -a
```

### fdisk / gdisk

Partition information.

```bash
# List partitions
$ sudo fdisk -l

# Specific disk
$ sudo fdisk -l /dev/sda

# GPT partitions
$ sudo gdisk -l /dev/sda
```

---

## Hardware Information

### lspci

PCI devices (graphics, network, etc.).

```bash
$ lspci
00:00.0 Host bridge: Intel Corporation...
00:02.0 VGA compatible controller: Intel Corporation...
00:1f.3 Audio device: Intel Corporation...

# Verbose
$ lspci -v

# Very verbose
$ lspci -vv

# Show kernel driver
$ lspci -k

# Filter by type
$ lspci | grep -i vga
$ lspci | grep -i network
```

### lsusb

USB devices.

```bash
$ lsusb
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 004: ID 046d:c52b Logitech, Inc. Unifying Receiver

# Verbose
$ lsusb -v

# Tree view
$ lsusb -t
```

### lshw

Comprehensive hardware list (requires root).

```bash
# Full hardware list
$ sudo lshw

# Short format
$ sudo lshw -short

# Specific class
$ sudo lshw -class memory
$ sudo lshw -class network
$ sudo lshw -class disk

# HTML output
$ sudo lshw -html > hardware.html
```

### dmidecode

BIOS/DMI information.

```bash
# All info
$ sudo dmidecode

# System info
$ sudo dmidecode -t system

# BIOS info
$ sudo dmidecode -t bios

# Memory info
$ sudo dmidecode -t memory

# Processor
$ sudo dmidecode -t processor
```

---

## Network Information

### ip

Modern network configuration.

```bash
# Show all interfaces
$ ip addr
$ ip a

# Brief format
$ ip -br addr

# Show specific interface
$ ip addr show eth0

# Show routing table
$ ip route
$ ip r

# Show neighbors (ARP)
$ ip neigh
```

### ss

Socket statistics (replaces netstat).

```bash
# All connections
$ ss

# Listening ports
$ ss -l

# TCP connections
$ ss -t

# UDP connections
$ ss -u

# Show process using port
$ ss -ltnp

# Specific port
$ ss -ltnp | grep :80
```

### Network Configuration Files

```bash
# Hostname
$ cat /etc/hostname
$ hostnamectl

# DNS
$ cat /etc/resolv.conf

# Hosts file
$ cat /etc/hosts

# Network interfaces (varies by distro)
$ cat /etc/network/interfaces           # Debian
$ cat /etc/sysconfig/network-scripts/*  # RHEL
```

---

## System Overview

### uname

System information.

```bash
# All info
$ uname -a
Linux hostname 5.15.0-generic #1 SMP x86_64 GNU/Linux

# Kernel name
$ uname -s

# Kernel release
$ uname -r

# Machine architecture
$ uname -m

# Operating system
$ uname -o
```

### hostnamectl

System hostname and info.

```bash
$ hostnamectl
   Static hostname: myserver
         Icon name: computer-laptop
           Chassis: laptop
        Machine ID: abc123...
           Boot ID: def456...
  Operating System: Ubuntu 22.04.1 LTS
            Kernel: Linux 5.15.0-generic
      Architecture: x86-64
```

### uptime

System uptime and load.

```bash
$ uptime
 14:30:00 up 5 days, 2:30,  1 user,  load average: 0.15, 0.10, 0.05

# Pretty format
$ uptime -p
up 5 days, 2 hours, 30 minutes

# Since boot
$ uptime -s
2024-11-28 12:00:00
```

### dmesg

Kernel messages.

```bash
# View kernel messages
$ dmesg

# Follow new messages
$ dmesg -w

# Human-readable timestamps
$ dmesg -T

# Filter by level
$ dmesg --level=err

# Search hardware
$ dmesg | grep -i usb
$ dmesg | grep -i eth
```

---

## Quick Reference Script

```bash
#!/bin/bash
# Quick system info script

echo "=== SYSTEM ==="
uname -a
echo ""

echo "=== CPU ==="
lscpu | grep -E "^(Architecture|CPU\(s\)|Model name)"
echo ""

echo "=== MEMORY ==="
free -h | head -2
echo ""

echo "=== DISK ==="
df -h / /home 2>/dev/null
echo ""

echo "=== NETWORK ==="
ip -br addr | grep -v "^lo"
echo ""

echo "=== UPTIME ==="
uptime -p
```

---

## 🏋️ Practice Exercises

1. Find your CPU model and number of cores
2. Check available memory and swap usage
3. Find the largest directories in /var
4. List all USB devices
5. Find your system's external IP address

### Solutions

```bash
# Exercise 1
lscpu | grep -E "Model name|^CPU\(s\)"

# Exercise 2
free -h

# Exercise 3
sudo du -h /var --max-depth=1 2>/dev/null | sort -h | tail -10

# Exercise 4
lsusb

# Exercise 5
curl -s https://api.ipify.org
# or: dig +short myip.opendns.com @resolver1.opendns.com
```

---

## 🔗 Next Topic

Continue to [Exercises](exercises.md) →
