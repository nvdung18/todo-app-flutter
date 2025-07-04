import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/error_provider.dart';

class GlobalErrorListener extends StatelessWidget {
  final Widget? child;

  const GlobalErrorListener({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: GlobalErrorHandler.instance,
      builder: (context, _) {
        final error = GlobalErrorHandler.instance.error;
        if (error != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Error: $error')));
            GlobalErrorHandler.instance.clear();
          });
        } else {
          if (kReleaseMode) exit(1);
          Widget errorA = const Text('...rendering error...');
          if (child is Scaffold || child is Navigator) {
            errorA = Scaffold(body: Center(child: errorA));
          }
          ErrorWidget.builder = (errorDetails) => errorA;
        }
        // return child;
        if (child != null) return child!;
        throw StateError('widget is null');
      },
    );
  }
}
