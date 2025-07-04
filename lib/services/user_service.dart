import 'package:dio/dio.dart';
import 'package:flutter_application_1/models/user_login_model.dart';
import 'package:flutter_application_1/models/user_login_response_model.dart';
import 'package:flutter_application_1/models/user_model.dart';
import 'package:retrofit/retrofit.dart';

part 'user_service.g.dart';

@RestApi()
abstract class UserService {
  factory UserService(Dio dio, {String baseUrl}) = _UserService;

  @GET('/users')
  Future<List<UserModel>> getUsers();

  @POST('/user/login')
  Future<UserLoginResponseModel> userLogin(@Body() UserLoginModel user);

  @PUT('/users/{id}')
  Future<dynamic> updateUser(
    @Path("id") String id,
    @Body() Map<String, dynamic> user,
  );

  @DELETE('/users/{id}')
  Future<dynamic> deleteUser(@Path("id") String id);
}
