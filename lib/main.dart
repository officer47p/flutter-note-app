import "package:flutter/material.dart";

import './screens/notes_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Note App",
      debugShowCheckedModeBanner: false,
      home: NotesScreen(),
    );
  }
}
