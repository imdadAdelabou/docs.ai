import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_clone/screens/document/widgets/share_btn.dart';
import 'package:google_clone/utils/app_assets.dart';
import 'package:google_clone/utils/colors.dart';

class DocumentScreenAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final double height;
  final TextEditingController titleCtrl;
  const DocumentScreenAppBar({
    Key? key,
    this.height = kToolbarHeight,
    required this.titleCtrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kWhiteColor,
      toolbarHeight: height,
      elevation: 0,
      automaticallyImplyLeading: false,
      actions: const [
        ShareBtn(),
        Gap(20.0),
      ],
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 9.0),
        child: Row(
          children: [
            Image.asset(
              AppAssets.docsIcon,
              height: 40,
            ),
            const Gap(10.0),
            SizedBox(
              width: 180,
              child: TextFormField(
                controller: titleCtrl,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 10.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: kBlueColorVariant),
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
