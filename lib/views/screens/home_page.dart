import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/todo_provider.dart';
import 'package:flutter_application_1/views/widgets/dropdown_hide_under_line_widgets.dart';
import 'package:flutter_application_1/views/widgets/todo_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showCompleted = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      final todoProvider = context.read<TodoProvider>();
      await fetchTodos(todoProvider: todoProvider);
    });

    // Preload image để cache
    WidgetsBinding.instance.addPostFrameCallback((_) {
      precacheImage(AssetImage('assets/images/todo.jpg'), context);
    });
  }

  Future<void> fetchTodos({TodoProvider? todoProvider}) async {
    await todoProvider?.fetchTodos();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer<TodoProvider>(
        builder: (context, todoProvider, child) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: (todoProvider.todos.isNotEmpty
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Search',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      DropdownHideUnderLineWidgets(
                        initialValue: showCompleted,
                        onChanged: (value) {
                          setState(() {
                            showCompleted = value;
                          });
                        },
                      ),
                      SizedBox(height: 10),
                      TodoWidget(isCompleted: showCompleted),
                    ],
                  )
                : Column(
                    children: [
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.asset(
                            'assets/images/todo.jpg',
                            width: 250,
                            height: 200,
                            fit: BoxFit.cover,
                            cacheWidth: 500, // Cache với resolution thấp hơn
                            cacheHeight: 400,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'What do you want to do today?',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Tap + to add your tasks',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  )),
          );
        },
      ),
    );
  }
}
