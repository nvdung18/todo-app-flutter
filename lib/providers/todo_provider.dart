import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/todo_model.dart';
import 'package:flutter_application_1/services/todo_service.dart';

class TodoProvider with ChangeNotifier {
  final TodoService _todoService = TodoService();
  List<TodoModel> _todos = [];

  List<TodoModel> get todos => _todos;

  Future<void> fetchTodos() async {
    try {
      _todos = await _todoService.fetchTodos();
      print(_todos);
      notifyListeners();
    } catch (e) {
      // Handle error
    }
  }
}
