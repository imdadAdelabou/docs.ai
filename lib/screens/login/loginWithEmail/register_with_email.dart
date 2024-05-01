import 'package:docs_ai/utils/app_text.dart';
import 'package:docs_ai/utils/colors.dart';
import 'package:docs_ai/widgets/custom_btn.dart';
import 'package:docs_ai/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

/// Contains the visual aspect of the login with email
class RegisterWithEmail extends StatefulWidget {
  /// Creates a [RegisterWithEmail] widget
  const RegisterWithEmail({super.key});

  @override
  State<RegisterWithEmail> createState() => _RegisterWithEmailState();
}

class _RegisterWithEmailState extends State<RegisterWithEmail> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * .2 + 30,
      child: Form(
        key: _key,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              AppText.register,
              style: GoogleFonts.lato(
                fontWeight: FontWeight.w900,
                fontSize: 24,
              ),
            ),
            const Gap(20),
            CustomTextFormField(
              controller: _usernameController,
              hintText: 'johndoe',
              validators: <FieldValidator<dynamic>>[
                RequiredValidator(errorText: 'This field is required'),
              ],
            ),
            const Gap(15),
            CustomTextFormField(
              controller: _emailController,
              hintText: 'johndoe@gmail.com',
              validators: <FieldValidator<dynamic>>[
                RequiredValidator(errorText: 'This field is required'),
                EmailValidator(errorText: 'Enter a valid email address'),
              ],
            ),
            const Gap(15),
            CustomTextFormField(
              controller: _passwordController,
              hintText: '********',
              validators: <FieldValidator<dynamic>>[
                RequiredValidator(errorText: 'This field is required'),
                MinLengthValidator(
                  8,
                  errorText: 'Password must be at least 8 characters long',
                ),
                PatternValidator(
                  r'(?=.*?[#?!@$%^&*-])',
                  errorText:
                      'passwords must have at least one special character',
                ),
              ],
            ),
            const Gap(30),
            CustomBtn(
              width: MediaQuery.sizeOf(context).width * .2 + 30,
              label: AppText.signUp,
              onPressed: () {
                if (_key.currentState!.validate()) {
                  // Do something
                }
              },
            ),
            const Gap(20),
            Center(
              child: Text(
                AppText.or,
                style: GoogleFonts.lato(
                  color: kGreyColorPure,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}
