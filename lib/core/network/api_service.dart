import 'package:movies_app/core/network/api_const.dart';
import 'package:movies_app/core/network/dio_client.dart';

import '../errors/network_exceptions.dart';

class MovieService {
  final DioClient dioClient;

  MovieService(this.dioClient);

  Future<dynamic> getMovieSuggestions(int movieId) async {
    try {
      final response = await dioClient.dio.get(
       ApiConst.sugEndPoint,
        queryParameters: {
          'movie_id': movieId,
        },
      );

      return response.data;
    } catch (error) {
      throw NetworkExceptions.getDioException(error);
    }
  }
}