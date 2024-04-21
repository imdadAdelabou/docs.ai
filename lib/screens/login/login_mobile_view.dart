import 'dart:async';
import 'package:docs_ai/screens/login/login_large_view.dart';
import 'package:docs_ai/utils/colors.dart';
import 'package:docs_ai/viewModels/login_viewmodel.dart';
import 'package:docs_ai/widgets/signin_with_google_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Display a screen with a login with google button
class LoginViewWithBtn extends ConsumerWidget {
  /// Creates a [LoginViewWithBtn] widget
  const LoginViewWithBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SignInWithGoogleBtn(
              onPressed: () => unawaited(
                const LoginViewModel().signinWithGoogle(ref, context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///  Contains the login view to display on a Mobile device
class LoginMobileView extends ConsumerWidget {
  /// Creates a [LoginMobileView] widget
  const LoginMobileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const ColoredBox(
      color: kBlueColor,
      child: OnBoardingForMobile(),
    );
  }
}
