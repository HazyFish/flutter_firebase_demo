import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final User user;
  const Profile({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(user.photoURL ??
              'https://cdn.icon-icons.com/icons2/1378/PNG/512/avatardefault_92824.png'),
          const SizedBox(height: 8),
          Text(
            user.displayName ?? "(No Name)",
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 8),
          Text(user.email ?? "(No Email)"),
          const SizedBox(height: 8),
          OutlinedButton(
              onPressed: () => FirebaseAuth.instance.signOut(),
              style: OutlinedButton.styleFrom(primary: Colors.red),
              child: const Text("Logout")),
        ],
      ),
    );
  }
}
