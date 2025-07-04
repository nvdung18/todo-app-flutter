import 'package:flutter_application_1/utils/constant.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

enum Environment { dev, staging, prod }

class ApiEndpoints {
  static final Map<Environment, Map<String, String>> _endpoints = {
    Environment.dev: {
      KUrl.JSONPLACEHOLDER: dotenv.env['BASE_URL_JSONPLACEHOLDER']!,
      KUrl.DUMMYJSON: dotenv.env['BASE_URL_DUMMYJSON']!,
    },
    Environment.staging: {
      KUrl.JSONPLACEHOLDER: dotenv.env['BASE_URL_JSONPLACEHOLDER']!,
      KUrl.DUMMYJSON: dotenv.env['BASE_URL_DUMMYJSON']!,
    },
    Environment.prod: {
      KUrl.JSONPLACEHOLDER: dotenv.env['BASE_URL_JSONPLACEHOLDER']!,
      KUrl.DUMMYJSON: dotenv.env['BASE_URL_DUMMYJSON']!,
    },
  };

  static String getBaseUrl(Environment env, String service) {
    return _endpoints[env]![service]!;
  }
}
