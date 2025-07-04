import 'package:dio/dio.dart';
import 'package:flutter_application_1/core/responses/result.dart';

class NetworkHandler {
  /// Wrapper function to handle error and convert to Result<T>
  static Future<Result<T>> safeApiCall<T>(Future<T> Function() apiCall) async {
    try {
      final response = await apiCall();
      return Result.ok(response);
    } on DioException catch (e) {
      print('DioException API call failed: ${e}');
      return Result.error(_handleDioException(e));
    } on Exception catch (e) {
      print('Exception API call failed: ${e}');
      return Result.error(e);
    }
  }

  static Exception _handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return Exception('Connection timeout');
      case DioExceptionType.sendTimeout:
        return Exception('Send timeout');
      case DioExceptionType.receiveTimeout:
        return Exception('Receive timeout');
      case DioExceptionType.badCertificate:
        return Exception('Bad Certificate');
      case DioExceptionType.badResponse:
        return Exception(
          'Received invalid status code: ${e.response?.statusCode}',
        );
      case DioExceptionType.cancel:
        return Exception('Request to API server was cancelled');
      case DioExceptionType.connectionError:
        return Exception('Connection error');
      case DioExceptionType.unknown:
        return Exception('Unexpected error occurred');
    }
  }
}
