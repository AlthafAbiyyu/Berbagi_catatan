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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Row(
          children: [
            Icon(Icons.menu_book, color: Colors.green), // Icon buku
            SizedBox(width: 8), // Jarak antara icon dan tulisan
            Text(
              'Buat Catatan Baru',
              style: TextStyle(
                color: Colors.green,
                fontSize: 22, // Ukuran lebih besar untuk judul
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Judul Catatan',
                  prefixIcon: Icon(Icons.note, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: imageFile == null
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add, size: 50, color: Colors.grey),
                              Text('Upload Gambar Catatan', style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        )
                      : Image.file(File(imageFile!.path), fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: descriptionController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Deskripsi Catatan',
                  hintText: 'Jelaskan isi catatan yang kamu bagikan...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: tagsController,
                decoration: InputDecoration(
                  labelText: 'Tags',
                  prefixIcon: Icon(Icons.tag, color: Colors.grey),
                  hintText: 'Ketikkan Tags',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.start, // Supaya tombol ada di kiri
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red, // Background color merah untuk tombol "Batal"
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), // Rounded corners
                      ),
                      elevation: 0, // Flat look
                    ),
                    child: Text('Batal', style: TextStyle(color: Colors.white)),
                  ),
                  SizedBox(width: 16), // Jarak antara tombol "Batal" dan "Unggah Catatan"
                  ElevatedButton.icon(
                    onPressed: () {
                      // Implement upload functionality here
                    },
                    icon: Icon(Icons.cloud_upload, color: Colors.white),
                    label: Text('Unggah Catatan'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green, // Background color untuk tombol "Unggah Catatan"
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}