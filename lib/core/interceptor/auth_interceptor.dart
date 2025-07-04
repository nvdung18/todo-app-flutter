import 'package:dio/dio.dart';
import 'package:flutter_application_1/core/token_manager.dart';
import 'package:logger/logger.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await TokenManager.getToken(); // Đổi thành async
    Logger().i('Token in interceptor: $token');
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      TokenManager.clearToken();
      // Navigate to login or refresh token
    }
    handler.next(err);
  }
}
