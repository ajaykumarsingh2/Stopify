import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/audio_provider.dart';

class MiniPlayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ap = context.watch<AudioProvider>();
    if (ap.currentSong == null) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: const Color(0xFF18181B),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white10)),
      child: Row(children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(ap.currentSong!.coverUrl,
                width: 50, height: 50, fit: BoxFit.cover)),
        const SizedBox(width: 15),
        Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
              Text(ap.currentSong!.title,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(ap.currentSong!.artist,
                  style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ])),
        Column(mainAxisSize: MainAxisSize.min, children: [
          Row(mainAxisSize: MainAxisSize.min, children: [
            IconButton(icon: const Icon(Icons.skip_previous), onPressed: () {}),
            IconButton(
                icon: Icon(
                    ap.isPlaying ? Icons.pause_circle : Icons.play_circle,
                    size: 35),
                onPressed: ap.togglePlay),
            IconButton(icon: const Icon(Icons.skip_next), onPressed: () {}),
          ]),
          SizedBox(
            width: 300,
            child: Slider(
              activeColor: Colors.purpleAccent,
              value: ap.position.inSeconds.toDouble(),
              max: ap.duration.inSeconds.toDouble() > 0
                  ? ap.duration.inSeconds.toDouble()
                  : 1.0,
              onChanged: (v) => ap.seek(Duration(seconds: v.toInt())),
            ),
          )
        ]),
        const Spacer(),
        const Icon(Icons.volume_up, color: Colors.grey),
      ]),
    );
  }
}
