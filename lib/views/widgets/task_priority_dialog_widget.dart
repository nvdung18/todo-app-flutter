import 'package:flutter/material.dart';

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
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: [
            for (int i = 1; i <= 6; i++)
              SizedBox(
                width: (MediaQuery.of(context).size.width * 0.9 - 36) / 4,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    side: BorderSide(color: Colors.black54),
                    padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
                  ),
                  onPressed: () {},
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
                ),
              ),
          ],
        ),
      ),
    );
  }
}
