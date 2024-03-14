import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_clone/models/user.dart';
import 'package:google_clone/repository/auth_repository.dart';


class VerifyIfUserNotNull extends ConsumerWidget {
  const VerifyIfUserNotNull({
    required this.child, super.key,
  });
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserModel? user = ref.watch(userProvider);

    return user != null
        ? child
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
