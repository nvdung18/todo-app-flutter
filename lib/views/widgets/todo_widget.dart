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
                  title: Text('Todo Item ${todoProvider.todos[i].title}'),
                  subtitle: Text('Today At 18:20'),
                  visualDensity: VisualDensity(horizontal: -4),
                  // leading: IconButton(
                  //   icon: Icon(Icons.circle_outlined),
                  //   visualDensity: VisualDensity(horizontal: 1),
                  //   padding: EdgeInsets.only(left: 4),
                  //   onPressed: () {
                  //     // Handle completion
                  //   }
                  leading: Checkbox(
                    value: todoProvider.todos[i].isCompleted,
                    onChanged: (value) {
                      // Handle checkbox change
                    },
                  ),
                  trailing: ClipRRect(
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
                          children: [
                            Icon(
                              Icons.flag_outlined,
                              size: 16,
                              color: Colors.blueAccent,
                            ),
                            SizedBox(width: 4),
                            Text(
                              '1',
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
                ),
              ),
          ],
        );
      },
    );
  }
}
