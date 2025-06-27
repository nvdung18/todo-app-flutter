import 'package:flutter/material.dart';

class Utils {
  static String formatDateTime(
    DateTime? selectedDate,
    TimeOfDay? selectedTime,
  ) {
    if (selectedDate == null || selectedTime == null) return '';

    final day = selectedDate.day.toString().padLeft(2, '0');
    final month = selectedDate.month.toString().padLeft(2, '0');
    final year = selectedDate.year.toString();
    final hour = selectedTime.hour.toString().padLeft(2, '0');
    final minute = selectedTime.minute.toString().padLeft(2, '0');

    return '$day/$month/$year - $hour:$minute';
  }
}
