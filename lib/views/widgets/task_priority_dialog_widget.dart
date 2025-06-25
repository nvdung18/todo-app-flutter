import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class TaskPriorityDialogWidget extends StatelessWidget {
  const TaskPriorityDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.center,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      title: const Text('Select Task Priority'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'You pressed Cancel');
          },
          child: Text('Cancel'),
        ),
      ],
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          shrinkWrap: true,
          children: [
            for (int i = 1; i <= 6; i++)
              Consumer<ThemeProvider>(
                builder: (context, themeProvider, child) {
                  return OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      backgroundColor: Colors.blueAccent.withOpacity(0.1),
                      side: BorderSide(
                        color: themeProvider.isDarkMode
                            ? Colors.white
                            : Colors.black54,
                      ),
                      padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
                    ),
                    onPressed: () {
                      Navigator.pop(context, i); // Return the selected priority
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.flag_outlined, color: Colors.blueAccent),
                        Text(
                          '$i',
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
