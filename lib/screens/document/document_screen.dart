import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_clone/screens/document/widgets/document_screen_app_bar.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DocumentScreenAppBar(
        titleCtrl: titleCtrl,
      ),
      body: Column(
        children: [
          Text(
            widget.id,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    titleCtrl.dispose();
  }
}
