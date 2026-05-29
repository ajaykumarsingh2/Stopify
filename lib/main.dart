import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/audio_provider.dart';
import 'screens/home_screen.dart';
import 'screens/search_screen.dart';
import 'screens/library_screen.dart';
import 'widgets/mini_player.dart';

void main() => runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => AudioProvider())],
    child: const StopifyApp()));

class StopifyApp extends StatelessWidget {
  const StopifyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black),
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
  int _idx = 0;
  final List<Widget> _pages = [HomeScreen(), SearchScreen(), LibraryScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Row(children: [
            Container(
              width: 240,
              color: const Color(0xFF09090B),
              child: Column(children: [
                const ListTile(
                    leading: Icon(Icons.music_note, color: Colors.purpleAccent),
                    title: Text("Stopify",
                        style: TextStyle(fontWeight: FontWeight.bold))),
                _navItem(Icons.home, "Home", 0),
                _navItem(Icons.search, "Search", 1),
                _navItem(Icons.library_music, "Library", 2),
              ]),
            ),
            Expanded(child: _pages[_idx]),
          ]),
          Positioned(bottom: 20, left: 260, right: 20, child: MiniPlayer()),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, String title, int i) => ListTile(
        leading:
            Icon(icon, color: _idx == i ? Colors.purpleAccent : Colors.grey),
        title: Text(title,
            style: TextStyle(color: _idx == i ? Colors.white : Colors.grey)),
        onTap: () => setState(() => _idx = i),
      );
}
