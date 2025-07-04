import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/responses/error_handler.dart';
import 'package:flutter_application_1/providers/signin_provider.dart';
import 'package:flutter_application_1/providers/theme_provider.dart';
import 'package:flutter_application_1/providers/todo_provider.dart';
import 'package:flutter_application_1/route.dart';
import 'package:flutter_application_1/utils/constant.dart';
import 'package:flutter_application_1/views/global_listener.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_application_1/views/screens/welcome_page.dart';
import 'package:flutter/foundation.dart';
import 'dart:ui';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  final prefs = await SharedPreferences.getInstance();
  final isDarkMode = prefs.getBool(KConstants.themeModeKey) ?? false;

  await errorHandler.initialize();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider()..isDarkMode = isDarkMode,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => TodoProvider()),
          ChangeNotifierProvider(create: (context) => SigninProvider()),
        ],
        // child: GlobalErrorListener(child: const MyApp()),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // var themeProvider = context.watch<ThemeProvider>();
    var isDarkMode = context.select<ThemeProvider, bool>(
      (provider) => provider.isDarkMode,
    );
    return MaterialApp.router(
      title: 'Todo App',
      routerConfig: route,
      builder: (context, widget) => GlobalErrorListener(child: widget!),
      // initialRoute: '/',
      // routes: {
      //   '/home': (context) => const HomePage(),
      //   '/signin': (context) => const SignInPage(),
      //   '/signup': (context) => const SignUpPage(),
      // },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: isDarkMode ? Brightness.dark : Brightness.light,
        ),
      ),
    );
  }
}
