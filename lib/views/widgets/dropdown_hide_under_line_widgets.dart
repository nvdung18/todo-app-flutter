import 'package:flutter/material.dart';

class DropdownHideUnderLineWidgets extends StatefulWidget {
  final Function(bool) onChanged;
  final bool initialValue;

  const DropdownHideUnderLineWidgets({
    super.key,
    required this.onChanged,
    this.initialValue = false,
  });

  @override
  State<DropdownHideUnderLineWidgets> createState() =>
      _DropdownHideUnderLineWidgetsState();
}

class _DropdownHideUnderLineWidgetsState
    extends State<DropdownHideUnderLineWidgets> {
  late bool isCompleted;

  @override
  void initState() {
    super.initState();
    isCompleted = widget.initialValue;
  }

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
        child: DropdownButton<bool>(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ), // Bo tròn popup
          dropdownColor: Colors.teal, // Màu popup
          value: isCompleted,
          items: const [
            DropdownMenuItem<bool>(
              value: false,
              child: Text(
                'Not Completed',
                style: TextStyle(color: Colors.white),
              ),
            ),
            DropdownMenuItem<bool>(
              value: true,
              child: Text('Completed', style: TextStyle(color: Colors.white)),
            ),
          ],
          onChanged: (value) {
            if (value != null) {
              setState(() {
                isCompleted = value;
              });
              widget.onChanged(value); // Gọi callback để parent widget biết
            }
          },
          icon: Icon(Icons.arrow_drop_down, color: Colors.white),
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
