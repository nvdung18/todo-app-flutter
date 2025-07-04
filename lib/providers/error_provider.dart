import 'package:flutter/material.dart';

class GlobalErrorHandler extends ChangeNotifier {
  Exception? error;

  static final GlobalErrorHandler instance = GlobalErrorHandler._internal();

  GlobalErrorHandler._internal();

  void setError(Exception e) {
    error = e;
    notifyListeners();
  }

  void clear() {
    error = null;
    notifyListeners();
  }
}
