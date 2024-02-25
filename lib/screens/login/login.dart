import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_clone/screens/login/login_mobile_view.dart';
import 'package:google_clone/utils/colors.dart';
import 'package:google_clone/viewmodels/login_viewmodel.dart';
import 'package:google_clone/widgets/signin_with_google_btn.dart';

//ProviderRef is used to communicate with other provider
//WidgetRef is used to communicate with widget
//ref.watch when you are inside the build method
//ref.read when you are outside the build method

class Login extends ConsumerWidget {
  static const String routeName = "/login";
  const Login({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth > 480) {
            return Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: kBlueColor,
                    ),
                    child: const Column(
                      children: [],
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SignInWithGoogleBtn(
                        onPressed: () => LoginViewModel().signinWithGoogle(ref, context),
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
