# File Conversion

Convert files between different formats.

## 📖 Table of Contents

- [Image Conversion](#image-conversion)
- [Document Conversion](#document-conversion)
- [Media Conversion](#media-conversion)
- [Text Encoding](#text-encoding)
- [Data Format Conversion](#data-format-conversion)

---

## Image Conversion

### ImageMagick (convert)

The Swiss Army knife for image manipulation.

#### Installation

```bash
# Debian/Ubuntu
$ sudo apt install imagemagick

# RHEL/Fedora
$ sudo dnf install ImageMagick

# macOS
$ brew install imagemagick
```

#### Basic Conversions

```bash
# Convert format
$ convert image.png image.jpg
$ convert photo.jpg photo.webp

# Resize
$ convert image.jpg -resize 800x600 resized.jpg
$ convert image.jpg -resize 50% half.jpg

# Resize preserving aspect ratio
$ convert image.jpg -resize 800x600\> resized.jpg

# Quality (for JPEG)
$ convert image.png -quality 85 image.jpg
```

#### Batch Operations

```bash
# Convert all PNG to JPG
$ for f in *.png; do convert "$f" "${f%.png}.jpg"; done

# Using mogrify (modifies in place)
$ mogrify -format jpg *.png

# Resize all images
$ mogrify -resize 800x600 *.jpg
```

#### Advanced Operations

```bash
# Add border
$ convert image.jpg -border 10x10 -bordercolor black bordered.jpg

# Add watermark
$ convert image.jpg -font Arial -pointsize 36 \
    -draw "text 10,50 'Copyright'" watermarked.jpg

# Create thumbnail
$ convert image.jpg -thumbnail 200x200 thumb.jpg

# Rotate
$ convert image.jpg -rotate 90 rotated.jpg

# Combine images
$ convert image1.jpg image2.jpg +append horizontal.jpg
$ convert image1.jpg image2.jpg -append vertical.jpg
```

---

## Document Conversion

### Pandoc

Universal document converter.

#### Installation

```bash
# Debian/Ubuntu
$ sudo apt install pandoc

# RHEL/Fedora
$ sudo dnf install pandoc

# macOS
$ brew install pandoc
```

#### Basic Conversions

```bash
# Markdown to HTML
$ pandoc document.md -o document.html

# Markdown to PDF (requires LaTeX)
$ pandoc document.md -o document.pdf

# Markdown to Word
$ pandoc document.md -o document.docx

# Word to Markdown
$ pandoc document.docx -o document.md

# HTML to Markdown
$ pandoc page.html -o page.md
```

#### With Templates and Styling

```bash
# HTML with custom CSS
$ pandoc document.md -o document.html --css=style.css

# PDF with table of contents
$ pandoc document.md -o document.pdf --toc

# Standalone HTML (includes CSS)
$ pandoc document.md -o document.html -s

# With metadata
$ pandoc document.md -o document.pdf \
    --metadata title="My Document" \
    --metadata author="John Doe"
```

### LibreOffice (Command Line)

```bash
# Convert Word to PDF
$ libreoffice --headless --convert-to pdf document.docx

# Convert to different formats
$ libreoffice --headless --convert-to txt document.docx
$ libreoffice --headless --convert-to html document.docx

# Batch conversion
$ libreoffice --headless --convert-to pdf *.docx
```

---

## Media Conversion

### FFmpeg

Powerful audio/video converter.

#### Installation

```bash
# Debian/Ubuntu
$ sudo apt install ffmpeg

# RHEL/Fedora
$ sudo dnf install ffmpeg

# macOS
$ brew install ffmpeg
```

#### Video Conversions

```bash
# Convert video format
$ ffmpeg -i input.avi output.mp4

# Convert with specific codec
$ ffmpeg -i input.mov -c:v libx264 -c:a aac output.mp4

# Change resolution
$ ffmpeg -i input.mp4 -vf scale=1280:720 output_720p.mp4

# Extract audio from video
$ ffmpeg -i video.mp4 -vn -acodec mp3 audio.mp3

# Compress video
$ ffmpeg -i input.mp4 -crf 28 output.mp4
```

#### Audio Conversions

```bash
# Convert audio format
$ ffmpeg -i audio.wav audio.mp3
$ ffmpeg -i audio.flac audio.mp3

# Change bitrate
$ ffmpeg -i audio.mp3 -b:a 192k output.mp3

# Convert to mono
$ ffmpeg -i stereo.mp3 -ac 1 mono.mp3
```

#### Advanced Operations

```bash
# Cut video (from 00:30 to 01:00)
$ ffmpeg -i input.mp4 -ss 00:00:30 -to 00:01:00 -c copy clip.mp4

# Merge videos
$ ffmpeg -f concat -i list.txt -c copy merged.mp4

# Create GIF from video
$ ffmpeg -i video.mp4 -vf "fps=10,scale=320:-1" output.gif

# Add subtitles
$ ffmpeg -i video.mp4 -vf subtitles=subs.srt output.mp4
```

---

## Text Encoding

### iconv

Convert text between character encodings.

```bash
# UTF-8 to Latin1
$ iconv -f UTF-8 -t ISO-8859-1 input.txt > output.txt

# Latin1 to UTF-8
$ iconv -f ISO-8859-1 -t UTF-8 input.txt > output.txt

# List available encodings
$ iconv -l

# With error handling
$ iconv -f UTF-8 -t ASCII//TRANSLIT input.txt > output.txt
```

### dos2unix / unix2dos

Convert line endings.

```bash
# Convert Windows to Unix (CRLF to LF)
$ dos2unix file.txt

# Convert Unix to Windows (LF to CRLF)
$ unix2dos file.txt

# Convert in place
$ dos2unix -n input.txt output.txt

# Using sed
$ sed -i 's/\r$//' file.txt          # DOS to Unix
$ sed -i 's/$/\r/' file.txt          # Unix to DOS

# Using tr
$ tr -d '\r' < windows.txt > unix.txt
```

---

## Data Format Conversion

### jq - JSON Processor

```bash
# Install
$ sudo apt install jq

# Pretty print JSON
$ cat data.json | jq '.'

# Convert JSON to CSV-like output
$ jq -r '.[] | [.name, .age] | @csv' data.json

# Extract fields
$ jq '.users[].name' data.json
```

### CSV Processing

```bash
# Using awk
$ awk -F',' '{print $1, $3}' data.csv

# Convert CSV to JSON (using jq)
$ cat data.csv | jq -Rsn '
    [inputs | split("\n") | .[] | select(length > 0) | split(",")]
    | .[0] as $header
    | .[1:] | map([$header, .] | transpose | map({(.[0]): .[1]}) | add)
'

# Using csvkit (install: pip install csvkit)
$ csvjson data.csv > data.json
$ csvformat -T data.csv > data.tsv
```

### XML Processing

```bash
# Using xmllint
$ xmllint --format ugly.xml > pretty.xml

# Extract data with xpath
$ xmllint --xpath "//name/text()" data.xml

# Convert XML to JSON (using yq)
$ yq -p xml -o json data.xml
```

---

## Practical Examples

### Batch Image Optimization

```bash
#!/bin/bash
# Optimize images for web

for img in *.jpg; do
    convert "$img" -resize 1920x1080\> -quality 85 "optimized_$img"
done
```

### Convert Markdown Documentation

```bash
#!/bin/bash
# Convert all markdown files to HTML

for md in docs/*.md; do
    html="${md%.md}.html"
    pandoc "$md" -o "$html" -s --toc --css=style.css
done
```

### Video Compression Script

```bash
#!/bin/bash
# Compress videos for sharing

for video in *.mp4; do
    ffmpeg -i "$video" -crf 28 -preset medium "compressed_$video"
done
```

---

## 🏋️ Practice Exercises

1. Convert a PNG image to JPEG with 80% quality
2. Resize all images in a directory to max 800px width
3. Convert a Markdown file to HTML with a table of contents
4. Extract audio from a video file
5. Convert a file from Windows line endings to Unix

### Solutions

```bash
# Exercise 1
convert image.png -quality 80 image.jpg

# Exercise 2
mogrify -resize 800x\> *.jpg

# Exercise 3
pandoc README.md -o README.html -s --toc

# Exercise 4
ffmpeg -i video.mp4 -vn -acodec mp3 audio.mp3

# Exercise 5
dos2unix file.txt
# or: sed -i 's/\r$//' file.txt
```

---

## 🔗 Next Topic

Continue to [System Information](system-info.md) →
