import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [],
    );
  }
}
