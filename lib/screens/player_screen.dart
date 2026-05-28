import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../song_model.dart';

class PlayerScreen extends StatefulWidget {
  final Song song;

  const PlayerScreen({super.key, required this.song});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  final AudioPlayer player = AudioPlayer();

  bool playing = false;
  bool loaded = false;

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    try {
      await player.setUrl(widget.song.url);
      setState(() {
        loaded = true;
      });
    } catch (e) {
      debugPrint("Audio error: $e");
    }
  }

  void toggle() async {
    if (!loaded) return;

    if (playing) {
      await player.pause();
    } else {
      await player.play();
    }

    setState(() {
      playing = !playing;
    });
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),

      appBar: AppBar(backgroundColor: const Color(0xFF0A0A0A)),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.music_note, size: 120, color: Colors.green),

          const SizedBox(height: 20),

          Text(
            widget.song.title,
            style: const TextStyle(color: Colors.white, fontSize: 22),
          ),

          Text(widget.song.artist, style: const TextStyle(color: Colors.grey)),

          const SizedBox(height: 40),

          StreamBuilder<Duration>(
            stream: player.positionStream,
            builder: (context, snap) {
              final pos = snap.data ?? Duration.zero;

              return StreamBuilder<Duration?>(
                stream: player.durationStream,
                builder: (context, snap) {
                  final dur = snap.data ?? Duration.zero;

                  double max = dur.inSeconds.toDouble();
                  if (max <= 0) max = 1;

                  return Slider(
                    activeColor: Colors.green,
                    value: pos.inSeconds.toDouble(),
                    max: max,
                    onChanged: (v) {
                      player.seek(Duration(seconds: v.toInt()));
                    },
                  );
                },
              );
            },
          ),

          const SizedBox(height: 20),

          GestureDetector(
            onTap: toggle,
            child: Icon(
              playing ? Icons.pause_circle : Icons.play_circle,
              size: 80,
              color: loaded ? Colors.green : Colors.grey,
            ),
          ),

          if (!loaded)
            const Text(
              "Loading audio...",
              style: TextStyle(color: Colors.grey),
            ),
        ],
      ),
    );
  }
}
