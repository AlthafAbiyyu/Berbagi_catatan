import 'package:berbagi_catatan/models/note.dart';
import 'package:berbagi_catatan/pages/login_page.dart';
import 'package:berbagi_catatan/pages/upload_note_page.dart';
import 'package:berbagi_catatan/widgets/note_card.dart';
import 'package:flutter/material.dart';

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final List<Note> notes = [
    Note(
      title: 'Catatan 1',
      author: 'Pengarang',
      pages: '1 Halaman',
      imageUrl: 'assets/1.jpg',
    ),
    Note(
      title: 'Catatan',
      author: 'pengarang',
      pages: '2 Halaman',
      imageUrl: 'assets/1.jpg',
    ),
    // Add more notes as needed
  ];

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.home_outlined,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
        ),
        title: const Row(
          children: [
            Icon(
              Icons.menu_book,
              color: Colors.green,
            ),
            SizedBox(width: 8.0),
            Text(
              'Catatan',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: 'Search catatan...',
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.clear,
                              color: searchQuery.isNotEmpty
                                  ? Colors.black
                                  : Colors.grey),
                          onPressed: () {
                            if (searchQuery.isNotEmpty) {
                              setState(() {
                                searchQuery = '';
                              });
                            }
                          },
                        )),
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () {
                    // Implement filter functionality
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                if (searchQuery.isNotEmpty &&
                    !note.title
                        .toLowerCase()
                        .contains(searchQuery.toLowerCase())) {
                  return Container();
                }
                return NoteCard(note: note, imageUrl: '',);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UploadNotePage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}