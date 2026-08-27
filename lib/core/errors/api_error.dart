class ApiError implements Exception {
  final String message;
  final int? statusCode;

  ApiError({required this.message, this.statusCode});

  @override
  String toString() {
    return 'Error occurred: $message\n'
        'Status code: $statusCode';
  }
}
