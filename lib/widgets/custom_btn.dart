import 'package:flutter/material.dart';
import 'package:google_clone/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';

/// Represents a reusable button for all user interface
class CustomBtn extends StatelessWidget {
  /// Creates a [CustomBtn] instance
  const CustomBtn({
    required this.label,
    this.isLoading = false,
    this.onPressed,
    super.key,
  });

  /// Contains the text to display inside the button
  final String label;

  /// Contains the action to run when the button is trigger
  final Function()? onPressed;

  /// Used to show a loading process it the valus is true
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: kBlueColorVariant,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: !isLoading
            ? Text(
                label,
                style: GoogleFonts.lato(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              )
            : SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  backgroundColor: kGreyColor,
                  color: kWhiteColor,
                ),
              ),
      ),
    );
  }
}
