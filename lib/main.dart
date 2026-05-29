import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/audio_provider.dart';
import 'screens/home_screen.dart';
import 'widgets/mini_player.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AudioProvider()),
      ],
      child: const StopifyApp(),
    ),
  );
}

class StopifyApp extends StatelessWidget {
  const StopifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: MainWrapper(),
    );
  }
}

class MainWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar for Web/Desktop
          if (MediaQuery.of(context).size.width > 800)
            Container(
              width: 240,
              color: Colors.black,
              child: Column(
                children: [
                  SizedBox(height: 40),
                  _SideBarItem(Icons.home, "Home", true),
                  _SideBarItem(Icons.search, "Search", false),
                  _SideBarItem(Icons.library_music, "Your Library", false),
                  SizedBox(height: 20),
                  _SideBarItem(Icons.add_box, "Create Playlist", false),
                  _SideBarItem(Icons.favorite, "Liked Songs", false),
                ],
              ),
            ),

          Expanded(
            child: Stack(
              children: [
                HomeScreen(),
                Positioned(
                  bottom: 10,
                  left: 10,
                  right: 10,
                  child: MiniPlayer(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _SideBarItem(IconData icon, String title, bool isActive) {
    return ListTile(
      leading: Icon(icon, color: isActive ? Colors.white : Colors.grey),
      title: Text(title,
          style: TextStyle(
              color: isActive ? Colors.white : Colors.grey,
              fontWeight: FontWeight.bold)),
      onTap: () {},
    );
  }
}
