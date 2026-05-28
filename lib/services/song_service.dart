import '../models/song.dart';
import '../data/songs.dart';

class SongService {
  static Future<List<Song>> getSongs() async {
    // Return local sample songs for offline/demo use
    return songs;
  }
}
