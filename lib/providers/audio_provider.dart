import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../models/song_model.dart';

class AudioProvider extends ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  Song? _currentSong;

  Song? get currentSong => _currentSong;
  bool get isPlaying => _audioPlayer.playing;
  Duration position = Duration.zero;
  Duration duration = Duration.zero;

  AudioProvider() {
    _audioPlayer.positionStream.listen((p) {
      position = p;
      notifyListeners();
    });
    _audioPlayer.durationStream.listen((d) {
      duration = d ?? Duration.zero;
      notifyListeners();
    });
    _audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        _audioPlayer.pause();
        _audioPlayer.seek(Duration.zero);
      }
      notifyListeners();
    });
  }

  void playSong(Song song) async {
    try {
      _currentSong = song;
      notifyListeners();

      // Web ke liye robust logic
      await _audioPlayer.stop();
      await _audioPlayer.setUrl(song.audioUrl);
      await _audioPlayer.play(); // Direct play
    } catch (e) {
      debugPrint("Audio Play Error: $e");
    }
  }

  void togglePlay() async {
    if (_audioPlayer.playing) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play();
    }
    notifyListeners();
  }

  void seek(Duration pos) => _audioPlayer.seek(pos);

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
