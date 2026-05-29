import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/song_data.dart';
import '../providers/audio_provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Text: Recently Played
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    children: [
                      TextSpan(text: "Recently "),
                      TextSpan(
                          text: "Played",
                          style: TextStyle(color: Colors.purpleAccent)),
                    ],
                  ),
                ),
                TextButton(
                    onPressed: () {},
                    child: const Text("See all →",
                        style: TextStyle(color: Colors.grey))),
              ],
            ),
            const SizedBox(height: 24),

            // Song Cards Grid/List
            SizedBox(
              height: 280,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: playlist.length,
                itemBuilder: (context, index) {
                  final song = playlist[index];
                  return GestureDetector(
                    onTap: () => context.read<AudioProvider>().playSong(song),
                    child: Container(
                      width: 200,
                      margin: const EdgeInsets.only(right: 24),
                      decoration: BoxDecoration(
                        color: const Color(0xFF121214),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              // --- YE HAI SAFE IMAGE WALA PART ---
                              child: Image.network(
                                song.coverUrl,
                                height: 170,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                // Agar image load nahi hui toh ye chalega
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    height: 170,
                                    width: double.infinity,
                                    color: Colors.grey.shade900,
                                    child: const Icon(Icons.music_note,
                                        color: Colors.purpleAccent, size: 50),
                                  );
                                },
                              ),
                            ),
                          ),
                          // Song Title
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(song.title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                                overflow: TextOverflow.ellipsis),
                          ),
                          // Artist Name
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(song.artist,
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 14)),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
