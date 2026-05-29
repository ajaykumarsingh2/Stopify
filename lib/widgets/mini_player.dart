import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/audio_provider.dart';

class MiniPlayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final audioProvider = context.watch<AudioProvider>();
    final song = audioProvider.currentSong;

    if (song == null) return SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1E).withOpacity(0.9),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white10),
        boxShadow: [
          BoxShadow(color: Colors.black54, blurRadius: 20, spreadRadius: 5)
        ],
      ),
      child: Row(
        children: [
          // Album Art
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(song.coverUrl,
                width: 50, height: 50, fit: BoxFit.cover),
          ),
          const SizedBox(width: 15),
          // Info
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(song.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16)),
              Text(song.artist,
                  style: const TextStyle(color: Colors.grey, fontSize: 13)),
            ],
          ),
          const SizedBox(width: 20),
          const Icon(Icons.favorite_border, color: Colors.grey, size: 20),

          const Spacer(),

          // Controls
          Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.shuffle, color: Colors.grey, size: 20),
                  const SizedBox(width: 20),
                  const Icon(Icons.skip_previous, color: Colors.white),
                  const SizedBox(width: 20),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 20,
                    child: IconButton(
                      icon: Icon(
                          audioProvider.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: Colors.black),
                      onPressed: audioProvider.togglePlay,
                    ),
                  ),
                  const SizedBox(width: 20),
                  const Icon(Icons.skip_next, color: Colors.white),
                  const SizedBox(width: 20),
                  const Icon(Icons.repeat, color: Colors.grey, size: 20),
                ],
              ),
              // Seekbar Style Line
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text("1:24",
                      style: TextStyle(color: Colors.grey, fontSize: 10)),
                  const SizedBox(width: 10),
                  Container(
                    width: 300,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: 120, // Progress
                        decoration: BoxDecoration(
                          color: Colors.purpleAccent,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text("3:45",
                      style: TextStyle(color: Colors.grey, fontSize: 10)),
                ],
              ),
            ],
          ),

          const Spacer(),
          const Icon(Icons.fullscreen, color: Colors.grey),
        ],
      ),
    );
  }
}
