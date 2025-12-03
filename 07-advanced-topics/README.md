# Module 07: Advanced Topics

Learn compression, file conversion, and system information commands.

## 🎯 Learning Objectives

By the end of this module, you will be able to:
- Compress and archive files with tar, gzip, and zip
- Convert files between different formats
- Gather detailed system information
- Use advanced system utilities

## 📖 Topics Covered

| File | Description | Time |
|------|-------------|------|
| [compression.md](compression.md) | tar, gzip, zip, and more | 30 min |
| [file-conversion.md](file-conversion.md) | convert, ffmpeg, pandoc | 25 min |
| [system-info.md](system-info.md) | System information commands | 25 min |
| [exercises.md](exercises.md) | Practice exercises | 30 min |

## 🗜️ Compression Overview

```
┌─────────────────────────────────────────────────────────────────┐
│                    COMPRESSION METHODS                          │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│   tar                                                           │
│   └── Archives files (no compression)                          │
│                                                                 │
│   gzip / gunzip                                                │
│   └── Compresses single files (.gz)                            │
│                                                                 │
│   tar + gzip                                                   │
│   └── Archive then compress (.tar.gz, .tgz)                    │
│                                                                 │
│   zip / unzip                                                  │
│   └── Archive and compress (cross-platform)                    │
│                                                                 │
│   bzip2                                                        │
│   └── Better compression, slower (.bz2)                        │
│                                                                 │
│   xz                                                           │
│   └── Best compression, slowest (.xz)                          │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

## 🔧 Quick Reference

### Compression Commands

| Task | Command |
|------|---------|
| Create tar archive | `tar -cvf archive.tar files/` |
| Extract tar archive | `tar -xvf archive.tar` |
| Create compressed tar | `tar -czvf archive.tar.gz files/` |
| Extract compressed tar | `tar -xzvf archive.tar.gz` |
| Create zip | `zip -r archive.zip files/` |
| Extract zip | `unzip archive.zip` |
| Compress file | `gzip file` |
| Decompress file | `gunzip file.gz` |

### System Information Commands

| Command | Information |
|---------|-------------|
| `uname -a` | System/kernel info |
| `lscpu` | CPU details |
| `free -h` | Memory usage |
| `df -h` | Disk usage |
| `lsblk` | Block devices |
| `lspci` | PCI devices |
| `lsusb` | USB devices |

## 💡 Tips

1. **Use `tar.gz` for Unix/Linux** - Best compatibility
2. **Use `zip` for sharing with Windows** - Universal format
3. **Use `xz` for archival** - Best compression ratio
4. **Always verify extracts** - Use `-t` to test archives

## ⚠️ Common Mistakes

- Forgetting `-z` flag for .gz files
- Extracting to wrong directory
- Running out of disk space during compression
- Not checking archive integrity before important extracts

## 🔗 Next Steps

Start with:
1. [Compression](compression.md) - Archive and compress files
2. [File Conversion](file-conversion.md) - Convert between formats
3. [System Info](system-info.md) - Gather system information

## 📚 Additional Resources

- [GNU tar Manual](https://www.gnu.org/software/tar/manual/)
- [gzip Documentation](https://www.gnu.org/software/gzip/)
- [Info-ZIP](http://infozip.sourceforge.net/)
