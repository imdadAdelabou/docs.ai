/// Represents the Document enity
class DocumentModel {
  /// Creates a [DocumentModel] instance
  const DocumentModel({
    required this.id,
    required this.uid,
    required this.createdAt,
    required this.title,
    required this.content,
  });

  /// A function to convert a json to a instance of DocumentModel
  factory DocumentModel.fromJson(Map<String, dynamic> json) => DocumentModel(
        id: json['_id'],
        uid: json['uid'],
        createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt']),
        title: json['title'],
        content: List<dynamic>.from(
          json['content'],
        ),
      );

  /// The unique id of a document
  final String id;

  /// The id of the user that create this document
  final String uid;

  /// The creation date of a document
  final DateTime createdAt;

  /// The title of a document
  final String title;

  /// The contents of a document
  final List<dynamic> content;

  /// To create a JSON representation of a DocumentModel instance
  Map<String, dynamic> toJson() => <String, dynamic>{
        'title': title,
        'content': content,
        'createdAt': DateTime.now().millisecondsSinceEpoch,
      };
}
