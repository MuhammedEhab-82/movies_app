class MovieSuggestionModel {
  final int id;
  final String title;
  final double rating;
  final String image;

  MovieSuggestionModel({
    required this.id,
    required this.title,
    required this.rating,
    required this.image,
  });

  factory MovieSuggestionModel.fromJson(Map<String, dynamic> json) {
    return MovieSuggestionModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      image: json['medium_cover_image'] ?? '',
    );
  }
}
