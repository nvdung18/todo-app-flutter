import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/todo_model2.dart';
import 'package:flutter_application_1/providers/todo_provider.dart';
import 'package:flutter_application_1/utils/context_extension.dart';
import 'package:flutter_application_1/views/widgets/taskform_widget.dart';
import 'package:provider/provider.dart';

class EditTaskPage extends StatelessWidget {
  final TodoModel2 task;
  final int taskIndex;

  const EditTaskPage({super.key, required this.task, required this.taskIndex});

  @override
  Widget build(BuildContext context) {
    // Clear SnackBar khi vào trang này
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).clearSnackBars();
    });
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text('Edit Task'),
        actions: [
          IconButton(
            onPressed: () {
              // Delete task functionality
              _showDeleteConfirmation(context);
            },
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Consumer<TodoProvider>(
          builder: (context, todoProvider, child) {
            return TaskFormWidget(
              initialTask: task,
              saveButtonText: 'Update Task',
              onSave: (updatedTask) async {
                try {
                  await todoProvider.updateTodo(taskIndex, updatedTask);
                  if (context.mounted) {
                    // Truyền parameter success=true khi navigate về home
                    context.showSuccessAndNavigate(
                      message: 'Task updated successfully',
                    );
                  }
                } catch (e) {
                  if (context.mounted) {
                    context.showErrorSnackBar('Failed to update task: $e');
                  }
                }
              },
            );
          },
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Task'),
          content: Text('Are you sure you want to delete this task?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final todoProvider = Provider.of<TodoProvider>(
                  context,
                  listen: false,
                );
                todoProvider.removeTodo(taskIndex);
                Navigator.of(context).pop(); // Close dialog
                Navigator.of(context).pop(); // Close edit page
              },
              child: Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
