import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/api_config.dart';
import 'package:flutter_application_1/core/token_manager.dart';
import 'package:flutter_application_1/models/user_login_model.dart';
import 'package:flutter_application_1/services/api_service.dart';
import 'package:flutter_application_1/utils/constant.dart';
import 'package:logger/web.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninProvider extends ChangeNotifier {
  String email = 'nvandung296@gmail.com';
  String password = '1234567';

  Future<bool> loginProcess(String userName, String password) async {
    try {
      final value = await ApiService.getUserService(
        ApiConfig.instance.getApiService1(),
      ).userLogin(UserLoginModel(username: userName, password: password));

      await TokenManager.setToken(value.accessToken);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(KConstants.signInKey, true);
      notifyListeners();
      return true;
    } catch (error) {
      print('Login failed: $error');
      return false;
    }
  }
}
