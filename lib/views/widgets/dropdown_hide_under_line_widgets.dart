import 'package:flutter/material.dart';

class DropdownHideUnderLineWidgets extends StatelessWidget {
  const DropdownHideUnderLineWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(
          255,
          207,
          207,
          207,
        ), // Màu nền cho ô dropdown
        borderRadius: BorderRadius.circular(10.0), // Bo tròn góc
        border: Border.all(color: Colors.grey.shade400),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ), // Bo tròn popup
          dropdownColor: const Color.fromARGB(255, 207, 207, 207), // Màu popup
          value: 'option1',
          items: const [
            DropdownMenuItem(child: Text('Today'), value: 'option1'),
            DropdownMenuItem(child: Text('Completed'), value: 'option2'),
          ],
          onChanged: (value) {
            // Handle dropdown value change
          },
        ),
      ),
    );
  }
}
