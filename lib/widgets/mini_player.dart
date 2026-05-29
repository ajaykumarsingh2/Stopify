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
      height: 64,
      width: MediaQuery.of(context).size.width * 0.95,
      decoration: BoxDecoration(
        color: Color(0xFF3E3E3E),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          ListTile(
            dense: true,
            visualDensity: VisualDensity.compact,
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(song.coverUrl,
                  width: 40, height: 40, fit: BoxFit.cover),
            ),
            title: Text(song.title,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13)),
            subtitle: Text(song.artist,
                style: TextStyle(color: Colors.grey, fontSize: 11)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.cast, color: Colors.white, size: 20),
                SizedBox(width: 15),
                IconButton(
                  icon: Icon(
                      audioProvider.isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.white),
                  onPressed: audioProvider.togglePlay,
                ),
              ],
            ),
          ),
          // Progress Bar (Simple line)
          Container(
            height: 2,
            width: MediaQuery.of(context).size.width * 0.9,
            color: Colors.grey.withOpacity(0.3),
            alignment: Alignment.centerLeft,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.4, // Static for now
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
