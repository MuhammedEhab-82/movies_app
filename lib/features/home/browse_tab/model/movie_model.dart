class MovieModel {
  final int id;
  final double rating;
  final String image;
  final List<String> genres;

  MovieModel({
    required this.id,
    required this.rating,
    required this.image,
    required this.genres,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'] ?? 0,
      rating: (json['rating'] ?? 0).toDouble(),
      image: json['medium_cover_image'] ?? '',
      genres: List<String>.from(
        json['genres'] ?? [],
      ),
    );
  }
}