import 'package:berbagi_catatan/models/note.dart';
import 'package:berbagi_catatan/pages/detail_catatan.dart';
import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {
  final Note note;

  const NoteCard({required this.note, required String imageUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NoteDetailPage(note: note),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 80,
                height: 140,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    note.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color.fromRGBO(91, 176, 134, 1)),
                          child: Text(
                            note.jenjang,
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
                            note.mapel,
                            style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      note.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 0),
                    Text(
                      note.author,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                        color: Color.fromRGBO(91, 176, 134, 1),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.article_outlined,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "${note.pages}",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        Expanded(child: Container()),
                        Icon(
                          Icons.timelapse,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "${note.waktu} Jam Yang Lalu",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
