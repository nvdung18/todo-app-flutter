import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/todo_provider.dart';
import 'package:provider/provider.dart';

class TodoWidget extends StatelessWidget {
  const TodoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoProvider>(
      builder: (context, todoProvider, child) {
        return Column(
          children: [
            for (int i = 0; i < todoProvider.todos.length; i++)
              Card(
                margin: EdgeInsets.only(bottom: 15),
                child: ListTile(
                  contentPadding: EdgeInsets.only(left: 0, right: 16),
                  title: Text(todoProvider.todos[i].title),
                  // subtitle: Text(todoProvider.todos[i].description),
                  subtitle: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.orange.withOpacity(0.1),
                          border: Border.all(color: Colors.orange),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.schedule,
                              size: 14,
                              color: Colors.orange,
                            ),
                            SizedBox(width: 4),
                            Text(
                              _formatDate(todoProvider.todos[i].date),
                              style: TextStyle(
                                color: Colors.orange,
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(width: 4),
                            Text(
                              _formatTime(todoProvider.todos[i].timeOfDay),
                              style: TextStyle(
                                color: Colors.orange,
                                fontSize: 9,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  visualDensity: VisualDensity(horizontal: -4),
                  leading: Checkbox(
                    value: todoProvider.todos[i].isCompleted,
                    onChanged: (value) {
                      print('Checkbox changed: $value');
                    },
                  ),

                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(width: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(2.0),
                        child: Container(
                          width: 50,
                          height: 25,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueAccent),
                            color: Colors.blueAccent.withOpacity(0.1),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.flag_outlined,
                                  size: 16,
                                  color: Colors.blueAccent,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  todoProvider.todos[i].priority.toString(),
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  String _formatTime(TimeOfDay timeOfDay) {
    final hour = timeOfDay.hour.toString().padLeft(2, '0');
    final minute = timeOfDay.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
