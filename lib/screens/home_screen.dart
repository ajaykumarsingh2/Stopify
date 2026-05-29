import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../data/song_data.dart';
import '../providers/audio_provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blueGrey.shade900,
              Colors.black,
              Colors.black,
            ],
          ),
        ),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              pinned: true,
              expandedHeight: 80,
              flexibleSpace: FlexibleSpaceBar(
                title: Text("Good evening",
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold, fontSize: 22)),
                titlePadding: EdgeInsets.only(left: 20, bottom: 15),
              ),
              actions: [
                IconButton(
                    icon: Icon(Icons.notifications_none), onPressed: () {}),
                IconButton(icon: Icon(Icons.history), onPressed: () {}),
                IconButton(
                    icon: Icon(Icons.settings_outlined), onPressed: () {}),
                SizedBox(width: 10),
              ],
            ),

            // Top Grid (2x3) like Spotify
            SliverPadding(
              padding: EdgeInsets.all(16),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3.5,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final song = playlist[index];
                    return GestureDetector(
                      onTap: () => context.read<AudioProvider>().playSong(song),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4),
                                  bottomLeft: Radius.circular(4)),
                              child: Image.network(song.coverUrl,
                                  width: 55, height: 55, fit: BoxFit.cover),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                                child: Text(song.title,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13),
                                    overflow: TextOverflow.ellipsis)),
                          ],
                        ),
                      ),
                    );
                  },
                  childCount: 6,
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Text("Made for you",
                    style: GoogleFonts.montserrat(
                        fontSize: 22, fontWeight: FontWeight.bold)),
              ),
            ),

            // Horizontal List
            SliverToBoxAdapter(
              child: Container(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(left: 16),
                  itemCount: playlist.length,
                  itemBuilder: (context, index) {
                    final song = playlist[index];
                    return GestureDetector(
                      onTap: () => context.read<AudioProvider>().playSong(song),
                      child: Container(
                        width: 150,
                        margin: EdgeInsets.only(right: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(song.coverUrl,
                                  width: 150, height: 150, fit: BoxFit.cover),
                            ),
                            SizedBox(height: 10),
                            Text(song.title,
                                style: TextStyle(fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis),
                            Text(song.artist,
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                                overflow: TextOverflow.ellipsis),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            SliverToBoxAdapter(
                child: SizedBox(height: 100)), // Bottom padding for miniplayer
          ],
        ),
      ),
    );
  }
}
