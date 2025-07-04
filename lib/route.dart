import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth_wrapper.dart';
import 'package:flutter_application_1/models/todo_model2.dart';
import 'package:flutter_application_1/views/screens/addtask_page.dart';
import 'package:flutter_application_1/views/screens/blog_page.dart';
import 'package:flutter_application_1/views/screens/edittask_page.dart';
import 'package:flutter_application_1/views/screens/list_friend_page.dart';
import 'package:flutter_application_1/views/screens/search_blog_page.dart';
import 'package:flutter_application_1/views/screens/setting_page.dart';
import 'package:flutter_application_1/views/screens/signin_page.dart';
import 'package:flutter_application_1/views/screens/signup_page.dart';
import 'package:flutter_application_1/views/widget_tree.dart';

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
        return WidgetTree();
        // return BlogPage();
        // return ListFriendPage();
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
          path: 'edit-task/:id', // id here is index of task in list todos
          name: 'edit-task',
          builder: (context, state) {
            final id = state.pathParameters['id'];
            final todo = state.extra as TodoModel2?;
            return EditTaskPage(task: todo!, taskIndex: int.parse(id ?? '0'));
          },
        ),
        GoRoute(
          path: 'add-task',
          name: 'add-task',
          builder: (context, state) {
            return const AddTaskPage();
          },
        ),
        GoRoute(
          path: 'list-friend',
          name: 'list-friend',
          builder: (context, state) {
            return const ListFriendPage();
          },
        ),
        GoRoute(
          path: 'blog',
          name: 'blog',
          builder: (context, state) {
            return const BlogPage();
          },
        ),
        GoRoute(
          path: 'search',
          name: 'search',
          builder: (context, state) {
            return const SearchPage();
          },
        ),
      ],
    ),
  ],
);
