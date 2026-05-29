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
            const Text("Good evening",
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            const SizedBox(height: 24),

            // Top Grid (6 Quick access songs)
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: 6,
              itemBuilder: (context, index) {
                final song = playlist[index];
                return GestureDetector(
                  onTap: () => context.read<AudioProvider>().playSong(song),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8)),
                          child: Image.network(song.coverUrl,
                              width: 80, height: 80, fit: BoxFit.cover),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                            child: Text(song.title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis)),
                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 40),
            const Text("Recently Played",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            const SizedBox(height: 20),

            // All 15 Songs List
            SizedBox(
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: playlist.length,
                itemBuilder: (context, index) {
                  final song = playlist[index];
                  return GestureDetector(
                    onTap: () => context.read<AudioProvider>().playSong(song),
                    child: Container(
                      width: 180,
                      margin: const EdgeInsets.only(right: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(song.coverUrl,
                                height: 180, width: 180, fit: BoxFit.cover),
                          ),
                          const SizedBox(height: 12),
                          Text(song.title,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis),
                          Text(song.artist,
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 13)),
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
