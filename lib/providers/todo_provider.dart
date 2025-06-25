import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/todo_model2.dart';
// import 'package:flutter_application_1/services/todo_service.dart';
import 'package:flutter_application_1/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoProvider with ChangeNotifier {
  // final TodoService _todoService = TodoService();
  List<TodoModel2> _todos = [];

  List<TodoModel2> get todos => _todos;

  Future<bool> addTodo(TodoModel2 todo) async {
    _todos.add(todo);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      KConstants.todoKey,
      _todos.map((e) => e.toJson()).cast<String>().toList(),
    );
    notifyListeners();
    return true;
  }

  Future<void> removeTodo(int index) async {
    _todos.removeAt(index);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      KConstants.todoKey,
      _todos.map((e) => e.toJson()).cast<String>().toList(),
    );
    notifyListeners();
  }

  Future<void> updateTodo(int index, TodoModel2 todo) async {
    _todos[index] = todo;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      KConstants.todoKey,
      _todos.map((e) => e.toJson()).cast<String>().toList(),
    );
    notifyListeners();
  }

  Future<void> fetchTodos() async {
    try {
      // _todos = await _todoService.fetchTodos();
      // print(_todos);
      final prefs = await SharedPreferences.getInstance();
      final todoList = prefs.getStringList(KConstants.todoKey) ?? [];
      _todos = todoList
          .map((e) => TodoModel2.fromJson(e as Map<String, dynamic>))
          .toList();
      notifyListeners();
    } catch (e) {
      // Handle error
    }
  }
}
