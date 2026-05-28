import 'package:flutter/material.dart';
import '../songs_data.dart';
import 'player_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String query = "";

  @override
  Widget build(BuildContext context) {
    final filtered = songs.where((song) {
      final q = query.toLowerCase();
      return song.title.toLowerCase().contains(q) ||
          song.artist.toLowerCase().contains(q);
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),

      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A0A),
        title: const Text("Stopify 🎧"),
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: "Search songs...",
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Color(0xFF1B1B1B),
              ),
              onChanged: (v) {
                setState(() {
                  query = v;
                });
              },
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (context, i) {
                final song = filtered[i];

                return ListTile(
                  leading: const Icon(Icons.music_note, color: Colors.green),

                  title: Text(
                    song.title,
                    style: const TextStyle(color: Colors.white),
                  ),

                  subtitle: Text(
                    song.artist,
                    style: const TextStyle(color: Colors.grey),
                  ),

                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PlayerScreen(song: song),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
