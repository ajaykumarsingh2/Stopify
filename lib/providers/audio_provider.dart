import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../models/song_model.dart';

class AudioProvider extends ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  Song? _currentSong;
  bool _isPlaying = false;

  Song? get currentSong => _currentSong;
  bool get isPlaying => _isPlaying;
  AudioPlayer get player => _audioPlayer;

  void playSong(Song song) async {
    if (_currentSong?.id == song.id) {
      togglePlay();
    } else {
      _currentSong = song;
      notifyListeners();
      try {
        await _audioPlayer.setUrl(song.audioUrl);
        _audioPlayer.play();
        _isPlaying = true;
      } catch (e) {
        print("Error loading audio: $e");
      }
    }

    _audioPlayer.playingStream.listen((playing) {
      _isPlaying = playing;
      notifyListeners();
    });
  }

  void togglePlay() {
    if (_isPlaying) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play();
    }
    _isPlaying = !_isPlaying;
    notifyListeners();
  }
}
