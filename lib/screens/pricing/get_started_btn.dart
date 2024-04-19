import 'package:flutter/material.dart';
import 'package:google_clone/utils/app_text.dart';
import 'package:google_clone/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';

/// A widget to display the get started button
class GetStartedBtn extends StatelessWidget {
  /// Creates a [GetStartedBtn] widget
  const GetStartedBtn({
    required this.onPressed,
    super.key,
  });

  /// The function to execute when the button is clicked
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(
              color: kDescriptionColor,
            ),
          ),
        ),
        child: Text(
          AppText.getStarted,
          style: GoogleFonts.lato(
            fontWeight: FontWeight.w500,
            color: kBlackColor,
          ),
        ),
      ),
    );
  }
}
