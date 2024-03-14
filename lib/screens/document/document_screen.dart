import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_clone/models/document_model.dart';
import 'package:google_clone/models/error_model.dart';
import 'package:google_clone/repository/auth_repository.dart';
import 'package:google_clone/repository/document_repository.dart';
import 'package:google_clone/screens/document/widgets/document_screen_app_bar.dart';
import 'package:google_clone/utils/colors.dart';

//Snippet : stfl
class DocumentScreen extends ConsumerStatefulWidget {
  const DocumentScreen({
    required this.id, super.key,
  });
  final String id;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends ConsumerState<DocumentScreen> {
  final TextEditingController titleCtrl = TextEditingController(
    text: 'Untitled Document',
  );
  final QuillController _controller = QuillController.basic();
  late ErrorModel _errorModel;

  Future<void> _fetchDocumentData() async {
    _errorModel = await ref.read(documentRepositoryProvider).getDocumentById(
          docId: widget.id,
          token: ref.read(userProvider)!.token,
        );
    if (_errorModel.data != null) {
      final DocumentModel document = _errorModel.data;
      titleCtrl.text = document.title;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchDocumentData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DocumentScreenAppBar(
        titleCtrl: titleCtrl,
        id: widget.id,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const Gap(10),
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
                    borderRadius: BorderRadius.circular(1),
                  ),
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(30),
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
