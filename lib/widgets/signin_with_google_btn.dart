import 'package:flutter/material.dart';
import 'package:google_clone/utils/app_assets.dart';
import 'package:google_clone/utils/app_text.dart';
import 'package:google_clone/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInWithGoogleBtn extends StatelessWidget {
  final Function()? onPressed;
  const SignInWithGoogleBtn({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Image.asset(
        AppAssets.googleLogo,
        height: 30,
      ),
      label: Text(
        AppText.signInWithGoogle,
        style: GoogleFonts.lato(
          fontWeight: FontWeight.w500,
          color: kWhiteColor,
        ),
      ),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(150, 50),
        backgroundColor: kBlueColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            5.0,
          ),
        ),
      ),
    );
  }
}
