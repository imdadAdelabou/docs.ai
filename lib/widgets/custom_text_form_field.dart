import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

/// A custom text form field
class CustomTextFormField extends StatelessWidget {
  /// Creates a [CustomTextFormField] widget
  const CustomTextFormField({
    required this.validators,
    super.key,
    this.hintText,
    this.controller,
  });

  /// The hint text to display
  final String? hintText;

  /// The controller for the text field
  final TextEditingController? controller;

  /// The list of validators to apply to the text field
  final List<FieldValidator<dynamic>> validators;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        hintText: hintText,
      ),
      validator: MultiValidator(validators).call,
    );
  }
}
