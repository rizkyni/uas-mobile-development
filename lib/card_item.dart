import 'dart:convert';
import 'dart:typed_data';

class CardItem {
  final String title;
  final String pricing;
  final Uint8List image;

  CardItem({
    required this.title,
    required this.pricing,
    required this.image,
  });

  factory CardItem.fromJson(Map<String, dynamic> json) {
    return CardItem(
      title: json['title'],
      pricing: json['pricing'],
      image: base64Decode(json['image']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'pricing': pricing,
      'image': base64Encode(image),
    };
  }
}
