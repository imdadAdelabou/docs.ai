import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_clone/models/user.dart';
import 'package:google_clone/repository/auth_repository.dart';
import 'package:google_clone/screens/pricing/pricing_view.dart';
import 'package:google_clone/utils/app_text.dart';
import 'package:google_clone/utils/colors.dart';
import 'package:google_clone/utils/constant.dart';
import 'package:google_clone/widgets/type_pricing_view.dart';
import 'package:google_clone/widgets/user_data.display.dart';
import 'package:google_fonts/google_fonts.dart';

/// A custom drawer to display the user data and other information
class CustomDrawer extends ConsumerWidget {
  /// Creates a [CustomDrawer] widget
  const CustomDrawer({super.key});

  void _showDialog(BuildContext context) {
    unawaited(
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            icon: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: const Align(
                alignment: Alignment.topRight,
                child: Icon(
                  Icons.close,
                  color: kBlackColor,
                ),
              ),
            ),
            content: const PricingView(),
            insetPadding: EdgeInsets.symmetric(
              vertical: 30,
              horizontal: MediaQuery.sizeOf(context).width > 480 ? 0 : 10,
            ),
            backgroundColor: kDialogColor,
            surfaceTintColor: kDialogColor,
            scrollable: true,
            title: Text(
              AppText.pricing,
              style: GoogleFonts.lato(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserModel? user = ref.watch(userProvider);

    return Drawer(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      child: Column(
        children: <Widget>[
          const Gap(20),
          if (user != null)
            UserDataDisplay(
              userModel: user,
            ),
          const Gap(8),
          TypePriciningView(
            label: pricingTest[1].label,
            labelColor: pricingTest[1].labelColor,
          ),
          const Gap(20),
          ListTile(
            title: Text(
              AppText.pricing,
              style: GoogleFonts.lato(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              _showDialog(context);
            },
          ),
        ],
      ),
    );
  }
}
