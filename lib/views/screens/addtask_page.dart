import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/todo_provider.dart';
import 'package:flutter_application_1/utils/context_extension.dart';
import 'package:flutter_application_1/views/widgets/taskform_widget.dart';
import 'package:provider/provider.dart';

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({super.key});

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
        title: Text('Add Task'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.swipe_outlined)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Consumer<TodoProvider>(
          builder: (context, todoProvider, child) {
            return TaskFormWidget(
              saveButtonText: 'Add Task',
              onSave: (task) async {
                try {
                  await todoProvider.addTodo(task);
                  if (context.mounted) {
                    // Navigate về home trước
                    context.showSuccessAndNavigate(
                      message: 'Task added successfully',
                    );
                  }
                } catch (e) {
                  if (context.mounted) {
                    context.showErrorSnackBar('Failed to add task: $e');
                  }
                }
              },
            );
          },
        ),
      ),
    );
  }
}
