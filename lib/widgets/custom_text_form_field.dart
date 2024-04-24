import 'package:flutter/material.dart';

/// A custom text form field
class CustomTextFormField extends StatelessWidget {
  /// Creates a [CustomTextFormField] widget
  const CustomTextFormField({
    super.key,
    this.hintText,
  });

  /// The hint text to display
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        hintText: hintText,
      ),
    );
  }
}
