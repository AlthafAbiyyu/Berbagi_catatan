import 'package:berbagi_catatan/components/dropdown.dart';
import 'package:berbagi_catatan/models/note.dart';
import 'package:berbagi_catatan/pages/notes_page.dart';
import 'package:berbagi_catatan/pages/upload_note_page.dart';
import 'package:berbagi_catatan/pages/uploaded_page.dart';
import 'package:berbagi_catatan/widgets/note_card.dart';
import 'package:flutter/material.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<Note> notes = [
    Note(
      title: 'Sistem Tata Surya || Kelas 7',
      author: 'Suwanda Fitri Nafiah',
      pages: '10 Halaman',
      imageUrl: 'assets/1.jpg',
      waktu: 1,
      jenjang: 'SMA',
      mapel: 'Astro',
    ),
    Note(
      title: 'Tugas 1',
      author: 'Suwanda Fitri Nafiah',
      pages: '10 Halaman',
      imageUrl: 'assets/1.jpg',
      waktu: 2,
      jenjang: 'SMA',
      mapel: 'Astro',
    ),
    Note(
      title: 'Matematika',
      author: 'Suwanda Fitri Nafiah',
      pages: '10 Halaman',
      imageUrl: 'assets/1.jpg',
      waktu: 3,
      jenjang: 'SMA',
      mapel: 'Astro',
    ),
  ];

  final PageController _pageController = PageController();
  TextEditingController _searchController = TextEditingController();
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        searchQuery = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _addNote(Note note) {
    setState(() {
      notes.add(note);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Note> filteredNotes = notes.where((note) {
      return searchQuery.isEmpty ||
          note.title.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Builder(
          builder: (context) => Padding(
            padding: const EdgeInsets.all(15),
            child: IconButton(
              icon: Icon(Icons.menu, color: Colors.black),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Cari disini...',
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    suffixIcon: searchQuery.isNotEmpty
                        ? IconButton(
                            icon: Icon(Icons.clear, color: Colors.grey),
                            onPressed: () {
                              setState(() {
                                _searchController.clear();
                                searchQuery = '';
                              });
                            },
                          )
                        : null,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 15),
            IconButton(
              icon: const CircleAvatar(
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, color: Colors.white),
              ),
              onPressed: () {
                // Handle profile click
              },
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Color.fromRGBO(91, 176, 134, 1)),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
              ),
              title: Text('Home'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotesPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.upload,
                color: Colors.blue,
              ),
              title: Text('Uploaded'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UploadedPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Di sinilah catatan yang kamu sukai! 😻",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                        child: RoleDropdown(
                            hintText: "Berdasarkan \nTanggal",
                            items: ["1", "2"])),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                        child: RoleDropdown(
                            hintText: "Urutkan \n",
                            items: ["Terbaru", "Terlama"])),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                        child: RoleDropdown(
                            hintText: "Semua \nAuthor",
                            items: ["Eko", "Agus"])),
                  ],
                )),
            const SizedBox(height: 12),
            if (filteredNotes.isEmpty)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Tidak ada catatan yang ditemukan",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 3,
              ),
              itemCount: filteredNotes.length,
              itemBuilder: (context, index) {
                final note = filteredNotes[index];
                return NoteCard(
                  note: note,
                  imageUrl: note.imageUrl,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UploadNotePage()),
          ).then((value) {
            if (value != null) {
              _addNote(value);
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
