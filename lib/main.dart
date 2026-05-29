import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/audio_provider.dart';
import 'screens/home_screen.dart';
import 'widgets/mini_player.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AudioProvider())],
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
        scaffoldBackgroundColor: const Color(0xFF09090B), // Deep Black
      ),
      home: MainWrapper(),
    );
  }
}

class MainWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Row(
            children: [
              // Sidebar (Exactly like image 2)
              Container(
                width: 240,
                decoration: const BoxDecoration(
                  color: Color(0xFF09090B),
                  border: Border(
                      right: BorderSide(color: Colors.white12, width: 0.5)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Row(
                        children: [
                          const Icon(Icons.music_note,
                              color: Colors.purpleAccent, size: 32),
                          const SizedBox(width: 10),
                          Text("Stopify",
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1)),
                        ],
                      ),
                    ),
                    _sideMenuItem(Icons.home_filled, "Home", true),
                    _sideMenuItem(Icons.explore_outlined, "Explore", false),
                    _sideMenuItem(Icons.auto_awesome, "AI Discovery", false),
                    _sideMenuItem(
                        Icons.library_music_outlined, "Library", false),
                    const Spacer(),
                  ],
                ),
              ),
              // Main Content Area
              Expanded(child: HomeScreen()),
            ],
          ),
          // Floating Player (Image 2 style)
          Positioned(
            bottom: 20,
            left: 260, // Sidebar ke baad start hoga
            right: 20,
            child: MiniPlayer(),
          ),
        ],
      ),
    );
  }

  Widget _sideMenuItem(IconData icon, String title, bool isActive) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isActive ? Colors.white.withOpacity(0.05) : Colors.transparent,
        ),
        child: ListTile(
          leading: Icon(icon,
              color: isActive ? Colors.white : Colors.grey, size: 28),
          title: Text(title,
              style: TextStyle(
                  color: isActive ? Colors.white : Colors.grey,
                  fontWeight: FontWeight.w600)),
          dense: true,
        ),
      ),
    );
  }
}
