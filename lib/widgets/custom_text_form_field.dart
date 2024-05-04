import 'package:docs_ai/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

/// A custom text form field
class CustomTextFormField extends StatefulWidget {
  /// Creates a [CustomTextFormField] widget
  const CustomTextFormField({
    required this.validators,
    super.key,
    this.hintText,
    this.controller,
    this.keyboardType,
    this.type = TextFormFieldType.text,
  });

  /// The hint text to display
  final String? hintText;

  /// The controller for the text field
  final TextEditingController? controller;

  /// The list of validators to apply to the text field
  final List<FieldValidator<dynamic>> validators;

  /// The type of keyboard to display
  final TextInputType? keyboardType;

  /// The type of the text form field
  final TextFormFieldType type;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.type == TextFormFieldType.password;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        hintText: widget.hintText,
        suffixIcon: widget.type == TextFormFieldType.password
            ? IconButton(
                icon: Icon(
                  !_obscureText ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
      ),
      validator: MultiValidator(widget.validators).call,
      obscureText: _obscureText,
    );
  }
}
