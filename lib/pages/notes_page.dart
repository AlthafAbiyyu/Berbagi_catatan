import 'package:berbagi_catatan/models/note.dart';
import 'package:berbagi_catatan/pages/upload_note_page.dart';
import 'package:berbagi_catatan/widgets/note_card.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  List<Note> notes = [
    Note(
      title: 'Sistem Tata Surya || Kelas 7',
      author: 'Suwanda Fitri Nafiah',
      pages: '10 Halaman',
      imageUrl: 'assets/1.jpg',
    ),
    Note(
      title: 'Tugas 1',
      author: 'Suwanda Fitri Nafiah',
      pages: '10 Halaman',
      imageUrl: 'assets/1.jpg',
    ),
    Note(
      title: 'Matematika',
      author: 'Suwanda Fitri Nafiah',
      pages: '10 Halaman',
      imageUrl: 'assets/1.jpg',
    ),
    Note(
      title: 'Sistem Tata Surya || Kelas 7',
      author: 'Suwanda Fitri Nafiah',
      pages: '10 Halaman',
      imageUrl: 'assets/1.jpg',
    ),
    Note(
      title: 'Sistem Tata Surya || Kelas 7',
      author: 'Suwanda Fitri Nafiah',
      pages: '10 Halaman',
      imageUrl: 'assets/1.jpg',
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
        leading: Padding(
          padding: const EdgeInsets.all(15),
          child: IconButton(
            icon: Icon(Icons.menu, color: Colors.black),
            onPressed: () {
              // Handle menu click
            },
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
                    hintText: 'Cari di sini...',
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Ada yang baru, nih! 🔥",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 150, // Tetap dengan tinggi sesuai kebutuhan Anda
              width: double.infinity, // Lebar mengikuti lebar layar perangkat
              child: PageView.builder(
                controller: _pageController,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                      image: const DecorationImage(
                        image: AssetImage('assets/2.png'),
                        fit: BoxFit
                            .cover, // Gambar akan menutupi seluruh area kontainer
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            SmoothPageIndicator(
              controller: _pageController,
              count: 5,
              effect: const WormEffect(
                dotHeight: 6,
                dotWidth: 30,
                activeDotColor: Colors.green,
                dotColor: Colors.grey,
                spacing: 8,
                strokeWidth: 1,
              ),
            ),
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Lihat Catatan Teman Kalian Disini!! 👀",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
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
