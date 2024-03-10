import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_clone/models/document_model.dart';
import 'package:google_clone/repository/auth_repository.dart';
import 'package:google_clone/repository/document_repository.dart';
import 'package:google_clone/utils/app_text.dart';
import 'package:google_clone/utils/colors.dart';
import 'package:google_clone/widgets/custom_snack_bar.dart';
import 'package:routemaster/routemaster.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.height = kTextTabBarHeight,
  });
  final double height;

  void createDocument(BuildContext context, WidgetRef ref) async {
    final token = ref.read(userProvider)!.token;
    final navigator = Routemaster.of(context);
    final snackBar = ScaffoldMessenger.of(context);

    final errorModel =
        await ref.read(documentRepositoryProvider).createDocument(token);
    if (errorModel.data != null) {
      navigator.push('/document/${(errorModel.data as DocumentModel).id}');
      return;
    }
    log(errorModel.error!);
    snackBar.showSnackBar(
      customSnackBar(
        content: AppText.errorHappened,
        isError: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          color: kBlackColor,
          onPressed: () => createDocument(context, ref),
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
