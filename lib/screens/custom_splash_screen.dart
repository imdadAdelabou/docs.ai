import 'package:docs_ai/utils/app_assets.dart';
import 'package:flutter/material.dart';

/// A custom splash screen widget
class CustomSplashScreen extends StatelessWidget {
  /// Creates a [CustomSplashScreen] widget
  const CustomSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          AppAssets.googleDocsIcon,
          height: 170,
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }
}
