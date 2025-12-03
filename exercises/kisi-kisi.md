# 📋 Kisi-Kisi Materi UNIX/Linux CLI

> Daftar perintah penting yang harus dikuasai untuk ujian praktikum

---

## 🎯 Topik Utama

Berikut adalah daftar perintah yang perlu dipelajari dan dikuasai, dikelompokkan berdasarkan topik:

---

## 1️⃣ Informasi Sistem Dasar

| Perintah | Fungsi |
|----------|--------|
| `echo` | Menampilkan teks ke layar |
| `hostname` | Menampilkan nama host komputer |
| `uname` | Menampilkan informasi sistem operasi |
| `date` | Menampilkan tanggal dan waktu |
| `cal` | Menampilkan kalender |
| `who` | Menampilkan pengguna yang sedang login |

**Contoh:**
```bash
echo "Hello World"
hostname
uname -a
date
cal
who
```

---

## 2️⃣ Navigasi Direktori

| Perintah | Fungsi |
|----------|--------|
| `cd` | Pindah direktori (change directory) |
| `pwd` | Menampilkan direktori saat ini (print working directory) |
| `ls` | Menampilkan isi direktori (list) |
| `touch` | Membuat file kosong / update timestamp |

**Contoh:**
```bash
cd /home/user
cd ..
cd ~
pwd
ls -la
touch file.txt
```

---

## 3️⃣ Operasi File dan Direktori

| Perintah | Fungsi |
|----------|--------|
| `cp` | Menyalin file/direktori (copy) |
| `mv` | Memindahkan/mengubah nama file (move) |
| `rm` | Menghapus file (remove) |
| `mkdir` | Membuat direktori (make directory) |
| `rmdir` | Menghapus direktori kosong (remove directory) |

**Contoh:**
```bash
cp file1.txt file2.txt
cp -r dir1 dir2
mv old.txt new.txt
rm file.txt
rm -rf directory
mkdir newdir
rmdir emptydir
```

---

## 4️⃣ Hak Akses dan Link

| Perintah | Fungsi |
|----------|--------|
| `chmod` | Mengubah hak akses file (change mode) |
| `ln` | Membuat link (hard link / symbolic link) |

**Contoh:**
```bash
chmod 755 script.sh
chmod +x script.sh
chmod u+rwx,g+rx,o+rx file
ln file hardlink
ln -s file symlink
```

---

## 5️⃣ Pencarian File

| Perintah | Fungsi |
|----------|--------|
| `locate` | Mencari file berdasarkan database |
| `find` | Mencari file berdasarkan kriteria |
| `wc` | Menghitung baris, kata, karakter (word count) |

**Contoh:**
```bash
locate passwd
find / -name "*.txt"
find ~ -size +100M
find . -mtime -7
wc -l file.txt
wc -w file.txt
```

---

## 6️⃣ Pemrosesan Teks

| Perintah | Fungsi |
|----------|--------|
| `cat` | Menampilkan isi file (concatenate) |
| `head` | Menampilkan baris awal file |
| `tail` | Menampilkan baris akhir file |
| `sort` | Mengurutkan baris |
| `uniq` | Menghapus baris duplikat |
| `cut` | Memotong kolom/field |
| `tr` | Menerjemahkan/mengganti karakter (translate) |
| `grep` | Mencari pola dalam teks |
| `sed` | Stream editor untuk manipulasi teks |

**Contoh:**
```bash
cat file.txt
head -10 file.txt
tail -5 file.txt
sort file.txt
sort file.txt | uniq
cut -d: -f1 /etc/passwd
tr 'a-z' 'A-Z' < file.txt
grep "pattern" file.txt
grep -r "text" directory/
sed 's/old/new/g' file.txt
```

---

## 7️⃣ Manajemen Proses

| Perintah | Fungsi |
|----------|--------|
| `ps` | Menampilkan daftar proses (process status) |
| `nice` | Menjalankan proses dengan prioritas tertentu |
| `renice` | Mengubah prioritas proses yang sedang berjalan |
| `pidof` | Mencari PID dari nama proses |
| `kill` | Mengirim sinyal ke proses |

**Contoh:**
```bash
ps aux
ps -ef
nice -n 10 ./script.sh
renice -n 5 -p 1234
pidof firefox
kill 1234
kill -9 1234
kill -TERM 1234
```

---

## 8️⃣ Job Control

| Perintah | Fungsi |
|----------|--------|
| `&` | Menjalankan perintah di background |
| `jobs` | Menampilkan daftar job |
| `fg` | Memindahkan job ke foreground |
| `bg` | Melanjutkan job di background |

**Contoh:**
```bash
./longprocess.sh &
jobs
fg %1
bg %1
```

---

## 📊 Ringkasan Berdasarkan Modul

### Modul 1: Dasar-Dasar CLI
```
echo  hostname  uname  date  cal  who
```

### Modul 2: File dan Direktori
```
cd  pwd  ls  touch
cp  mv  rm  mkdir  rmdir
```

### Modul 3: Hak Akses
```
chmod  ln
```

### Modul 4: Pencarian dan Pemrosesan Teks
```
locate  find  wc
cat  head  tail  sort  uniq  cut  tr  grep  sed
```

### Modul 5: Proses dan Job
```
ps  nice  renice  pidof  kill
&  jobs  fg  bg
```

---

## 💡 Tips Persiapan Ujian

1. **Praktikkan semua perintah** di terminal langsung
2. **Hafal opsi penting** dari setiap perintah
3. **Pahami kombinasi perintah** menggunakan pipe (`|`)
4. **Pelajari contoh penggunaan** di dunia nyata
5. **Gunakan `man`** untuk melihat dokumentasi lengkap

---

## 📚 Referensi Cepat

- [Essential Commands Cheatsheet](../cheatsheets/essential-commands.md)
- [File Permissions Cheatsheet](../cheatsheets/file-permissions.md)
- [Latihan Praktis](./latihan-id.md)

---

**Semoga sukses! 🍀**
