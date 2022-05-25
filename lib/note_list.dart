import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_firebase_demo/note_creator_page.dart';

import 'models/note.dart';

class NoteList extends StatefulWidget {
  const NoteList({Key? key}) : super(key: key);

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  final List<Note> _notes = [
    Note("Hello", "My first note"),
    Note("Hello Again", "Another note"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _notes.length,
        itemBuilder: (context, i) => _buildListItem(_notes[i]),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NoteCreatorPage(
              onCreateNote: (note) => setState(() => _notes.add(note)),
            ),
          ),
        ),
      ),
    );
  }

  static Widget _buildListItem(Note note) {
    return Card(
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(note.content),
            ],
          ),
        ),
      ),
    );
  }
}
