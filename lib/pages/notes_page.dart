import 'package:berbagi_catatan/models/note.dart';
import 'package:berbagi_catatan/pages/upload_note_page.dart';
import 'package:flutter/material.dart';

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final List<Note> notes = [
    Note(
      title: '',
      author: '',
      pages: '',
      imageUrl: '',
    ),
  ];

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.home_outlined,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
        title: Row(
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
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.search),
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
                  icon: Icon(Icons.filter_list),
                  onPressed: () {
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(8.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
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
                  return null;
                },
              ),
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
        child: Icon(Icons.add),
      ),
    );
  }
}