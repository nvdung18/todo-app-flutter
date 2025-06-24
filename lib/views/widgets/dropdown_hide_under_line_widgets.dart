import 'package:flutter/material.dart';

class DropdownHideUnderLineWidgets extends StatelessWidget {
  const DropdownHideUnderLineWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.teal, // Màu nền cho ô dropdown
        borderRadius: BorderRadius.circular(10.0), // Bo tròn góc
        border: Border.all(color: Colors.teal),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ), // Bo tròn popup
          dropdownColor: Colors.teal, // Màu popup
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
