import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_clone/repository/auth_repository.dart';
import 'package:google_clone/utils/colors.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.height = kTextTabBarHeight,
  });
  final double height;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          color: kBlackColor,
          onPressed: () {},
        ),
        const Gap(20.0),
        //TODO: Ajouter une confirmation avant le logout
        IconButton(
          icon: const Icon(Icons.logout),
          color: kRedColor,
          onPressed: () => ref.read(authRepositoryProvider).signOut(),
        ),
        const Gap(20.0),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
