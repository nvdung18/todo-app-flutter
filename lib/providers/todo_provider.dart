import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/todo_model2.dart';
// import 'package:flutter_application_1/services/todo_service.dart';
import 'package:flutter_application_1/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // Add this import

class TodoProvider with ChangeNotifier {
  // final TodoService _todoService = TodoService();
  List<TodoModel2> _todos = [];

  List<TodoModel2> get todos => _todos;

  Future<bool> addTodo(TodoModel2 todo) async {
    _todos.add(todo);
    final prefs = await SharedPreferences.getInstance();
    // Convert to JSON strings properly
    await prefs.setStringList(
      KConstants.todoKey,
      _todos.map((e) => jsonEncode(e.toJson())).toList(),
    );
    notifyListeners();
    return true;
  }

  Future<void> removeTodo(int index) async {
    _todos.removeAt(index);
    final prefs = await SharedPreferences.getInstance();
    // Convert to JSON strings properly
    await prefs.setStringList(
      KConstants.todoKey,
      _todos.map((e) => jsonEncode(e.toJson())).toList(),
    );
    notifyListeners();
  }

  Future<void> updateTodo(int index, TodoModel2 todo) async {
    _todos[index] = todo;
    final prefs = await SharedPreferences.getInstance();
    // Convert to JSON strings properly
    await prefs.setStringList(
      KConstants.todoKey,
      _todos.map((e) => jsonEncode(e.toJson())).toList(),
    );
    notifyListeners();
  }

  Future<void> fetchTodos() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final todoList = prefs.getStringList(KConstants.todoKey) ?? [];
      // Parse JSON strings properly
      _todos = todoList.map((e) => TodoModel2.fromJson(jsonDecode(e))).toList();
      notifyListeners();
    } catch (e) {
      print('Error fetching todos: $e');
      _todos = []; // Reset to empty list on error
      notifyListeners();
    }
  }
}
