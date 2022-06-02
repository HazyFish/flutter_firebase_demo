import 'package:flutter/material.dart';
import 'package:flutter_firebase_demo/note_creator_page.dart';

import 'models/note.dart';

class NoteListPage extends StatelessWidget {
  final OnCreateNoteCallback onCreateNote;
  final List<Note> notes;
  const NoteListPage(
      {Key? key, required this.notes, required this.onCreateNote})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, i) => _buildListItem(notes[i]),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NoteCreatorPage(
              onCreateNote: onCreateNote,
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
