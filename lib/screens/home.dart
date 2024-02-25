import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_clone/repository/auth_repository.dart';
import 'package:google_clone/screens/verify_if_user_not_null.dart';
import 'package:google_clone/widgets/user_data.display.dart';

class Home extends ConsumerWidget {
  static String routeName = "/home";
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var user = ref.watch(userProvider);

    return Scaffold(
      body: VerifyIfUserNotNull(
        child: Column(
          children: [
            if (user != null)
              UserDataDisplay(
                userModel: user,
              )
          ],
        ),
      ),
    );
  }
}
