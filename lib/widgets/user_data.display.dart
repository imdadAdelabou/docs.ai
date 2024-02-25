import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_clone/models/user.dart';
import 'package:google_clone/utils/app_assets.dart';
import 'package:google_fonts/google_fonts.dart';

class UserDataDisplay extends StatelessWidget {
  final UserModel userModel;
  const UserDataDisplay({
    super.key,
    required this.userModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (userModel.photoUrl.isEmpty)
          CircleAvatar(
            radius: 70.0,
            backgroundImage: AssetImage(AppAssets.avatarPlaceHolder),
          )
        else
          CachedNetworkImage(
            imageUrl: userModel.photoUrl,
            imageBuilder: (context, imageProvider) => CircleAvatar(
              radius: 70.0,
              backgroundImage: imageProvider,
            ),
          ),
        const Gap(4.0),
        Text(
          userModel.name,
          style: GoogleFonts.lato(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        const Gap(4.0),
        Text(
          userModel.email,
          style: GoogleFonts.lato(
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
