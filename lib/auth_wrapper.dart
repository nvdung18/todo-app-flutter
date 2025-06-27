import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/constant.dart';
import 'package:flutter_application_1/views/screens/welcome_page.dart';
import 'package:flutter_application_1/views/widget_tree.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: checkAuthStatus(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return snapshot.data ?? const WelcomePage();
      },
    );
  }

  Future<Widget> checkAuthStatus(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final isSignedIn = prefs.getBool(KConstants.signInKey) ?? false;

    if (isSignedIn) {
      // User is signed in, navigate to HomePage
      return WidgetTree();
    }
    return const WelcomePage();
  }
}
