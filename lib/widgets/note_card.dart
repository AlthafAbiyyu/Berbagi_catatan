import 'package:berbagi_catatan/models/note.dart';
import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {
  final Note note;

  const NoteCard({required this.note, required String imageUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0), // Padding yang lebih besar agar lebih rapi
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar di sebelah kiri
            Container(
              width: 80, // Lebar gambar lebih kecil sesuai contoh gambar
              height: 150, // Tinggi gambar lebih kecil sesuai contoh gambar
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: note.imageUrl.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        note.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    )
                  : const Center(
                      child: Text('No Image'),
                    ),
            ),
            const SizedBox(width: 16), // Jarak antara gambar dan teks
            // Teks di sebelah kanan
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Judul dengan ukuran lebih besar dan tebal
                  Text(
                    note.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16, // Ukuran font lebih besar untuk judul
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 15), // Jarak antara judul dan teks berikutnya
                  // Penulis
                  Text(
                    note.author,
                    style: const TextStyle(
                      fontSize: 14, // Ukuran font sedang untuk penulis
                      color: Colors.grey,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  // Jumlah halaman
                  Text(
                    "${note.pages} pages", // Contoh untuk menunjukkan jumlah halaman
                    style: const TextStyle(
                      fontSize: 12, // Ukuran font kecil untuk deskripsi
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}