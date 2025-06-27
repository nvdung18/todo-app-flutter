import 'package:dio/dio.dart';
import 'package:flutter_application_1/models/user_model.dart';
import 'package:retrofit/retrofit.dart';

part 'user_service.g.dart';

@RestApi()
abstract class UserService {
  factory UserService(Dio dio, {String baseUrl}) = _UserService;

  @GET('/users')
  Future<List<UserModel>> getUsers();
}
