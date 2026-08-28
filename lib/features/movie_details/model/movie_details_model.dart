import 'cast_model.dart';

class MovieDetailsModel {
  final int id;
  final String title;
  final String titleLong;
  final int year;
  final double rating;
  final int runtime;
  final String description;
  final String backgroundImage;
  final String coverImage;
  final int likeCount;
  final String mediumScreenshotImage1;
  final String mediumScreenshotImage2;
  final String mediumScreenshotImage3;
  final String largeScreenshotImage1;
  final String largeScreenshotImage2;
  final String largeScreenshotImage3;
  final List<String> genres;
  final List<CastModel> cast;

  MovieDetailsModel({
    required this.id,
    required this.title,
    required this.titleLong,
    required this.year,
    required this.rating,
    required this.runtime,
    required this.description,
    required this.backgroundImage,
    required this.coverImage,
    required this.likeCount,
    required this.genres,
    required this.cast,
    required this.mediumScreenshotImage1,
    required this.mediumScreenshotImage2,
    required this.mediumScreenshotImage3,
    required this.largeScreenshotImage1,
    required this.largeScreenshotImage2,
    required this.largeScreenshotImage3,
  });

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailsModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      titleLong: json['title_long'] ?? '',
      year: json['year'] ?? 0,
      rating: (json['rating'] ?? 0).toDouble(),
      runtime: json['runtime'] ?? 0,
      description: json['description_full'] ?? '',
      backgroundImage: json['background_image'] ?? '',
      coverImage: json['large_cover_image'] ?? '',
      likeCount: json['like_count'] ?? 0,
      mediumScreenshotImage1: json['medium_screenshot_image1'] ?? '',
      mediumScreenshotImage2: json['medium_screenshot_image2'] ?? '',
      mediumScreenshotImage3: json['medium_screenshot_image3'] ?? '',
      largeScreenshotImage1: json['large_screenshot_image1'] ?? '',
      largeScreenshotImage2: json['large_screenshot_image2'] ?? '',
      largeScreenshotImage3: json['large_screenshot_image3'] ?? '',

      genres: List<String>.from(json['genres'] ?? []),

      cast: (json['cast'] as List? ?? [])
          .map((e) => CastModel.fromJson(e))
          .toList(),
    );
  }
}
