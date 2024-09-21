import 'package:flutter/material.dart';
import 'pages/notes_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catatan App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: NotesPage(),
    );
  }
}
