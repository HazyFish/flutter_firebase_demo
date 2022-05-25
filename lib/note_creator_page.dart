import 'package:flutter/material.dart';

import 'models/note.dart';

typedef OnCreateNoteCallback = void Function(Note note);

class NoteCreatorPage extends StatefulWidget {
  final OnCreateNoteCallback onCreateNote;

  const NoteCreatorPage({Key? key, required this.onCreateNote})
      : super(key: key);

  @override
  State<NoteCreatorPage> createState() => _NoteCreatorPageState();
}

class _NoteCreatorPageState extends State<NoteCreatorPage> {
  final _titleTextEditingController = TextEditingController();
  final _contentTextEditingController = TextEditingController();

  @override
  void dispose() {
    _titleTextEditingController.dispose();
    _contentTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("New Note")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _titleTextEditingController,
              decoration: const InputDecoration(hintText: "Title"),
            ),
            TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              controller: _contentTextEditingController,
              decoration: const InputDecoration(hintText: "Content"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text("Create"),
        onPressed: () {
          widget.onCreateNote(Note(
            _titleTextEditingController.text,
            _contentTextEditingController.text,
          ));
          Navigator.pop(context);
        },
      ),
    );
  }
}
