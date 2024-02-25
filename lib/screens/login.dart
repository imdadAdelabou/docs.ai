import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_clone/repository/auth_repository.dart';
import 'package:google_clone/screens/home.dart';
import 'package:google_clone/utils/colors.dart';
import 'package:google_clone/widgets/custom_snack_bar.dart';
import 'package:google_clone/widgets/signin_with_google_btn.dart';

//ProviderRef is used to communicate with other provider
//WidgetRef is used to communicate with widget
//ref.watch when you are inside the build method
//ref.read when you are outside the build method

class Login extends ConsumerWidget {
  static const String routeName = "/login";
  const Login({super.key});

  void signinWithGoogle(WidgetRef ref, BuildContext context) async {
    final sMessenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final result = await ref.read(authRepositoryProvider).signInWithGoogle();
    if (result.error != null) {
      sMessenger.showSnackBar(
        customSnackBar(content: result.error!, isError: true),
      );
      return;
    }
    //We need to update the state with a new value of user
    ref.read(userProvider.notifier).update((state) => result.data);
    navigator.pushNamed(Home.routeName);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Row(
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
                  onPressed: () => signinWithGoogle(ref, context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
