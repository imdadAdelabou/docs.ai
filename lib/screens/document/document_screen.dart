import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_clone/screens/document/widgets/document_screen_app_bar.dart';
import 'package:google_clone/utils/colors.dart';

//Snippet : stfl
class DocumentScreen extends ConsumerStatefulWidget {
  final String id;
  const DocumentScreen({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends ConsumerState<DocumentScreen> {
  final TextEditingController titleCtrl = TextEditingController(
    text: 'Untitled Document',
  );
  final QuillController _controller = QuillController.basic();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DocumentScreenAppBar(
        titleCtrl: titleCtrl,
      ),
      body: Center(
        child: Column(
          children: [
            const Gap(10.0),
            QuillToolbar.simple(
              configurations: QuillSimpleToolbarConfigurations(
                controller: _controller,
              ),
            ),
            Expanded(
              child: SizedBox(
                width: 750,
                child: Card(
                  color: kWhiteColor,
                  surfaceTintColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(1.0),
                  ),
                  elevation: 5.0,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: QuillEditor.basic(
                      configurations: QuillEditorConfigurations(
                        controller: _controller,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    titleCtrl.dispose();
  }
}
