import 'package:berbagi_catatan/pages/notes_page.dart';
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
        title: Text('Buat Catatan Baru'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Judul Catatan',
                  prefixIcon: Icon(Icons.note),
                  border: OutlineInputBorder(),
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
                      ? Center(child: Text('Upload Gambar Catatan'))
                      : Image.file(
                          File(imageFile!.path),
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: descriptionController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Deskripsi Catatan',
                  hintText: 'Jelaskan isi catatan yang kamu bagikan...',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: tagsController,
                decoration: InputDecoration(
                  labelText: 'Tags',
                  prefixIcon: Icon(Icons.tag),
                  hintText: 'Ketikkan Tags',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 24),
              Center(
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Batal'),
                      style: ElevatedButton.styleFrom(primary: Colors.red),
                    ),
                    SizedBox(width: 16), // add some space between buttons
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NotesPage()),
                        );
                      },
                      icon: Icon(Icons.cloud_upload),
                      label: Text('Unggah Catatan'),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
