import 'package:docs_ai/models/document_model.dart';
import 'package:docs_ai/screens/document/widgets/document_card.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late DocumentModel document;
  setUp(() {
    document = DocumentModel(
      id: '1',
      uid: 'imdad96',
      createdAt: DateTime(2024, 12, 12),
      title: 'New Document',
      content: <dynamic>[],
      image: null,
    );
  });

  testWidgets(
    'DocumentCard should display the basic information of a card',
    (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(
        DocumentCard(document: document),
      );

      final Finder titleDocumentFinder = find.text(document.title);
      expect(titleDocumentFinder, findsOneWidget);
    },
  );
}
