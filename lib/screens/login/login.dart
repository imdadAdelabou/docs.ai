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
//routemaster to manage rooting on web

class Login extends ConsumerWidget {
  const Login({super.key});
  static const String routeName = '/login';

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
                    child: Column(
                      
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SignInWithGoogleBtn(
                        onPressed: () =>
                            LoginViewModel().signinWithGoogle(ref, context),
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
