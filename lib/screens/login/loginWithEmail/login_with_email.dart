import 'package:docs_ai/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

/// Contains the visual aspect of the login with email
class LoginWithEmail extends StatelessWidget {
  /// Creates a [LoginWithEmail] widget
  const LoginWithEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          width: MediaQuery.sizeOf(context).width * .2 + 30,
          child: const CustomTextFormField(
            hintText: 'johndoe@gmail.com',
          ),
        ),
        const Gap(10),
        SizedBox(
          width: MediaQuery.sizeOf(context).width * .2 + 30,
          child: const CustomTextFormField(
            hintText: '********',
          ),
        ),
      ],
    );
  }
}
