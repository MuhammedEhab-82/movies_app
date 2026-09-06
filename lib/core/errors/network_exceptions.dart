import 'dart:io';

import 'package:dio/dio.dart';

import 'api_error.dart';

class NetworkExceptions {
  static ApiError getDioException(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.cancel:
          return ApiError(
            message: 'Request cancelled',
            statusCode: error.response?.statusCode,
          );

        case DioExceptionType.connectionTimeout:
          return ApiError(
            message: 'Connection timeout',
            statusCode: error.response?.statusCode,
          );

        case DioExceptionType.sendTimeout:
          return ApiError(
            message: 'Send timeout',
            statusCode: error.response?.statusCode,
          );

        case DioExceptionType.receiveTimeout:
          return ApiError(
            message: 'Receive timeout',
            statusCode: error.response?.statusCode,
          );

        case DioExceptionType.badCertificate:
          return ApiError(
            message: 'Bad certificate',
            statusCode: error.response?.statusCode,
          );

        case DioExceptionType.connectionError:
          return ApiError(
            message: 'No internet connection',
            statusCode: error.response?.statusCode,
          );

        case DioExceptionType.badResponse:
          return handleResponse(error.response);

        case DioExceptionType.unknown:
          if (error.error is SocketException) {
            return ApiError(
              message: 'No internet connection: ${error.error}',
            );
          }

          return ApiError(
            message: error.error?.toString() ??
                error.message ??
                'Unknown Dio error',
            statusCode: error.response?.statusCode,
          );
        default:
          return ApiError(
            message: 'Unexpected error occurred',
            statusCode: error.response?.statusCode,
          );
      }
    }

    if (error is SocketException) {
      return ApiError(
        message: 'No internet connection',
      );
    }

    if (error is FormatException) {
      return ApiError(
        message: 'Unable to process the data',
      );
    }

    return ApiError(
      message: error.toString(),
    );
  }

  static ApiError handleResponse(Response? response) {
    final statusCode = response?.statusCode;

    String message = 'Something went wrong';

    final data = response?.data;

    if (data is Map<String, dynamic>) {
      message = data['status_message'] ??
          data['message'] ??
          data['error'] ??
          message;
    }

    switch (statusCode) {
      case 400:
        return ApiError(
          message: message,
          statusCode: statusCode,
        );

      case 401:
        return ApiError(
          message: 'Unauthorized request',
          statusCode: statusCode,
        );

      case 403:
        return ApiError(
          message: 'Forbidden request',
          statusCode: statusCode,
        );

      case 404:
        return ApiError(
          message: 'Resource not found',
          statusCode: statusCode,
        );

      case 408:
        return ApiError(
          message: 'Request timeout',
          statusCode: statusCode,
        );

      case 409:
        return ApiError(
          message: 'Conflict occurred',
          statusCode: statusCode,
        );

      case 422:
        return ApiError(
          message: message,
          statusCode: statusCode,
        );

      case 500:
        return ApiError(
          message: 'Internal server error',
          statusCode: statusCode,
        );

      case 503:
        return ApiError(
          message: 'Service unavailable',
          statusCode: statusCode,
        );

      default:
        return ApiError(
          message: message,
          statusCode: statusCode,
        );
    }
  }
}