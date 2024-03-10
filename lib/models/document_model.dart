class DocumentModel {
  final String id;
  final String uid;
  final DateTime createdAt;
  final String title;
  final List content;

  const DocumentModel({
    required this.id,
    required this.uid,
    required this.createdAt,
    required this.title,
    required this.content,
  });

  factory DocumentModel.fromJson(Map<String, dynamic> json) => DocumentModel(
        id: json['_id'],
        uid: json['uid'],
        createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt']),
        title: json['title'],
        content: List.from(json['content']),
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'content': content,
        'createdAt': DateTime.now().millisecondsSinceEpoch,
      };
}
