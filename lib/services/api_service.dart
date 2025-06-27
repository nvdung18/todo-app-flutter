import 'package:flutter_application_1/configs/api_config.dart';
import 'package:flutter_application_1/services/user_service.dart';

class ApiService {
  static UserService userService = UserService(ApiConfig.dio);
}
