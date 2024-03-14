import 'package:flutter/material.dart';
import 'package:google_clone/utils/app_text.dart';
import 'package:google_clone/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';

/// Contains the button used to share access to a document
class ShareBtn extends StatelessWidget {
  /// Creates a [ShareBtn] widget
  const ShareBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(
        Icons.lock,
        color: kWhiteColor,
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: kBlueColorVariant,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        minimumSize: const Size(150, 50),
      ),
      onPressed: () {},
      label: Text(
        AppText.shareLabel,
        style: GoogleFonts.lato(
          fontWeight: FontWeight.w600,
          color: kWhiteColor,
        ),
      ),
    );
  }
}
