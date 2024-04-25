import 'package:docs_ai/utils/app_text.dart';
import 'package:docs_ai/utils/colors.dart';
import 'package:docs_ai/widgets/custom_btn.dart';
import 'package:docs_ai/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

/// Contains the visual aspect of the login with email
class LoginWithEmail extends StatelessWidget {
  /// Creates a [LoginWithEmail] widget
  const LoginWithEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * .2 + 30,
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
    );
  }
}
