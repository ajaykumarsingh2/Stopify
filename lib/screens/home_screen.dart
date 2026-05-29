import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/song_data.dart';
import '../providers/audio_provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(30),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text("Global Hits",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: 0.8),
          itemCount: playlist.length,
          itemBuilder: (c, i) {
            final song = playlist[i];
            return GestureDetector(
              onTap: () => context.read<AudioProvider>().playSong(song),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(children: [
                  Expanded(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child:
                              Image.network(song.coverUrl, fit: BoxFit.cover))),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(song.title, maxLines: 1)),
                ]),
              ),
            );
          },
        )
      ]),
    );
  }
}
