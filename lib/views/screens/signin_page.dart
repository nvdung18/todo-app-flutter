import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/signin_provider.dart';
import 'package:flutter_application_1/utils/constant.dart';
import 'package:flutter_application_1/views/screens/home_page.dart';
import 'package:flutter_application_1/views/styles/app_color.dart';
import 'package:flutter_application_1/views/widgets/welcome_hero_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPw = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var signInProvider = context.watch<SigninProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                WelcomeHeroWidget(height: 200),
                TextField(
                  decoration: InputDecoration(labelText: 'Email'),
                  controller: _controllerEmail,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Password'),
                  controller: _controllerPw,
                  obscureText: true,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: AppColors.primary,
                  ),
                  onPressed: () {
                    onSignInPress(provider: signInProvider);
                  },
                  child: Text(
                    'Sign In',
                    style: TextStyle(color: AppColors.text),
                  ),
                ),
                SizedBox(height: 20),
                Text('or Sign in with'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.abc),
                      onPressed: () {
                        // Handle Abc sign in
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.facebook),
                      onPressed: () {
                        // Handle Facebook sign in
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.apple),
                      onPressed: () {
                        // Handle Apple sign in
                      },
                    ),
                  ],
                ),
                SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onSignInPress({SigninProvider? provider}) async {
    if (provider != null &&
        await provider.loginProcess(
          _controllerEmail.text,
          _controllerPw.text,
        )) {
      context.go('/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid email or password'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}
