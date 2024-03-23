import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_clone/models/error_model.dart';
import 'package:google_clone/models/user.dart';
import 'package:google_clone/repository/auth_repository.dart';
import 'package:google_clone/repository/firebase_storage_repository.dart';
import 'package:google_clone/repository/image_picker_repository.dart';
import 'package:google_clone/repository/user.repository.dart';
import 'package:google_clone/utils/app_text.dart';
import 'package:google_clone/utils/colors.dart';
import 'package:google_clone/widgets/custom_btn.dart';
import 'package:google_clone/widgets/show_remote_profile_pic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:routemaster/routemaster.dart';

/// The widgets that contains the layout to display on mobile device
class UploadPictureMobileView extends ConsumerStatefulWidget {
  /// Creates a [UploadPictureMobileView] instance
  const UploadPictureMobileView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UploadPictureMobileViewState();
}

class _UploadPictureMobileViewState
    extends ConsumerState<UploadPictureMobileView> {
  XFile? _pickedFile;
  bool _isLoading = false;

  Future<void> _pickFile(WidgetRef ref) async {
    _pickedFile =
        await ref.read(imagePickerRepositoryProvider).pickImageFromGallery();
    setState(() {});
  }

  Future<void> _uploadHandle(WidgetRef ref) async {
    void goToHome() => Routemaster.of(context).replace('/');
    setState(() {
      _isLoading = true;
    });
    final String pictureUrl =
        await ref.read(firebaseStorageRepositoryProvider).uploadFile(
              path: 'images/',
              file: File(
                _pickedFile!.path,
              ),
            );

    if (pictureUrl is bool) {
      setState(() {
        _isLoading = false;
      });
      // Handle error
      return;
    }
    log(pictureUrl);
    final ErrorModel result = await ref.read(userRepositoryProvider).update(
      data: <String, String>{
        'photoUrl': pictureUrl,
      },
    );
    setState(() {
      _isLoading = false;
    });
    ref.read(userProvider.notifier).update(
          (_) => result.data,
        );

    ///Upate profile pic on backend
    goToHome();
  }

  @override
  Widget build(BuildContext context) {
    final UserModel? userModel = ref.watch(userProvider);

    return Center(
      child: Column(
        children: <Widget>[
          const Gap(20),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () => Routemaster.of(context).replace('/'),
                child: Text(
                  AppText.skip,
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          const Gap(30),
          Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              if (userModel != null && userModel.photoUrl.isNotEmpty)
                ShowRemoteProfilPic(
                  url: userModel.photoUrl,
                )
              else
                CircleAvatar(
                  radius: 70,
                  backgroundImage: _pickedFile != null
                      ? FileImage(File(_pickedFile!.path))
                      : null,
                ),
              Positioned(
                bottom: -18,
                left: 43,
                child: IconButton(
                  onPressed: () => unawaited(
                    _pickFile(ref),
                  ),
                  icon: const Icon(
                    Icons.add,
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith(
                      (_) => kWhiteColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Gap(40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              AppText.descriptionOnUploadPicture,
              style: GoogleFonts.lato(
                fontSize: 16,
                color: kGreyColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomBtn(
              isLoading: _isLoading,
              label: AppText.upload,
              onPressed: _pickedFile != null
                  ? () => unawaited(_uploadHandle(ref))
                  : null,
            ),
          ),
          const Gap(50),
        ],
      ),
    );
  }
}
