import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../models/song_model.dart';

class AudioProvider extends ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  Song? _currentSong;
  bool _isPlaying = false;

  Song? get currentSong => _currentSong;
  bool get isPlaying => _isPlaying;

  AudioProvider() {
    // Listen to player state changes
    _audioPlayer.playingStream.listen((playing) {
      _isPlaying = playing;
      notifyListeners();
    });
  }

  void playSong(Song song) async {
    try {
      if (_currentSong?.id == song.id) {
        togglePlay();
      } else {
        _currentSong = song;
        notifyListeners();

        // Naya gaana load aur play karne ka sahi tarika
        await _audioPlayer.stop(); // Purana gaana band karo
        await _audioPlayer.setUrl(song.audioUrl);
        await _audioPlayer.play();
      }
    } catch (e) {
      debugPrint("Audio Error: $e");
    }
  }

  void togglePlay() async {
    try {
      if (_isPlaying) {
        await _audioPlayer.pause();
      } else {
        await _audioPlayer.play();
      }
    } catch (e) {
      debugPrint("Toggle Error: $e");
    }
  }
}
