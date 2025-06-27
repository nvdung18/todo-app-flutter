import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension ContextExtensions on BuildContext {
  Future<void> showSuccessAndNavigate({
    required String message,
    String route = '/home',
    int delayMs = 300,
  }) async {
    if (!mounted) return;

    // Navigate trước
    go(route);

    // Hiển thị message sau khi navigate xong
    Future.delayed(Duration(milliseconds: delayMs), () {
      if (mounted) {
        ScaffoldMessenger.of(this).clearSnackBars();

        ScaffoldMessenger.of(this).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 8),
                Expanded(child: Text(message)),
              ],
            ),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
    });
  }

  void showErrorSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(this).clearSnackBars();
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
