import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/widgets/todo_widget.dart';

List<String> daysOfWeek = ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'];
List<String> monthsOfYear = [
  'JANUARY',
  'FEBRUARY',
  'MARCH',
  'APRIL',
  'MAY',
  'JUNE',
  'JULY',
  'AUGUST',
  'SEPTEMBER',
  'OCTOBER',
  'NOVEMBER',
  'DECEMBER',
];

class CalenderPage extends StatefulWidget {
  const CalenderPage({super.key});

  @override
  State<CalenderPage> createState() => _CalenderPageState();
}

class _CalenderPageState extends State<CalenderPage> {
  int selectedDayIndex = 0;
  DateTime selectedDate = DateTime.now();
  List<DateTime> weekDates = [];
  bool isCompleted = false;
  List<DateTime> daysWithTodo = [];
  @override
  void initState() {
    super.initState();
    _updateWeekDates(selectedDate);
    // Đặt selectedDayIndex đúng vị trí trong tuần (chủ nhật là 0, thứ hai là 1, ...)
    selectedDayIndex = selectedDate.weekday % 7;
  }

  void _updateWeekDates(DateTime date) {
    int daysFromSunday = date.weekday % 7;
    DateTime startOfWeek = date.subtract(Duration(days: daysFromSunday));
    weekDates = List.generate(
      7,
      (index) => startOfWeek.add(Duration(days: index)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 10),
      alignment: Alignment.topCenter,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.zero,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 213, 213, 213),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          // Handle back navigation
                          setState(() {
                            // Giả sử bạn muốn quay lại ngày trước đó
                            selectedDate = selectedDate.subtract(
                              Duration(days: 7),
                            );
                            _updateWeekDates(selectedDate);
                            selectedDayIndex = selectedDate.weekday - 1;
                          });
                        },
                      ),
                      TextButton(
                        onPressed: () async {
                          // Handle month change logic here
                          final date = await showDatePicker(
                            context: context,
                            initialDate: selectedDate,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );

                          if (date != null && date != selectedDate) {
                            setState(() {
                              selectedDate = date;
                              _updateWeekDates(selectedDate);
                              selectedDayIndex = selectedDate.weekday - 1;
                            });
                          }
                        },
                        child: Text(
                          '${monthsOfYear[selectedDate.month - 1]} ${selectedDate.year}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.arrow_forward),
                        onPressed: () {
                          // Handle forward navigation
                          setState(() {
                            // Giả sử bạn muốn quay lại ngày trước đó
                            selectedDate = selectedDate.add(Duration(days: 7));
                            _updateWeekDates(selectedDate);
                            selectedDayIndex = selectedDate.weekday - 1;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: weekDates.asMap().entries.map((entry) {
                      final idx = entry.key;
                      final date = entry.value;
                      final isSelected =
                          date.day == selectedDate.day &&
                          date.month == selectedDate.month &&
                          date.year == selectedDate.year;
                      final isWeekend =
                          idx == 0 || idx == 6; // Chủ nhật hoặc thứ 7

                      double screenWidth = MediaQuery.of(context).size.width;
                      double horizontalPadding = 20;
                      double cardWidth = (screenWidth - horizontalPadding) / 7;

                      // Kiểm tra ngày này có todo không
                      final hasTodo = daysWithTodo.any(
                        (d) =>
                            d.year == date.year &&
                            d.month == date.month &&
                            d.day == date.day,
                      );
                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectedDate = date;
                            selectedDayIndex = idx;
                          });
                        },
                        child: SizedBox(
                          width: cardWidth,
                          child: Card(
                            color: isSelected ? Colors.cyan : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Column(
                                children: [
                                  Text(
                                    daysOfWeek[idx],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : isWeekend
                                          ? Colors.red
                                          : Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Center(
                                    child: Text(
                                      date.day.toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                  // Hiển thị dấu chấm nếu có todo
                                  if (hasTodo)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 2.0),
                                      child: Container(
                                        width: 6,
                                        height: 6,
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.cyan,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  // Calendar dates
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Card(
                      // shape: RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.circular(10.0),
                      // ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              flex: 1,
                              child: OutlinedButton(
                                onPressed: () {
                                  setState(() {
                                    isCompleted = !isCompleted;
                                  });
                                },
                                style: ButtonStyle(
                                  backgroundColor: !isCompleted
                                      ? MaterialStateProperty.all(Colors.blue)
                                      : MaterialStateProperty.all(
                                          const Color.fromARGB(
                                            255,
                                            204,
                                            204,
                                            204,
                                          ),
                                        ),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'Not completed',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: !isCompleted
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color: !isCompleted
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              flex: 1,
                              child: OutlinedButton(
                                onPressed: () {
                                  setState(() {
                                    isCompleted = !isCompleted;
                                  });
                                },
                                style: ButtonStyle(
                                  backgroundColor: isCompleted
                                      ? MaterialStateProperty.all(Colors.blue)
                                      : MaterialStateProperty.all(
                                          const Color.fromARGB(
                                            255,
                                            204,
                                            204,
                                            204,
                                          ),
                                        ),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'Completed',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: isCompleted
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color: isCompleted
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    TodoWidget(
                      isCompleted: isCompleted,
                      filteredTodosByDate: selectedDate,
                      onDaysWithTodo: (days) {
                        setState(() {
                          daysWithTodo = days;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
