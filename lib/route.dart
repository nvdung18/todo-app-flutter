import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth_wrapper.dart';
import 'package:flutter_application_1/views/screens/home_page.dart';
import 'package:flutter_application_1/views/screens/setting_page.dart';
import 'package:flutter_application_1/views/screens/signin_page.dart';
import 'package:flutter_application_1/views/screens/signup_page.dart';
import 'package:flutter_application_1/views/screens/task_page.dart';
import 'package:go_router/go_router.dart';

/// The route configuration.
final GoRouter route = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const AuthWrapper();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'signin',
          name: 'signin',
          builder: (BuildContext context, GoRouterState state) {
            return const SignInPage();
          },
        ),
        GoRoute(
          path: 'signup',
          name: 'signup',
          builder: (BuildContext context, GoRouterState state) {
            return const SignUpPage();
          },
        ),
      ],
    ),
    GoRoute(
      path: '/home',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'setting',
          name: 'setting',
          builder: (context, state) {
            return SettingPage(title: 'Setting');
          },
        ),
        GoRoute(
          path: 'add-task',
          name: 'add-task',
          builder: (context, state) {
            return TaskPage();
          },
        ),
      ],
    ),
  ],
);
