import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_clone/repository/auth_repository.dart';
import 'package:google_clone/widgets/custom_snack_bar.dart';
import 'package:routemaster/routemaster.dart';

class LoginViewModel {
  void signinWithGoogle(WidgetRef ref, BuildContext context) async {
    final sMessenger = ScaffoldMessenger.of(context);
    final navigator = Routemaster.of(context);
    final result = await ref.read(authRepositoryProvider).signInWithGoogle();
    if (result.error != null) {
      sMessenger.showSnackBar(
        customSnackBar(content: result.error!, isError: true),
      );
      return;
    }
    //We need to update the state with a new value of user
    ref.read(userProvider.notifier).update((state) => result.data);
    navigator.replace('/');
  }
}
