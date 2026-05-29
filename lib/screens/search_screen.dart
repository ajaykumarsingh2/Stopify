import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/song_data.dart';
import '../providers/audio_provider.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String q = "";
  @override
  Widget build(BuildContext context) {
    final list = playlist
        .where((s) => s.title.toLowerCase().contains(q.toLowerCase()))
        .toList();
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(children: [
        TextField(
          onChanged: (v) => setState(() => q = v),
          decoration: InputDecoration(
              hintText: "Search songs...",
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white10,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (c, i) => ListTile(
              leading: Image.network(list[i].coverUrl, width: 50),
              title: Text(list[i].title),
              onTap: () => context.read<AudioProvider>().playSong(list[i]),
            ),
          ),
        )
      ]),
    );
  }
}
