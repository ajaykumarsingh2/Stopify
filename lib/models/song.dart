class Song {
  final String title;
  final String artist;
  final String url;
  final String? imageUrl;

  Song({required this.title, required this.artist, String? url, this.imageUrl})
    : url = url ?? '';

  factory Song.fromMap(Map<String, dynamic> map) {
    return Song(
      title: map['title'],
      artist: map['artist'],
      url: map['url'],
      imageUrl: map['imageUrl'],
    );
  }
}
