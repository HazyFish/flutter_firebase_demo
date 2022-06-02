import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase_demo/note_list_page.dart';
import 'package:flutter_firebase_demo/profile.dart';
import 'package:flutter_firebase_demo/sign_in_page.dart';
import 'firebase_options.dart';
import 'models/note.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  User? _user;
  int _index = 0;
  final List<Note> _notes = [];

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((user) => setState(() {
          _user = user;
          if (user == null) {
            _notes.clear();
          } else {
            getNotesFromFirestore();
          }
        }));
  }

  void getNotesFromFirestore() {
    FirebaseFirestore.instance.collection("notes").get().then((qs) => setState(
        () => _notes.addAll(qs.docs
            .map((e) => e.data())
            .map((e) => Note(e['title'], e['content'])))));
  }

  void addNoteToFirestore(Note note) {
    FirebaseFirestore.instance.collection("notes").add({
      "title": note.title,
      "content": note.content,
    }).then((value) => log("Document ${value.path} added to Firestore"));
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return const SignInPage();
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Firebase Demo App")),
      body: _buildScaffoldBody(),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        onTap: (index) => setState(() => _index = index),
        currentIndex: _index,
      ),
    );
  }

  Widget _buildScaffoldBody() {
    switch (_index) {
      case 0:
        return NoteListPage(
          notes: _notes,
          onCreateNote: (note) => setState(() {
            _notes.add(note);
            addNoteToFirestore(note);
          }),
        );
      case 1:
        return Profile(user: _user!);
      default:
        throw const Text("Unexpected Error Occurred!");
    }
  }
}
