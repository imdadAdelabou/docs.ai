import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_clone/screens/login/model.dart';
import 'package:google_clone/utils/app_assets.dart';
import 'package:google_clone/utils/app_text.dart';
import 'package:google_clone/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';

final List<OnBoardingItemModel> _onBoardingItems = <OnBoardingItemModel>[
  OnBoardingItemModel(
    title: 'Collaborative',
    description: AppText.collaborativeDescription,
    icon: AppAssets.collaborativeIllustration,
  ),
];

class _OnBoardingView extends StatelessWidget {
  const _OnBoardingView({
    required this.item,
  });

  final OnBoardingItemModel item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SvgPicture.asset(
          item.icon,
        ),
        Text(
          item.title,
          style: GoogleFonts.lato(
            fontWeight: FontWeight.w700,
            fontSize: 34,
            color: kWhiteColor,
          ),
        ),
        Text(
          item.description,
          style: GoogleFonts.lato(
            fontWeight: FontWeight.w400,
            fontSize: 18,
            color: kWhiteColor,
          ),
        ),
      ],
    );
  }
}

/// The widget to display on large screen for the login screen
class LoginLargeView extends StatelessWidget {
  /// Creates a [LoginLargeView] widget
  const LoginLargeView({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: _onBoardingItems.length,
      itemBuilder: (BuildContext context, int index) => _OnBoardingView(
        item: _onBoardingItems[index],
      ),
    );
  }
}
