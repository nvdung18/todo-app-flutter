import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_application_1/providers/todo_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class TodoWidget extends StatelessWidget {
  const TodoWidget({
    super.key,
    this.isCompleted = false,
    this.filteredTodosByDate,
    this.onDaysWithTodo,
  });

  final bool isCompleted;
  final DateTime? filteredTodosByDate;
  final void Function(List<DateTime>)? onDaysWithTodo;
  @override
  Widget build(BuildContext context) {
    return Consumer<TodoProvider>(
      builder: (context, todoProvider, child) {
        // Lọc ra các task dựa trên isCompleted parameter
        final filteredTodos = todoProvider.todos
            .asMap()
            .entries
            .where((entry) => entry.value.isCompleted == isCompleted)
            .where(
              (entry) =>
                  filteredTodosByDate == null ||
                  (entry.value.date.year == filteredTodosByDate!.year &&
                      entry.value.date.month == filteredTodosByDate!.month &&
                      entry.value.date.day == filteredTodosByDate!.day),
            )
            .toList();

        final daysWithTodo = todoProvider.todos
            .map(
              (todo) =>
                  DateTime(todo.date.year, todo.date.month, todo.date.day),
            )
            .toSet()
            .toList();
        if (onDaysWithTodo != null) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            onDaysWithTodo!(daysWithTodo);
          });
        }

        // if (filteredTodos.isEmpty) {
        //   return Center(
        //     child: Text(
        //       isCompleted ? 'No completed tasks yet' : 'No pending tasks',
        //       style: TextStyle(color: Colors.grey, fontSize: 16),
        //     ),
        //   );
        // }

        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: filteredTodos.length,
          itemBuilder: (context, i) {
            final entry = filteredTodos[i];
            final originalIndex = entry.key;
            final todo = entry.value;

            return _TodoItem(
              key: ValueKey(todo.hashCode),
              todo: todo,
              originalIndex: originalIndex,
              todoProvider: todoProvider,
            );
          },
        );
      },
    );
  }
}

class _TodoItem extends StatefulWidget {
  final todo;
  final int originalIndex;
  final TodoProvider todoProvider;

  const _TodoItem({
    super.key,
    required this.todo,
    required this.originalIndex,
    required this.todoProvider,
  });

  @override
  State<_TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<_TodoItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _sizeAnimation;
  bool _isCompleting = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.3, 1.0, curve: Curves.easeOut),
      ),
    );
    _sizeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.5, 1.0, curve: Curves.easeOut),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleCheckboxChanged(bool? value) async {
    if (value == true && !widget.todo.isCompleted) {
      setState(() {
        _isCompleting = true;
      });

      await Future.delayed(Duration(milliseconds: 300));
      await _animationController.forward();

      if (mounted) {
        final realIndex = widget.todoProvider.todos.indexWhere(
          (todo) =>
              todo.title == widget.todo.title &&
              todo.date == widget.todo.date &&
              todo.timeOfDay == widget.todo.timeOfDay,
        );

        if (realIndex != -1) {
          final updatedTodo = widget.todo.copyWith(isCompleted: true);
          widget.todoProvider.updateTodo(realIndex, updatedTodo);
        }
      }
    } else if (value == false && widget.todo.isCompleted) {
      setState(() {
        _isCompleting = true;
      });

      // Reset animation về trạng thái ban đầu
      // _animationController.reset();

      // await Future.delayed(Duration(milliseconds: 200));
      await Future.delayed(Duration(milliseconds: 300));
      await _animationController.forward();

      if (mounted) {
        final realIndex = widget.todoProvider.todos.indexWhere(
          (todo) =>
              todo.title == widget.todo.title &&
              todo.date == widget.todo.date &&
              todo.timeOfDay == widget.todo.timeOfDay,
        );

        if (realIndex != -1) {
          final updatedTodo = widget.todo.copyWith(isCompleted: false);
          widget.todoProvider.updateTodo(realIndex, updatedTodo);
        }

        setState(() {
          _isCompleting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: SizeTransition(
            sizeFactor: _sizeAnimation,
            child: _buildListTile(),
          ),
        );
      },
    );
  }

  Widget _buildListTile() {
    return Card(
      margin: EdgeInsets.only(bottom: 15),
      child: InkWell(
        onTap: () {
          context.pushNamed(
            'edit-task',
            pathParameters: {'id': widget.originalIndex.toString()},
            extra: widget.todo,
          );
        },
        child: ListTile(
          contentPadding: EdgeInsets.only(left: 0, right: 16),
          title: Text(
            widget.todo.title,
            style: TextStyle(
              decoration: (_isCompleting || widget.todo.isCompleted)
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
              color: (_isCompleting || widget.todo.isCompleted)
                  ? Colors.grey
                  : Colors.black,
            ),
          ),
          subtitle: Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  border: Border.all(color: Colors.orange),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.schedule, size: 14, color: Colors.orange),
                    SizedBox(width: 4),
                    Text(
                      _formatDate(widget.todo.date),
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 4),
                    Text(
                      _formatTime(widget.todo.timeOfDay),
                      style: TextStyle(color: Colors.orange, fontSize: 9),
                    ),
                  ],
                ),
              ),
            ],
          ),
          visualDensity: VisualDensity(horizontal: -4),
          leading: Checkbox(
            value: _isCompleting || widget.todo.isCompleted,
            onChanged: _isCompleting ? null : _handleCheckboxChanged,
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
                          widget.todo.priority.toString(),
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
    );
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day/$month/${date.year}';
  }

  String _formatTime(TimeOfDay timeOfDay) {
    final hour = timeOfDay.hour.toString().padLeft(2, '0');
    final minute = timeOfDay.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
