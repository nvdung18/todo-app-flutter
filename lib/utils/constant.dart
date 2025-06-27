import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/screens/calender_page.dart';
import 'package:flutter_application_1/views/screens/focus_page.dart';
import 'package:flutter_application_1/views/screens/home_page.dart';
import 'package:flutter_application_1/views/screens/profile_page.dart';

class KConstants {
  static const String themeModeKey = 'themeMode';
  static const String signInKey = 'signIn';
  static const String todoKey = 'todo';
}

class KRoutes {
  static const String signIn = '/signin';
  static const String signUp = '/signup';
  static const String welcome = '/welcome';
  static const String home = '/home';
  static const String settings = '/settings';
  static const String addTask = '/add-task';
}

class KNavbar {
  static List<Map<String, dynamic>> pageNavBar() {
    return [
      {'title': 'Home', 'page': HomePage(), 'icon': Icons.home},
      {
        'title': 'Calendar',
        'page': CalenderPage(),
        'icon': Icons.calendar_month,
      },
      {'title': 'Focus', 'page': FocusPage(), 'icon': Icons.lock_clock},
      {'title': 'Profile', 'page': ProfilePage(), 'icon': Icons.person},
    ];
  }
}
