import 'package:flutter/material.dart';

class LibraryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text("Your Library",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
        const SizedBox(height: 30),
        ListTile(
          leading: Container(
              width: 50,
              height: 50,
              color: Colors.purple,
              child: const Icon(Icons.favorite)),
          title: const Text("Liked Songs"),
          subtitle: const Text("15 Songs"),
        ),
      ]),
    );
  }
}
