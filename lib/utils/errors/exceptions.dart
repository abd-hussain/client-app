class HttpException implements Exception {
  final String message;
  final int status;

  HttpException({required this.status, required this.message});
}
