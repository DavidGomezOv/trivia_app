class NetworkException implements Exception {
  final String message;

  NetworkException({required this.message});
}

class ApiException implements Exception {
  final int? code;
  final String message;

  ApiException({required this.code, required this.message});
}
