import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/dio_config.dart';
import 'package:flutter_application_1/core/responses/result.dart';
import 'package:flutter_application_1/models/user_model.dart';
import 'package:flutter_application_1/providers/error_provider.dart';
import 'package:flutter_application_1/repos/post_repo.dart';
import 'package:flutter_application_1/repos/user_repo.dart';
import 'package:flutter_application_1/services/post_service.dart';
import 'package:flutter_application_1/services/user_service.dart';
import 'package:flutter_application_1/utils/constant.dart';

class UserProvider extends ChangeNotifier {
  List<UserModel>? _users;

  List<UserModel>? get users => _users;

  Dio dummyAPI = DioFactory.getDio(KUrl.DUMMYJSON);

  Dio jsonPlaceholderAPI = DioFactory.getDio(KUrl.JSONPLACEHOLDER);

  Future<dynamic> updateUser(String id, Map<String, dynamic> user) async {
    // service2=service2.com
    final result = await UserRepository(
      userService: UserService(dummyAPI),
    ).updateUser(id, user);

    switch (result) {
      case Ok(value: final users):
        _users = users;
        break;
      case Error(error: final e):
        print('Error: $e');
        GlobalErrorHandler.instance.setError(result.error);
        break;
    }
    return _users;
  }

  Future<List<UserModel>?> fetchUsers() async {
    // service1=service1.com
    final result = await UserRepository(
      userService: UserService(jsonPlaceholderAPI),
    ).getUsers();

    switch (result) {
      case Ok(value: final users):
        _users = users;
        break;
      case Error(error: final e):
        print('Error: $e');
        GlobalErrorHandler.instance.setError(result.error);
        break;
    }
    return _users;
  }
}

//  Dio get dio => ApiConfig.instance.getApiService1();
//   UserService get userService =>
//       ApiService.getUserService(dio); // cách khác nếu không dùng UserRepository

//   UserRepository userRepository = UserRepository(
//     userService: ApiService.getUserService(ApiConfig.instance.getApiService1()),
//   ); // cách dùng với repository

//   Future<dynamic> updateUser(String id, Map<String, dynamic> user) async {
//     // service2=service2.com
//     final result = await userService.updateUser(id, user);

//     switch (result) {
//       case Ok(value: final users):
//         _users = users;
//         break;
//       case Error(error: final e):
//         print('Error: $e');
//         GlobalErrorHandler.instance.setError(result.error);
//         break;
//     }
//     return _users;
//   }

//   Future<List<UserModel>?> fetchUsers() async {
//     // service1=service1.com
//     final result = await userRepository.getUsers();

//     switch (result) {
//       case Ok(value: final users):
//         _users = users;
//         break;
//       case Error(error: final e):
//         print('Error: $e');
//         GlobalErrorHandler.instance.setError(result.error);
//         break;
//     }
//     return _users;

//     // final users = await ApiService.userService.getUsers();
//     // _users = users;
//     // return _users;
//   }
