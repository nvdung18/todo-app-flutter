import 'package:flutter/material.dart';

// typedef TextFieldCustomizer = TextFormField Function(TextFormField textField);
class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool obscureText;
  final String? Function(String?)? validator;

  final InputBorder? border;

  final Widget Function(TextFormField)? builder;

  const CustomTextField({
    super.key,
    required this.label,
    this.border,
    this.builder,
    // final TextFieldCustomizer? customizer;
    required this.controller,
    this.obscureText = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final textField = TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        border: border ?? InputBorder.none,
      ),
      validator: validator,
    );

    //  return customizer?.call(textField) ?? textField;
    return builder?.call(textField) ?? textField;
    // return TextFormField(
    //   controller: controller,
    //   obscureText: obscureText,
    //   decoration: InputDecoration(
    //     labelText: label,
    //     border: border ?? InputBorder.none,
    //   ),
    //   validator: validator,
    // );
  }
}
