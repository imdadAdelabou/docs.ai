import 'package:dio/dio.dart';

class DocumentRepository {
  const DocumentRepository({required Dio dioClient}) : _dioClient = dioClient;
  final Dio _dioClient;
}
