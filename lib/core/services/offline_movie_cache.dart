import 'package:hive_flutter/hive_flutter.dart';
import 'package:movies_app/features/home/browse_tab/model/movie_model.dart';
import 'package:movies_app/features/movie_details/model/movie_details_model.dart';

class OfflineMovieCache {
  static const String _boxName = 'offline_movies';
  static Box<dynamic>? _box;

  static Future<void> init() async {
    await Hive.initFlutter();
    _box ??= await Hive.openBox<dynamic>(_boxName);
  }

  static Box<dynamic> get box {
    final value = _box;
    if (value == null) {
      throw StateError('OfflineMovieCache is not initialized.');
    }
    return value;
  }

  static Future<void> saveMovie(MovieDetailsModel movie) async {
    await box.put(movie.id.toString(), {
      'id': movie.id,
      'title': movie.title,
      'image': movie.coverImage,
      'rating': movie.rating,
    });
  }

  static Future<void> saveMovies(List<MovieDetailsModel> movies) async {
    for (final movie in movies) {
      await saveMovie(movie);
    }
  }

  static Future<MovieModel?> loadMovie(String id) async {
    final rawMovie = box.get(id);
    if (rawMovie is! Map) {
      return null;
    }

    final movieMap = Map<String, dynamic>.from(rawMovie);
    final title = (movieMap['title'] ?? '').toString();
    final image = (movieMap['image'] ?? '').toString();
    final idValue = int.tryParse(id) ?? (movieMap['id'] as int? ?? 0);

    if (title.isEmpty && image.isEmpty && idValue == 0) {
      return null;
    }

    return MovieModel(
      id: idValue,
      rating: (movieMap['rating'] as num?)?.toDouble() ?? 0,
      image: image,
      genres: const [],
      title: title,
    );
  }

  static Future<List<MovieModel>> loadMovies(List<String> ids) async {
    final cachedMovies = <MovieModel>[];

    for (final id in ids) {
      final movie = await loadMovie(id);
      if (movie != null) {
        cachedMovies.add(movie);
      }
    }

    return cachedMovies;
  }
}
