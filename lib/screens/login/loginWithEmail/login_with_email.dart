import 'package:docs_ai/screens/login/loginWithEmail/register_with_email.dart';
import 'package:docs_ai/utils/app_text.dart';
import 'package:docs_ai/utils/colors.dart';
import 'package:docs_ai/widgets/custom_btn.dart';
import 'package:docs_ai/widgets/custom_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

/// Contains the visual aspect of the login with email
class LoginWithEmail extends StatelessWidget {
  /// Creates a [LoginWithEmail] widget
  const LoginWithEmail({
    required this.controller,
    required this.animation,
    required this.width,
    super.key,
  });

  /// The animation controller
  final AnimationController controller;

  /// The animation configuration
  final Animation<double> animation;

  /// The width of the widget
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Stack(
        children: <Widget>[
          SlideTransition(
            position:
                Tween<Offset>(begin: Offset.zero, end: const Offset(-1, 0))
                    .animate(controller),
            child: FadeTransition(
              opacity: Tween<double>(begin: 1, end: 0).animate(controller),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    AppText.login,
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.w900,
                      fontSize: 24,
                    ),
                  ),
                  const Gap(20),
                  CustomTextFormField(
                    hintText: 'johndoe@gmail.com',
                    validators: <FieldValidator<dynamic>>[
                      RequiredValidator(errorText: 'This field is required'),
                      EmailValidator(errorText: 'Enter a valid email address'),
                    ],
                  ),
                  const Gap(15),
                  CustomTextFormField(
                    hintText: '********',
                    validators: <FieldValidator<dynamic>>[
                      RequiredValidator(errorText: 'This field is required'),
                    ],
                  ),
                  const Gap(30),
                  CustomBtn(
                    width: width,
                    label: AppText.signIn,
                    onPressed: () {},
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
          ),
          SlideTransition(
            position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
                .animate(controller),
            child: FadeTransition(
              opacity: animation,
              child: RegisterWithEmail(
                width: width,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
