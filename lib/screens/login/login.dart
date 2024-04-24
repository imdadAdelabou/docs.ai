import 'dart:async';

import 'package:docs_ai/screens/login/loginWithEmail/login_with_email.dart';
import 'package:docs_ai/screens/login/login_large_view.dart';
import 'package:docs_ai/screens/login/login_mobile_view.dart';
import 'package:docs_ai/utils/colors.dart';
import 'package:docs_ai/viewModels/login_viewmodel.dart';
import 'package:docs_ai/widgets/signin_with_google_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//ProviderRef is used to communicate with other provider
//WidgetRef is used to communicate with widget
//ref.watch when you are inside the build method
//ref.read when you are outside the build method
//routemaster to manage rooting on web

/// Contains the visual aspect of the login page
class Login extends ConsumerWidget {
  /// Creates a [Login] widget
  const Login({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth > 480) {
            return Row(
              children: <Widget>[
                const Expanded(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: kBlueColor,
                    ),
                    child: LoginLargeView(),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const LoginWithEmail(),
                      SignInWithGoogleBtn(
                        onPressed: () => unawaited(
                          const LoginViewModel().signinWithGoogle(ref, context),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }

          return const LoginMobileView();
        },
      ),
    );
  }
}
