import 'package:flutter_application_1/models/todo_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class TodoService {
  Future<List<TodoModel>> fetchTodos() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/todos'),
    );
    final List<dynamic> jsonResponse = convert.jsonDecode(response.body);
    return jsonResponse
        .take(4)
        .map((todo) => TodoModel.fromJson(todo as Map<String, dynamic>))
        .toList();
  }
}
