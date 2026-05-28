import 'dart:convert';
import 'package:flutter/services.dart';

class ImageModel {
  final String id;
  final String description;
  final String imageUrl;
  final String imageHint;

  ImageModel({
    required this.id,
    required this.description,
    required this.imageUrl,
    required this.imageHint,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      imageHint: json['imageHint'],
    );
  }
}

class ImageService {
  static Future<List<ImageModel>> loadPlaceholderImages() async {
    try {
      final String response = await rootBundle.loadString(
        'lib/placeholder-images.json',
      );
      final data = jsonDecode(response);
      final List<dynamic> images = data['placeholderImages'];
      return images
          .map((img) => ImageModel.fromJson(img as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error loading images: $e');
      return [];
    }
  }

  static String getImageUrl(String id) {
    final imageMap = {
      'hero-artist': 'https://picsum.photos/seed/artist1/1200/600',
      'album-1': 'https://picsum.photos/seed/album1/400/400',
      'album-2': 'https://picsum.photos/seed/album2/400/400',
      'album-3': 'https://picsum.photos/seed/album3/400/400',
      'artist-avatar-1': 'https://picsum.photos/seed/p1/300/300',
      'genre-pop': 'https://picsum.photos/seed/pop/400/250',
      'genre-rock': 'https://picsum.photos/seed/rock/400/250',
      'genre-jazz': 'https://picsum.photos/seed/jazz/400/250',
    };
    return imageMap[id] ?? 'https://picsum.photos/seed/default/400/400';
  }
}
