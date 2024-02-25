import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_clone/repository/auth_repository.dart';


class VerifyIfUserNotNull extends ConsumerWidget {
  final Widget child;
  const VerifyIfUserNotNull({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var user = ref.watch(userProvider);

    return user != null
        ? child
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
