import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/widgets/text_field_widget.dart';

class EditTaskDescriptionWidgets extends StatelessWidget {
  const EditTaskDescriptionWidgets({
    super.key,
    this.taskTitle = '',
    this.taskDescription = '',
  });

  final String? taskTitle;
  final String? taskDescription;

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController taskTitleController = TextEditingController(
      text: taskTitle ?? '', // Set giá trị ban đầu từ parameter
    );
    final TextEditingController taskDescriptionController =
        TextEditingController(
          text: taskDescription ?? '', // Set giá trị ban đầu từ parameter
        );
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      insetPadding: EdgeInsets.zero,
      title: Text('Add task'),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(
                label: 'Task Title',
                controller: taskTitleController,
                border: OutlineInputBorder(),
                validator: (p0) {
                  if (p0 == null || p0.isEmpty) {
                    return 'Please enter a task title';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              CustomTextField(
                label: 'Task Description',
                controller: taskDescriptionController,
                border: OutlineInputBorder(),
                builder: (textField) => TextFormField(
                  controller: textField.controller,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'Task Description',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 2,
                  validator: (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return 'Please enter a task description';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'You pressed Cancel');
          },
          child: Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            // Here you can handle the save action, e.g., save the task
            String title = taskTitleController.text;
            String description = taskDescriptionController.text;
            if (_formKey.currentState?.validate() ?? false) {
              // Save the task with title and description
              Navigator.pop(context, {
                'title': title,
                'description': description,
              });
            }
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}
