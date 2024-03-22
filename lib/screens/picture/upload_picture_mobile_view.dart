import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_clone/utils/app_text.dart';
import 'package:google_clone/utils/colors.dart';
import 'package:google_clone/widgets/custom_btn.dart';
import 'package:google_fonts/google_fonts.dart';

/// The widgets that contains the layout to display on mobile device
class UploadPictureMobileView extends ConsumerStatefulWidget {
  /// Creates a [UploadPictureMobileView] instance
  const UploadPictureMobileView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UploadPictureMobileViewState();
}

class _UploadPictureMobileViewState
    extends ConsumerState<UploadPictureMobileView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          const Gap(30),
          Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              const CircleAvatar(
                radius: 70,
              ),
              Positioned(
                bottom: -18,
                left: 43,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.add,
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith(
                      (_) => kWhiteColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Gap(40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              AppText.descriptionOnUploadPicture,
              style: GoogleFonts.lato(
                fontSize: 16,
                color: kGreyColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomBtn(
              label: AppText.upload,
              onPressed: () {},
            ),
          ),
          const Gap(20),
        ],
      ),
    );
  }
}
