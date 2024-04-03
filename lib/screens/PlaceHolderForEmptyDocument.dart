import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_clone/utils/app_assets.dart';
import 'package:google_clone/utils/app_text.dart';
import 'package:google_fonts/google_fonts.dart';

class PlaceHolderForEmptyDocument extends StatelessWidget {
  const PlaceHolderForEmptyDocument({super.key});

  @override
  Widget build(BuildContext context) {
    final double maxHeight = MediaQuery.sizeOf(context).height;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SvgPicture.asset(
            AppAssets.emptyDocIllustration,
            height: maxHeight * .3,
          ),
          const Gap(10),
          Text(
            AppText.noDocumentYet,
            style: GoogleFonts.lato(
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
