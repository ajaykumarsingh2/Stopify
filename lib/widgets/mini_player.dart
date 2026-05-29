import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/audio_provider.dart';

class MiniPlayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final audioProvider = context.watch<AudioProvider>();
    final song = audioProvider.currentSong;

    if (song == null) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1E).withOpacity(0.95),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white10),
        boxShadow: const [BoxShadow(color: Colors.black54, blurRadius: 20)],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(song.coverUrl,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(Icons.music_note)),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
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
          ),
          // Play/Pause Button
          IconButton(
            icon: const Icon(Icons.skip_previous, color: Colors.white),
            onPressed: () {},
          ),
          GestureDetector(
            onTap: () => audioProvider.togglePlay(),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 20,
              child: Icon(
                audioProvider.isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.black,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.skip_next, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
