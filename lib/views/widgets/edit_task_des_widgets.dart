import 'package:flutter/material.dart';

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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: taskTitleController,
              decoration: InputDecoration(
                labelText: 'Task Title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              maxLines: 2,
              controller: taskDescriptionController,
              decoration: InputDecoration(
                labelText: 'Task Description',
                border: OutlineInputBorder(),
              ),
            ),
          ],
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
            // Save the task with title and description
            Navigator.pop(context, {
              'title': title,
              'description': description,
            });
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}
