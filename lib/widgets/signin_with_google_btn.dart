import 'package:flutter/material.dart';
import 'package:google_clone/utils/app_assets.dart';
import 'package:google_clone/utils/app_text.dart';
import 'package:google_clone/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';

/// A widget to display the button to sign-in with google
class SignInWithGoogleBtn extends StatelessWidget {
  /// Creates a [SignInWithGoogleBtn] widget
  const SignInWithGoogleBtn({
    this.onPressed,
  }) : super(
          key: const Key('sign-in-with-google-btn'),
        );

  /// A function to execute when the button is clicked
  final Function()? onPressed;

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
            5,
          ),
        ),
      ),
    );
  }
}
