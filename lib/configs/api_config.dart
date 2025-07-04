import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig {
  ApiConfig._internal();
  static final ApiConfig instance = ApiConfig._internal();

  late Dio dio = Dio(
    BaseOptions(
      baseUrl: dotenv.env['BASE_URL_DUMMYJSON']!,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  void _changeBaseUrl(String baseUrl) {
    dio.options.baseUrl = baseUrl;
  }

  Dio getApiService1() {
    _changeBaseUrl(dotenv.env['BASE_URL_DUMMYJSON']!);
    return dio;
  }

  Dio getApiService2() {
    _changeBaseUrl(dotenv.env['BASE_URL_JSONPLACEHOLDER']!);
    return dio;
  }
}
