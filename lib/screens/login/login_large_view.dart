import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
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
  OnBoardingItemModel(
    title: AppText.easyToUseTitle,
    description: AppText.easyToUseDescription,
    icon: AppAssets.easyToUseIllustration,
  ),
  OnBoardingItemModel(
    title: AppText.ai,
    description: AppText.aiDescription,
    icon: AppAssets.aiIllustration,
  ),
];

class _OnBoardingView extends StatelessWidget {
  const _OnBoardingView({
    required this.item,
  });

  final OnBoardingItemModel item;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: SvgPicture.asset(
              item.icon,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  item.title,
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.w700,
                    fontSize: 34,
                    color: kWhiteColor,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * .3,
                  child: Text(
                    item.description,
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      color: kWhiteColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// The widget to display on large screen for the login screen
class LoginLargeView extends StatefulWidget {
  /// Creates a [LoginLargeView] widget
  const LoginLargeView({super.key});

  @override
  State<LoginLargeView> createState() => _LoginLargeViewState();
}

class _LoginLargeViewState extends State<LoginLargeView> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: PageView.builder(
            onPageChanged: (int index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemCount: _onBoardingItems.length,
            itemBuilder: (BuildContext context, int index) => _OnBoardingView(
              item: _onBoardingItems[index],
            ),
          ),
        ),
        Center(
          child: OnBoardingTracker(
            currentIndex: _currentIndex,
          ),
        ),
        const Gap(30)
      ],
    );
  }
}

/// The widget to track the slider item between the value of _OnboardingItems
class OnBoardingTracker extends StatelessWidget {
  /// Creates a [OnBoardingTracker] widget
  const OnBoardingTracker({
    required this.currentIndex,
    this.radius = 7,
    super.key,
  });

  /// The radius of the circle
  final double radius;

  /// The current index of the slider
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _onBoardingItems
          .map(
            (elm) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: CircleAvatar(
                radius: radius,
                backgroundColor: currentIndex == _onBoardingItems.indexOf(elm)
                    ? kBlueColorVariant
                    : kWhiteColor,
              ),
            ),
          )
          .toList(),
    );
  }
}
