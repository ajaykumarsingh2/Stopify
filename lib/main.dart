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
        scaffoldBackgroundColor: const Color(0xFF09090B),
      ),
      home: const MainWrapper(),
    );
  }
}

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});
  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _selectedIndex = 0; // Kis screen par hain hum

  // Screens ki list
  final List<Widget> _screens = [
    HomeScreen(),
    const Center(
        child:
            Text("Search Screen Coming Soon", style: TextStyle(fontSize: 24))),
    const Center(
        child:
            Text("Library Screen Coming Soon", style: TextStyle(fontSize: 24))),
    const Center(
        child:
            Text("AI Discovery Coming Soon", style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Row(
            children: [
              // Sidebar
              Container(
                width: 240,
                decoration: const BoxDecoration(
                  color: Color(0xFF09090B),
                  border: Border(
                      right: BorderSide(color: Colors.white12, width: 0.5)),
                ),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Row(
                        children: [
                          Icon(Icons.music_note,
                              color: Colors.purpleAccent, size: 32),
                          SizedBox(width: 10),
                          Text("Stopify",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    _sideMenuItem(Icons.home_filled, "Home", 0),
                    _sideMenuItem(Icons.explore_outlined, "Explore", 1),
                    _sideMenuItem(Icons.auto_awesome, "AI Discovery", 2),
                    _sideMenuItem(Icons.library_music_outlined, "Library", 3),
                  ],
                ),
              ),
              // Dynamic Content
              Expanded(child: _screens[_selectedIndex]),
            ],
          ),
          // Floating Player
          Positioned(
            bottom: 20,
            left: 260,
            right: 20,
            child: MiniPlayer(),
          ),
        ],
      ),
    );
  }

  Widget _sideMenuItem(IconData icon, String title, int index) {
    bool isActive = _selectedIndex == index;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedIndex = index; // Click par screen change hogi
          });
        },
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: isActive
                ? Colors.purpleAccent.withOpacity(0.1)
                : Colors.transparent,
          ),
          child: Row(
            children: [
              Icon(icon,
                  color: isActive ? Colors.purpleAccent : Colors.grey,
                  size: 26),
              const SizedBox(width: 16),
              Text(title,
                  style: TextStyle(
                      color: isActive ? Colors.white : Colors.grey,
                      fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}
