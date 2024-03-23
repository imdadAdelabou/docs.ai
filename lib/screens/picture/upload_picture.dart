import 'package:flutter/material.dart';
import 'package:google_clone/screens/picture/upload_picture_large_view.dart';
import 'package:google_clone/screens/picture/upload_picture_mobile_view.dart';

/// Mange the UploadPicture view and render the right widget if the user is on mobile or large screen
class UploadPicture extends StatelessWidget {
  /// Creates a [UploadPicture] instance
  const UploadPicture({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth > 480) {
              return const UploadPictureLargeView();
            }

            return const UploadPictureMobileView();
          },
        ),
      ),
    );
  }
}
