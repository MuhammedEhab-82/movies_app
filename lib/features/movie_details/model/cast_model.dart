class CastModel {
  final String name;
  final String characterName;
  final String image;

  CastModel({
    required this.name,
    required this.characterName,
    required this.image,
  });

  factory CastModel.fromJson(Map<String, dynamic> json) {
    return CastModel(
      name: json['name'] ?? '',
      characterName: json['character_name'] ?? '',
      image: json['url_small_image'] ?? '',
    );
  }
}
