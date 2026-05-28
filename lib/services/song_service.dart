import '../models/song.dart';
import '../data/songs_data.dart';

class SongService {
  static Future<List<Song>> getSongs() async {
    return songs;
  }
}
