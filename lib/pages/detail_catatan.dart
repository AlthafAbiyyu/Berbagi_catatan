import 'package:berbagi_catatan/models/note.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// Model untuk komentar
class Comment {
  final String user;
  final String text;

  Comment({required this.user, required this.text});
}

class NoteDetailPage extends StatefulWidget {
  final Note note;

  const NoteDetailPage({Key? key, required this.note}) : super(key: key);

  @override
  _NoteDetailPageState createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  bool _isExpanded = false;
  List<Comment> comments = []; // List untuk menyimpan komentar
  final PageController _pageController = PageController();

  void _showCommentBottomSheet() {
    final TextEditingController commentController = TextEditingController();

    showModalBottomSheet(
      backgroundColor: Color.fromRGBO(91, 176, 134, 1),
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Komentar",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white),
                ),
                const SizedBox(height: 10),
                // List of comments
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    final comment = comments[index];
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(vertical: 4.0),
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        child: Text(comment.user[0]), // First letter of name
                      ),
                      title: Text(
                        comment.user,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      subtitle: Text(
                        comment.text,
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
                TextField(
                  cursorColor: Colors.black,
                  controller: commentController,
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Masukkan komentar...",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(color: Colors.black)),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        String commentText = commentController.text;
                        if (commentText.isNotEmpty) {
                          setState(() {
                            comments.add(
                                Comment(user: "Pengguna", text: commentText));
                          });
                          commentController.clear();
                        }
                      },
                      child: const Text(
                        "Kirim",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "Batal",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          widget.note.title,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    child: Icon(Icons.person, color: Colors.white, size: 20),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    widget.note.author,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "Sunday, 30 Oktober, 2023",
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Image Section
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                width: double.infinity,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        image: const DecorationImage(
                          image: AssetImage('assets/1.jpg'),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: Icon(Icons.favorite_border,
                            color: Colors.red, size: 20),
                        onPressed: () {
                          // Handle like action
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.comment, color: Colors.blue, size: 20),
                        onPressed:
                            _showCommentBottomSheet, // Show comment dialog
                      ),
                      IconButton(
                        icon:
                            Icon(Icons.download, color: Colors.green, size: 20),
                        onPressed: () {
                          // Handle download action
                        },
                      ),
                    ],
                  ),
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
                ],
              ),
              SizedBox(height: 10),
              Text(
                widget.note.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 18),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color.fromRGBO(91, 176, 134, 1)),
                    child: Text(
                      "SMA",
                      style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color.fromRGBO(91, 176, 134, 1)),
                    child: Text(
                      "Astro",
                      style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Deskripsi Catatan",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Sistem tata surya adalah kumpulan benda-benda langit dengan Matahari sebagai pusatnya. Di sekitarnya terdapat planet-planet, satelit alami, asteroid, komet, dan materi antarplanet seperti debu dan meteoroid, yang semuanya bergerak mengikuti orbit karena terikat oleh gravitasi Matahari. Setiap benda di tata surya bergerak dalam lintasan berbentuk elips dengan Matahari sebagai pusatnya. Gravitasi Matahari, bersama dengan interaksi gravitasi antarplanet, menjaga kestabilan sistem ini. Tata surya sendiri merupakan bagian dari galaksi Bima Sakti, dan pengetahuan tentangnya terus berkembang berkat misi antariksa dan penelitian ilmiah..",
                    maxLines: _isExpanded ? null : 7,
                    overflow: _isExpanded
                        ? TextOverflow.visible
                        : TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });
                    },
                    child: Text(
                      _isExpanded
                          ? "Lihat lebih sedikit"
                          : "Lihat selengkapnya",
                      style: const TextStyle(color: Colors.blue, fontSize: 12),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Container(
                color: Color.fromRGBO(91, 176, 134, 1),
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Rangkuman AI",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Sistem tata surya adalah kumpulan benda langit yang berpusat pada Matahari",
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
