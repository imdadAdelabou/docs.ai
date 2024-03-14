import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_clone/repository/auth_repository.dart';
import 'package:google_clone/repository/document_repository.dart';
import 'package:google_clone/screens/document/widgets/share_btn.dart';
import 'package:google_clone/utils/app_assets.dart';
import 'package:google_clone/utils/colors.dart';

/// Contains the AppBar of the document screen
class DocumentScreenAppBar extends ConsumerWidget
    implements PreferredSizeWidget {
  /// Creates a [DocumentScreenAppBar]
  const DocumentScreenAppBar({
    required this.titleCtrl,
    required this.id,
    super.key,
    this.height = kToolbarHeight,
  });

  /// Contains the height of the AppBar
  final double height;

  /// Contains the textEditingController of the input that contains the title of the document
  final TextEditingController titleCtrl;

  /// Contains the id of the document
  final String id;

  Future<void> _updateTitle({
    required WidgetRef ref,
    required String title,
  }) async {
    final String token = ref.read(userProvider)!.token;
    await ref.read(documentRepositoryProvider).updateTitleDocument(
          docId: id,
          token: token,
          newTitle: title,
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      backgroundColor: kWhiteColor,
      toolbarHeight: height,
      elevation: 0,
      automaticallyImplyLeading: false,
      actions: const <Widget>[
        ShareBtn(),
        Gap(20),
      ],
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 9),
        child: Row(
          children: <Widget>[
            Image.asset(
              AppAssets.docsIcon,
              height: 40,
            ),
            const Gap(10),
            SizedBox(
              width: 180,
              child: TextFormField(
                controller: titleCtrl,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 10),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: kBlueColorVariant,
                    ),
                  ),
                ),
                onFieldSubmitted: (String value) => unawaited(
                  _updateTitle(
                    ref: ref,
                    title: value,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: kGreyColor,
              width: 0.1,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
