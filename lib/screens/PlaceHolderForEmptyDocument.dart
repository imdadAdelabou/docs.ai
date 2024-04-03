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
    final double maxWidth = MediaQuery.sizeOf(context).width;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SvgPicture.asset(
            AppAssets.emptyDocIllustration,
            height: MediaQuery.sizeOf(context).width > 480
                ? maxHeight * .3
                : maxHeight * .2,
          ),
          const Gap(10),
          Text(
            AppText.noDocumentYet,
            style: GoogleFonts.lato(
              fontSize: MediaQuery.sizeOf(context).width > 480 ? 24 : 16,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
