import 'package:dio/dio.dart';
import 'package:movies_app/core/network/api_const.dart';

class DioClient {
  final Dio dio;

  DioClient()
    : dio = Dio(
        BaseOptions(
          baseUrl: ApiConst.baseUrl,
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          sendTimeout: const Duration(seconds: 30),
        ),
      ) {
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      ),
    );
  }
}