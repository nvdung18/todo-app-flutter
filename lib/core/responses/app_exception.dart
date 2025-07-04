class AppException implements Exception {
  final String message;
  AppException([this.message = 'Unknown Error']);

  @override
  String toString() => message;
}
