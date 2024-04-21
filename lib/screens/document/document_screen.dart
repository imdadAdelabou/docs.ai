import 'dart:async';

import 'package:docs_ai/models/document_model.dart';
import 'package:docs_ai/models/error_model.dart';
import 'package:docs_ai/repository/auth_repository.dart';
import 'package:docs_ai/repository/document_repository.dart';
import 'package:docs_ai/repository/socket_repository.dart';
import 'package:docs_ai/screens/document/widgets/document_screen_app_bar.dart';
import 'package:docs_ai/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

//Snippet : stfl
/// Contains the visual aspect of the document screen
class DocumentScreen extends ConsumerStatefulWidget {
  /// Creates [DocumentScreen] widget
  const DocumentScreen({
    required this.id,
    super.key,
  });

  /// Contains the unique id of the document to display
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
  SocketRespository socketRespository = SocketRespository();
  late StreamSubscription<DocChange> _subscriptionToDoc;
  late Timer timerAutoSave;

  Future<void> _fetchDocumentData() async {
    _errorModel = await ref.read(documentRepositoryProvider).getDocumentById(
          docId: widget.id,
          token: ref.read(userProvider)!.token,
        );

    if (_errorModel.data != null) {
      final DocumentModel document = _errorModel.data;
      titleCtrl.text = document.title;

      _controller.document = document.content.isEmpty
          ? Document()
          : Document.fromDelta(
              Delta.fromJson(document.content),
            );
      setState(() {});
    }
    _subscriptionToDoc = _controller.document.changes.listen(
      (DocChange event) {
        if (event.source == ChangeSource.local) {
          final Map<String, dynamic> map = <String, dynamic>{
            'delta': event.change,
            'room': widget.id,
          };

          socketRespository.typing(map);
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    socketRespository.joinRoom(widget.id);
    unawaited(_fetchDocumentData());

    socketRespository.changeListener(
      (Map<String, dynamic> data) {
        _controller.compose(
          Delta.fromJson(data['delta']),
          const TextSelection.collapsed(offset: 0),
          ChangeSource.remote,
        );
      },
    );

    Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      socketRespository.save(
        <String, dynamic>{
          'id': widget.id,
          'delta': _controller.document.toDelta(),
        },
      );
    });
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
                child: DocumentBody(
                  controller: _controller,
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
    // timerAutoSave.cancel();
    _controller.dispose();
    unawaited(_subscriptionToDoc.cancel());
  }
}

/// Represents the body of the document screen without the app bar
class DocumentBody extends StatelessWidget {
  /// Creates a [DocumentBody] widget
  const DocumentBody({
    required QuillController controller,
    super.key,
  }) : _controller = controller;

  final QuillController _controller;

  @override
  Widget build(BuildContext context) {
    return Card(
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
    );
  }
}
