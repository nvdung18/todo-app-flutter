import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninProvider extends ChangeNotifier {
  String email = '123';
  String password = '456';

  Future<bool> loginProcess(String email, String password) async {
    if (this.email == email && this.password == password) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(KConstants.signInKey, true);
      return true;
    }
    return false;
  }
}
