// ignore: unused_import
import 'package:berbagi_catatan/pages/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MejaKita',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: LoginPage(),
    );
  }
}
