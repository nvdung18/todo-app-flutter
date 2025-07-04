import 'package:dio/dio.dart';
import 'package:flutter_application_1/core/api_endpoint.dart';
import 'package:flutter_application_1/core/interceptor/auth_interceptor.dart';

class DioFactory {
  static final Map<String, Dio> _dioInstances = {};
  static Environment _currentEnvironment = Environment.dev;

  static void setEnvironment(Environment env) {
    _currentEnvironment = env;
    _dioInstances.clear(); // Clear cached instances
  }

  static Dio getDio(String service, {Map<String, dynamic>? headers}) {
    final key = '${_currentEnvironment.name}_$service';

    if (!_dioInstances.containsKey(key)) {
      final baseUrl = ApiEndpoints.getBaseUrl(_currentEnvironment, service);
      _dioInstances[key] = _createDio(baseUrl, service, headers);
    }

    return _dioInstances[key]!;
  }

  static Dio _createDio(
    String baseUrl,
    String service,
    Map<String, dynamic>? customHeaders,
  ) {
    final dio = Dio();

    dio.options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        // ..._getServiceSpecificHeaders(service),
        ...?customHeaders,
      },
    );

    // Add interceptors
    dio.interceptors.add(AuthInterceptor());
    dio.interceptors.add(
      _currentEnvironment == Environment.dev
          ? LogInterceptor(
              requestBody: true,
              responseBody: true,
              logPrint: (object) => print(object),
            )
          : LogInterceptor(requestBody: false, responseBody: false),
    );

    return dio;
  }

  // static Map<String, dynamic> _getServiceSpecificHeaders(String service) {
  //   switch (service) {
  //     case 'payment':
  //       return {'X-Payment-Version': '2.0'};
  //     case 'user':
  //       return {'X-User-Version': '1.1'};
  //     default:
  //       return {};
  //   }
  // }
}
