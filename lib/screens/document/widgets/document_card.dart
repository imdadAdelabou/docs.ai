import 'package:flutter/material.dart';
import 'package:google_clone/models/document_model.dart';
import 'package:google_clone/utils/colors.dart';
import 'package:routemaster/routemaster.dart';

class DocumentCard extends StatelessWidget {
  final DocumentModel document;
  const DocumentCard({
    super.key,
    required this.document,
  });

  void _goToDocument(BuildContext context, String documentId) {
    Routemaster.of(context).push('/document/$documentId');
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _goToDocument(context, document.id),
      child: Card(
        color: kWhiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '${document.title} - ${document.id}',
          ),
        ),
      ),
    );
  }
}
