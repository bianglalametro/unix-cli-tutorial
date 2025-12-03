# 📝 Latihan UNIX/Linux CLI

> Latihan praktis dalam Bahasa Indonesia untuk mengasah kemampuan command line

---

## 📁 Latihan Dasar: File dan Direktori

Tuliskan perintah yang tepat untuk setiap instruksi berikut:

```bash
# pindah ke direktori home anda
...

# buat satu folder kosong 'test'
...

# masuk ke direktori 'test'
...

# tampilkan path direktori saat ini
...

# buat file kosong bernama 'empty.txt'
...
```

---

## 📋 Latihan: Operasi File

```bash
# copy file '/etc/timezone' ke direktori ini
...

# ubah nama file 'timezone' menjadi 'tz.txt'
...

# list isi direktori ini
...

# pindah ke direktori parent
...

# hapus direktori 'test' seisinya
...
```

---

## 🔍 Latihan: Pencarian File

```bash
# temukan file dengan nama 'fdisk' memakai `locate`
...

# temukan file dengan nama 'fdisk' memakai `find`
...

# temukan file pada home anda yang ukurannya > 200 MB
...

# temukan file pada home anda yang diubah < 3 hari
...

# temukan file pada home anda yang diakses > 30 hari
...
```

---

## 📄 Latihan: Pemrosesan Teks

```bash
# tampilkan 5 baris pertama keluaran perintah `last`
...

# tampilkan dua baris terakhir file '/etc/passwd'
...

# cari file di '/usr/include' yang memuat kata 'sem_post'
...

# tampilkan kolom 1 dan 5 dari file '/etc/passwd'
...

# tampilkan isi file '/etc/motd' dalam huruf kapital
...
```

---

## ⚙️ Latihan: Manajemen Proses dan Job

```bash
# jalankan `cat /dev/random > rand.txt` di background
...

# tampilkan daftar job
...

# kirim sinyal STOP ke job tersebut
...

# lanjutkan job tersebut di background
...

# kirim sinyal TERM ke job tersebut
...
```

---

## 🎯 Petunjuk Pengerjaan

1. **Kerjakan secara berurutan** - latihan dirancang secara progresif
2. **Jangan melihat jawaban dulu** - coba kerjakan sendiri terlebih dahulu
3. **Gunakan `man`** - jika lupa sintaks perintah
4. **Praktikkan langsung di terminal** - jangan hanya menulis di kertas

---

## ✅ Kunci Jawaban

<details>
<summary>Klik untuk melihat jawaban Latihan Dasar: File dan Direktori</summary>

```bash
# pindah ke direktori home anda
cd ~
# atau
cd

# buat satu folder kosong 'test'
mkdir test

# masuk ke direktori 'test'
cd test

# tampilkan path direktori saat ini
pwd

# buat file kosong bernama 'empty.txt'
touch empty.txt
```

</details>

<details>
<summary>Klik untuk melihat jawaban Latihan: Operasi File</summary>

```bash
# copy file '/etc/timezone' ke direktori ini
cp /etc/timezone .

# ubah nama file 'timezone' menjadi 'tz.txt'
mv timezone tz.txt

# list isi direktori ini
ls
# atau
ls -la

# pindah ke direktori parent
cd ..

# hapus direktori 'test' seisinya
rm -r test
# atau
rm -rf test
```

</details>

<details>
<summary>Klik untuk melihat jawaban Latihan: Pencarian File</summary>

```bash
# temukan file dengan nama 'fdisk' memakai `locate`
locate fdisk

# temukan file dengan nama 'fdisk' memakai `find`
find / -name "fdisk" 2>/dev/null
# atau
find /sbin -name "fdisk"

# temukan file pada home anda yang ukurannya > 200 MB
find ~ -size +200M

# temukan file pada home anda yang diubah < 3 hari
find ~ -mtime -3

# temukan file pada home anda yang diakses > 30 hari
find ~ -atime +30
```

</details>

<details>
<summary>Klik untuk melihat jawaban Latihan: Pemrosesan Teks</summary>

```bash
# tampilkan 5 baris pertama keluaran perintah `last`
last | head -5
# atau
last | head -n 5

# tampilkan dua baris terakhir file '/etc/passwd'
tail -2 /etc/passwd
# atau
tail -n 2 /etc/passwd

# cari file di '/usr/include' yang memuat kata 'sem_post'
grep -r "sem_post" /usr/include
# atau
grep -rl "sem_post" /usr/include

# tampilkan kolom 1 dan 5 dari file '/etc/passwd'
cut -d: -f1,5 /etc/passwd

# tampilkan isi file '/etc/motd' dalam huruf kapital
cat /etc/motd | tr 'a-z' 'A-Z'
# atau
tr 'a-z' 'A-Z' < /etc/motd
```

</details>

<details>
<summary>Klik untuk melihat jawaban Latihan: Manajemen Proses dan Job</summary>

```bash
# jalankan `cat /dev/random > rand.txt` di background
cat /dev/random > rand.txt &

# tampilkan daftar job
jobs

# kirim sinyal STOP ke job tersebut
kill -STOP %1
# atau (jika tahu PID)
kill -STOP <PID>

# lanjutkan job tersebut di background
bg %1

# kirim sinyal TERM ke job tersebut
kill -TERM %1
# atau
kill %1
```

</details>

---

## 📚 Referensi

- [02. Files and Directories](../02-files-and-directories/)
- [04. Text Processing](../04-text-processing/)
- [05. Processes and Jobs](../05-processes-and-jobs/)

---

**Selamat mengerjakan! 💪**
