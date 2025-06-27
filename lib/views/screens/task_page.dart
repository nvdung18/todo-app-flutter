import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/todo_model2.dart';
import 'package:flutter_application_1/providers/todo_provider.dart';
import 'package:flutter_application_1/utils/index.dart';
import 'package:flutter_application_1/views/widgets/edit_task_des_widgets.dart';
import 'package:flutter_application_1/views/widgets/task_priority_dialog_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  String taskTitle = '';
  String taskDescription = '';
  int taskPriority = 1; // Default priority
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.swipe_outlined)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          handleCheckBoxChanged();
                        },
                        icon: Icon(
                          isCompleted
                              ? Icons.check_circle
                              : Icons.circle_outlined,
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
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
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
            ),
            SizedBox(height: 20),
            Row(
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
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
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
                    onPressed: () async {
                      selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      setState(() {
                        selectedDate = selectedDate ?? DateTime.now();
                      });
                      // Implement time picker logic here
                      selectedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      setState(() {
                        selectedTime = selectedTime ?? TimeOfDay.now();
                      });
                    },
                    child: selectedDate != null && selectedTime != null
                        ? Text(
                            Utils.formatDateTime(selectedDate, selectedTime),
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 16,
                            ),
                          )
                        : Icon(
                            Icons.calendar_month_outlined,
                            color: Colors.blueAccent,
                          ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.flag_outlined),
                    ),
                    Text(
                      'Task Priority:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
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
                    onPressed: () {
                      _navigateToTaskPriorityDialog(context);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          taskPriority.toString(),
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.flag_outlined,
                          size: 16,
                          color: Colors.blueAccent,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            Consumer<TodoProvider>(
              builder: (context, todoProvider, child) {
                return ElevatedButton(
                  onPressed: () {
                    addTask(todoProvider);
                    context.go('/home'); // Navigate to the todo page
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                    minimumSize: Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // Bo tròn nhẹ
                    ),
                  ),
                  child: Text(
                    'Add Task',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
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
      // Thêm setState để cập nhật UI
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

  Future<bool> addTask(TodoProvider todoProvider) async {
    TodoModel2 newTask = TodoModel2(
      title: taskTitle,
      description: taskDescription,
      priority: taskPriority,
      date: selectedDate ?? DateTime.now(),
      timeOfDay: selectedTime ?? TimeOfDay.now(),
      isCompleted: isCompleted,
    );
    return todoProvider.addTodo(newTask);
  }
}
