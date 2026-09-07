import 'package:movies_app/core/network/api_const.dart';
import 'package:movies_app/core/network/dio_client.dart';
import 'package:movies_app/features/home/browse_tab/model/movie_model.dart';
import '../../features/movie_details/model/movie_details_model.dart';
import '../../features/movie_details/model/movie_suggestion_model.dart';
import '../errors/network_exceptions.dart';

class MovieService {
  final DioClient dioClient;

  MovieService(this.dioClient);

  Future<List<MovieModel>> getAllMovies({
    int limit = 20,
    String? genre,
    String? sortBy = 'date_added',
    String? movieName,
  }) async {
    try {
      final response = await dioClient.dio.get(
        ApiConst.allMoviesEndPoint,
        queryParameters: {
          'limit': limit,
          'sort_by': sortBy,
          'genre': genre,
          'query_term': movieName,
        },
      );

      final data = response.data?['data'];
      final movies = data?['movies'];

      // Request succeeded but there are no movies
      if (movies == null) {
        return [];
      }

      return (movies as List)
          .map((movie) => MovieModel.fromJson(movie))
          .toList();
    } catch (error) {
      throw NetworkExceptions.getDioException(error);
    }
  }

  Future<MovieDetailsModel> getMovieDetails(int movieId) async {
    try {
      final response = await dioClient.dio.get(
        ApiConst.movieDetailsEndPoint,
        queryParameters: {
          'movie_id': movieId,
          'with_images': true,
          'with_cast': true,
        },
      );

      if (response.data != null &&
          response.data['data'] != null &&
          response.data['data']['movie'] != null) {
        return MovieDetailsModel.fromJson(
          response.data['data']['movie'],
        );
      } else {
        throw Exception('Movie data not found');
      }
    } catch (error) {
      throw NetworkExceptions.getDioException(error);
    }
  }

  Future<List<MovieSuggestionModel>> getMovieSuggestions(
      int movieId,
      ) async {
    try {
      final response = await dioClient.dio.get(
        ApiConst.sugEndPoint,
        queryParameters: {
          'movie_id': movieId,
        },
      );

      if (response.data != null &&
          response.data['data'] != null &&
          response.data['data']['movies'] != null) {
        final List movies = response.data['data']['movies'];

        return movies
            .map(
              (movie) => MovieSuggestionModel.fromJson(movie),
        )
            .toList();
      } else {
        return [];
      }
    } catch (error) {
      throw NetworkExceptions.getDioException(error);
    }
  }
}