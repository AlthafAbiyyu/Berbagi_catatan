import 'package:berbagi_catatan/models/note.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UploadNotePage extends StatefulWidget {
  @override
  _UploadNotePageState createState() => _UploadNotePageState();
}

class _UploadNotePageState extends State<UploadNotePage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController tagsController = TextEditingController();
  XFile? imageFile;
  final ImagePicker _picker = ImagePicker();

  void _pickImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageFile = pickedImage;
    });
  }

  void _uploadNote() {
    if (titleController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty) {
      final note = Note(
        jenjang: 'SMA',
        mapel: 'Astro',
        title: titleController.text,
        author: 'Anda',
        pages: '1 Halaman',
        imageUrl: imageFile != null ? imageFile!.path : '',
        waktu: 1,
      );
      Navigator.pop(context, note);
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Form Tidak Lengkap'),
            content:
                const Text('Judul dan deskripsi catatan tidak boleh kosong.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Row(
          children: [
            Icon(Icons.menu_book, color: Colors.green),
            SizedBox(width: 16),
            Text(
              'Buat Catatan Baru',
              style: TextStyle(
                color: Colors.green,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Judul Catatan
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Judul Catatan',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.title),
              ),
            ),
            const SizedBox(height: 16),

            // Gambar Catatan (Card or Container for image upload)
            Container(
              height: 180,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(
                    10), // Rounded corners with a larger radius
              ),
              child: imageFile != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(
                          20), // Same radius for the image
                      child: Image.file(
                        File(imageFile!.path),
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    )
                  : InkWell(
                      onTap: _pickImage,
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_a_photo,
                                size: 50, color: Colors.grey),
                            SizedBox(height: 8),
                            Text(
                              'Upload Gambar Catatan',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
            const SizedBox(height: 16),

            // Deskripsi Catatan
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Deskripsi Catatan',
                border: OutlineInputBorder(),
                alignLabelWithHint: true, // Align for multiline text
              ),
              maxLines: 3, // Multiline text field
            ),
            const SizedBox(height: 16),

            // Tags Catatan
            TextField(
              controller: tagsController,
              decoration: const InputDecoration(
                labelText: 'Tags',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.tag),
              ),
            ),
            const SizedBox(height: 30),

            // Button Row: Batal & Unggah
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Button "Batal"
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(100, 50),
                    side: const BorderSide(color: Colors.grey),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10), // More rounded button
                    ),
                  ),
                  child:
                      const Text('Batal', style: TextStyle(color: Colors.grey)),
                ),

                // Button "Unggah Catatan"
                ElevatedButton.icon(
                  onPressed: _uploadNote,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(150, 50),
                    primary: Colors.green, // Matching the green theme
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10), // More rounded button
                    ),
                  ),
                  icon: const Icon(Icons.cloud_upload),
                  label: const Text('Unggah Catatan'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
