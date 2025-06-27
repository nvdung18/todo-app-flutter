import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/todo_model2.dart';
import 'package:flutter_application_1/utils/index.dart';
import 'package:flutter_application_1/views/widgets/edit_task_des_widgets.dart';
import 'package:flutter_application_1/views/widgets/task_priority_dialog_widget.dart';

class TaskFormWidget extends StatefulWidget {
  final TodoModel2? initialTask; // null cho add, có giá trị cho edit
  final Function(TodoModel2) onSave;
  final String saveButtonText;

  const TaskFormWidget({
    super.key,
    this.initialTask,
    required this.onSave,
    this.saveButtonText = 'Save Task',
  });

  @override
  State<TaskFormWidget> createState() => _TaskFormWidgetState();
}

class _TaskFormWidgetState extends State<TaskFormWidget> {
  late String taskTitle;
  late String taskDescription;
  late int taskPriority;
  late DateTime selectedDate;
  late TimeOfDay selectedTime;
  late bool isCompleted;

  @override
  void initState() {
    super.initState();
    // Initialize values từ initialTask hoặc default values
    if (widget.initialTask != null) {
      taskTitle = widget.initialTask!.title;
      taskDescription = widget.initialTask!.description;
      taskPriority = widget.initialTask!.priority;
      selectedDate = widget.initialTask!.date;
      selectedTime = widget.initialTask!.timeOfDay;
      isCompleted = widget.initialTask!.isCompleted;
    } else {
      taskTitle = '';
      taskDescription = '';
      taskPriority = 1;
      selectedDate = DateTime.now();
      selectedTime = TimeOfDay.now();
      isCompleted = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        _buildTaskInfoRow(),
        SizedBox(height: 20),
        _buildTaskTimeRow(),
        SizedBox(height: 20),
        _buildTaskPriorityRow(),
        Spacer(),
        _buildSaveButton(),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildTaskInfoRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              IconButton(
                onPressed: handleCheckBoxChanged,
                icon: Icon(
                  isCompleted ? Icons.check_circle : Icons.circle_outlined,
                  color: isCompleted ? Colors.green : Colors.grey,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      taskTitle.isEmpty ? 'Do something' : taskTitle,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      taskDescription.isEmpty
                          ? 'Description of the task goes here'
                          : taskDescription,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        IconButton(
          icon: Icon(Icons.edit_outlined),
          onPressed: () => _navigateToEditTaskDescription(context),
        ),
      ],
    );
  }

  Widget _buildTaskTimeRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.punch_clock_outlined),
            ),
            Text(
              'Task Time:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent),
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.blueAccent.withOpacity(0.1),
          ),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          child: TextButton(
            style: TextButton.styleFrom(padding: EdgeInsets.zero),
            onPressed: _showDateTimePicker,
            child: Text(
              Utils.formatDateTime(selectedDate, selectedTime),
              style: TextStyle(color: Colors.blueAccent, fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTaskPriorityRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(onPressed: () {}, icon: Icon(Icons.flag_outlined)),
            Text(
              'Task Priority:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent),
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.blueAccent.withOpacity(0.1),
          ),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          child: TextButton(
            style: TextButton.styleFrom(padding: EdgeInsets.zero),
            onPressed: () => _navigateToTaskPriorityDialog(context),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  taskPriority.toString(),
                  style: TextStyle(color: Colors.blueAccent, fontSize: 16),
                ),
                SizedBox(width: 4),
                Icon(Icons.flag_outlined, size: 16, color: Colors.blueAccent),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: _handleSave,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueGrey,
        minimumSize: Size(double.infinity, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(
        widget.saveButtonText,
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }

  void _handleSave() {
    final task = TodoModel2(
      title: taskTitle,
      description: taskDescription,
      priority: taskPriority,
      date: selectedDate,
      timeOfDay: selectedTime,
      isCompleted: isCompleted,
    );
    widget.onSave(task);
  }

  Future<void> _showDateTimePicker() async {
    final date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (date != null) {
      final time = await showTimePicker(
        context: context,
        initialTime: selectedTime,
      );

      if (time != null) {
        setState(() {
          selectedDate = date;
          selectedTime = time;
        });
      }
    }
  }

  Future<void> _navigateToEditTaskDescription(BuildContext context) async {
    final result = await showDialog(
      barrierDismissible: false,
      useSafeArea: true,
      context: context,
      builder: (context) {
        return EditTaskDescriptionWidgets(
          taskTitle: taskTitle,
          taskDescription: taskDescription,
        );
      },
    );

    if (!context.mounted) return;
    if (result == 'You pressed Cancel') {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text('$result')));
      return;
    }
    setState(() {
      taskTitle = result['title'] ?? taskTitle;
      taskDescription = result['description'] ?? taskDescription;
    });
  }

  Future<void> _navigateToTaskPriorityDialog(BuildContext context) async {
    final result = await showDialog(
      barrierDismissible: false,
      useSafeArea: true,
      context: context,
      builder: (context) {
        return TaskPriorityDialogWidget();
      },
    );

    if (!context.mounted) return;
    if (result == 'You pressed Cancel') {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text('$result')));
      return;
    } else {
      setState(() {
        taskPriority = result;
      });
    }
  }

  void handleCheckBoxChanged() {
    setState(() {
      isCompleted = !isCompleted;
    });
  }
}
