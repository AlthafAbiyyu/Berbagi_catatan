import 'package:berbagi_catatan/models/note.dart';
import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  final String imageUrl;

  NoteCard({required this.note, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Container(
            width: 100, 
            height: 100, 
            child: imageUrl.startsWith('assets/')
              ? Image.asset(imageUrl, fit: BoxFit.cover)
              : Image.network(imageUrl, fit: BoxFit.cover),
          ),
          Text(note.title),
          Text(note.author),
          Text(note.pages),
        ],
      ),
    );
  }
}