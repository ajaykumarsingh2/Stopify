import 'package:flutter/material.dart';
import '../services/image_service.dart';
import '../models/song.dart';
import 'player_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<Map<String, String>> allSongs = const [
    {"title": "Blinding Lights", "artist": "The Weeknd", "imageId": "album-1"},
    {"title": "Shape of You", "artist": "Ed Sheeran", "imageId": "album-2"},
    {"title": "Levitating", "artist": "Dua Lipa", "imageId": "album-3"},
    {"title": "Believer", "artist": "Imagine Dragons", "imageId": "album-1"},
    {"title": "Heat Waves", "artist": "Glass Animals", "imageId": "album-2"},
    {"title": "Peaches", "artist": "Justin Bieber", "imageId": "album-3"},
  ];

  final List<String> genres = [
    "Pop",
    "Rock",
    "Jazz",
    "Hip-Hop",
    "Electronic",
    "Classical",
  ];

  List<Map<String, String>> get filteredSongs {
    if (_searchQuery.isEmpty) {
      return allSongs;
    }
    return allSongs
        .where(
          (song) =>
              song['title']!.toLowerCase().contains(
                _searchQuery.toLowerCase(),
              ) ||
              song['artist']!.toLowerCase().contains(
                _searchQuery.toLowerCase(),
              ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A0A),
        elevation: 0,
        title: const Text("Search"),
      ),
      body: Column(
        children: [
          // 🔍 SEARCH BAR
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: "Search songs, artists...",
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: Colors.grey),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _searchQuery = '';
                          });
                        },
                      )
                    : null,
                filled: true,
                fillColor: const Color(0xFF1B1B1B),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          // 🎭 GENRE CHIPS
          if (_searchQuery.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Wrap(
                spacing: 8,
                children: genres.map((genre) {
                  return Chip(
                    label: Text(genre),
                    backgroundColor: const Color(0xFF1B1B1B),
                    labelStyle: const TextStyle(color: Colors.white),
                    side: const BorderSide(color: Colors.green),
                  );
                }).toList(),
              ),
            ),
          // 🎵 SEARCH RESULTS
          Expanded(
            child: _searchQuery.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.search, color: Colors.grey, size: 80),
                        const SizedBox(height: 16),
                        const Text(
                          "Search for songs or artists",
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredSongs.length,
                    itemBuilder: (context, index) {
                      final song = filteredSongs[index];
                      final imageUrl = ImageService.getImageUrl(
                        song["imageId"]!,
                      );

                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1B1B1B),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Image.network(
                              imageUrl,
                              width: 48,
                              height: 48,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 48,
                                  height: 48,
                                  color: Colors.grey[800],
                                  child: const Icon(
                                    Icons.music_note,
                                    color: Colors.green,
                                  ),
                                );
                              },
                            ),
                          ),
                          title: Text(
                            song["title"]!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Text(
                            song["artist"]!,
                            style: const TextStyle(color: Colors.grey),
                          ),
                          trailing: const Icon(
                            Icons.play_circle,
                            color: Colors.green,
                            size: 24,
                          ),
                          onTap: () {
                            final songObj = Song(
                              title: song["title"]!,
                              artist: song["artist"]!,
                              imageUrl: imageUrl,
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => PlayerScreen(song: songObj),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
