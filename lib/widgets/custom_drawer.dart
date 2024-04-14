import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_clone/models/user.dart';
import 'package:google_clone/repository/auth_repository.dart';
import 'package:google_clone/utils/constant.dart';
import 'package:google_clone/widgets/type_pricing_view.dart';
import 'package:google_clone/widgets/user_data.display.dart';

/// A custom drawer to display the user data and other information
class CustomDrawer extends ConsumerWidget {
  /// Creates a [CustomDrawer] widget
  const CustomDrawer({super.key});

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
        ],
      ),
    );
  }
}
