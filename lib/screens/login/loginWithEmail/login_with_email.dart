import 'package:docs_ai/screens/login/loginWithEmail/register_with_email.dart';
import 'package:docs_ai/utils/app_text.dart';
import 'package:docs_ai/utils/colors.dart';
import 'package:docs_ai/widgets/custom_btn.dart';
import 'package:docs_ai/widgets/custom_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

/// Contains the visual aspect of the login with email
class LoginWithEmail extends StatelessWidget {
  /// Creates a [LoginWithEmail] widget
  const LoginWithEmail({
    required this.controller,
    required this.animation,
    super.key,
  });

  /// The animation controller
  final AnimationController controller;

  /// The animation configuration
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * .2 + 30,
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
                  const CustomTextFormField(
                    hintText: 'johndoe@gmail.com',
                  ),
                  const Gap(15),
                  const CustomTextFormField(
                    hintText: '********',
                  ),
                  const Gap(30),
                  CustomBtn(
                    width: MediaQuery.sizeOf(context).width * .2 + 30,
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
              child: const RegisterWithEmail(),
            ),
          ),
        ],
      ),
    );
  }
}