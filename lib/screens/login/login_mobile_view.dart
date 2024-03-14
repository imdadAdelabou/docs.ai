import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_clone/viewmodels/login_viewmodel.dart';
import 'package:google_clone/widgets/signin_with_google_btn.dart';

class LoginMobileView extends ConsumerWidget {
  const LoginMobileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: SignInWithGoogleBtn(
            onPressed: () => LoginViewModel().signinWithGoogle(
              ref,
              context,
            ),
          ),
        ),
      ],
    );
  }
}
