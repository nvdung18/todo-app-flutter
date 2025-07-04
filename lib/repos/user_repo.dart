import 'package:flutter_application_1/core/network_handler.dart';
import 'package:flutter_application_1/core/responses/result.dart';
import 'package:flutter_application_1/models/user_model.dart';
import 'package:flutter_application_1/services/user_service.dart';

class UserRepository {
  final UserService userService;

  factory UserRepository({required UserService userService}) {
    return UserRepository._internal(userService);
  }

  UserRepository._internal(this.userService);

  Future<Result<List<UserModel>>> getUsers() {
    return NetworkHandler.safeApiCall(() => userService.getUsers());
  }

  Future<Result<dynamic>> updateUser(String id, Map<String, dynamic> user) {
    return NetworkHandler.safeApiCall(() => userService.updateUser(id, user));
  }
}

// Có thể sử dụng thêm UserRepositoryFactory để quản lý instance, mỗi instance theo key, không bị override.
/**
  class UserRepositoryFactory {
    static final Map<String, UserRepository> _instances = {};

    static UserRepository getRepository(String key, UserService service) {
      return _instances.putIfAbsent(key, () => UserRepository(service));
    }
  }
 */
