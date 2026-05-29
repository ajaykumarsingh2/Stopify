import '../models/song_model.dart';

final List<Song> playlist = List.generate(
    15,
    (i) => Song(
          id: '$i',
          title: 'Global Hit ${i + 1}',
          artist: 'Artist ${i + 1}',
          coverUrl: 'https://picsum.photos/seed/${i + 50}/500/500',
          audioUrl:
              'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-${(i % 5) + 1}.mp3',
        ));
