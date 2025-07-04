import 'package:dio/dio.dart';
import 'package:flutter_application_1/services/user_service.dart';

class ApiService {
  static UserService getUserService(Dio dioInstance) =>
      UserService(dioInstance);
}
