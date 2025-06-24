import 'package:flutter_application_1/models/todo_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class TodoService {
  Future<List<TodoModel>> fetchTodos() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/todos'),
    );
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      // print(jsonResponse);
      return ((jsonResponse as List)
          .map((json) => TodoModel.fromJson(json))
          .toList());
    } else {
      throw Exception('Failed to load todos');
    }
  }
}
