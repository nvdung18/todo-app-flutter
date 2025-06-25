import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/todo_provider.dart';
import 'package:flutter_application_1/views/screens/setting_page.dart';
import 'package:flutter_application_1/views/screens/task_page.dart';
import 'package:flutter_application_1/views/styles/app_color.dart';
import 'package:flutter_application_1/views/widgets/dropdown_hide_under_line_widgets.dart';
import 'package:flutter_application_1/views/widgets/navbar_widget.dart';
import 'package:flutter_application_1/views/widgets/todo_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   if (!mounted) return;
    //   final todoProvider = context.read<TodoProvider>();
    //   await test(todoProvider: todoProvider);
    // });

    // Preload image để cache
    WidgetsBinding.instance.addPostFrameCallback((_) {
      precacheImage(AssetImage('assets/images/todo.jpg'), context);
    });
  }

  Future<void> test({TodoProvider? todoProvider}) async {
    await todoProvider?.fetchTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
            onPressed: () {
              context.pushNamed('setting');
            },
            icon: Icon(Icons.settings),
          ),
        ],
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            // Navigate to filter page
          },
          icon: Icon(Icons.filter_list),
        ),
      ),
      body: SingleChildScrollView(
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
                        DropdownHideUnderLineWidgets(),
                        SizedBox(height: 10),
                        TodoWidget(),
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
      ),
      bottomNavigationBar: NavBarWidget(),
      floatingActionButton: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.secondary,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: IconButton(
          onPressed: () {
            context.pushNamed('add-task');
          },
          icon: Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
