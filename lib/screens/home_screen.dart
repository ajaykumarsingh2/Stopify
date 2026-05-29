import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/song_data.dart';
import '../providers/audio_provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Background wrapper se aayega
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1A1A2E), Color(0xFF16213E), Colors.black],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search and Profile Row
              Row(
                children: [
                  const Text("Recently Played",
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2)),
                  const Spacer(),
                  const Icon(Icons.search, color: Colors.grey, size: 28),
                  const SizedBox(width: 20),
                  const CircleAvatar(
                      backgroundColor: Colors.purpleAccent,
                      radius: 18,
                      child: Icon(Icons.person, color: Colors.white, size: 20)),
                ],
              ),
              const SizedBox(height: 30),

              // Song Cards Grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, // 4 cards in a row
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 25,
                  mainAxisSpacing: 25,
                ),
                itemCount: playlist.length,
                itemBuilder: (context, index) {
                  final song = playlist[index];
                  return MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () => context.read<AudioProvider>().playSong(song),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(24),
                          border:
                              Border.all(color: Colors.white.withOpacity(0.1)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(18),
                                  child: Image.network(song.coverUrl,
                                      width: double.infinity,
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 16, 5),
                              child: Text(song.title,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                  overflow: TextOverflow.ellipsis),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                              child: Text(song.artist,
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 13)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 100), // Bottom space for player
            ],
          ),
        ),
      ),
    );
  }
}
