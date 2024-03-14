import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_clone/models/document_model.dart';
import 'package:google_clone/models/error_model.dart';
import 'package:google_clone/utils/constant.dart';

final Provider<DocumentRepository> documentRepositoryProvider =
    Provider<DocumentRepository>(
  (ProviderRef<Object?> ref) => DocumentRepository(
    dioClient: dioClient,
  ),
);

class DocumentRepository {
  const DocumentRepository({
    required Dio dioClient,
  }) : _dioClient = dioClient;

  final Dio _dioClient;

  Future<ErrorModel> createDocument(String token) async {
    try {
      final Response<dynamic> result = await _dioClient.post(
        '/doc/create',
        data: <String, int>{
          'createdAt': DateTime.now().millisecondsSinceEpoch,
        },
        options: Options(
          headers: <String, dynamic>{
            'x-auth-token': token,
          },
        ),
      );
      if (result.statusCode == 201) {
        return ErrorModel(
          data: DocumentModel.fromJson(
            result.data['document'] as Map<String, dynamic>,
          ),
        );
      }

      return ErrorModel(data: null, error: result.statusMessage);
    } on DioException catch (e) {
      return ErrorModel(
        data: null,
        error: e.message,
      );
    }
  }

  Future<ErrorModel> meDocument(String token) async {
    try {
      final Response<dynamic> result = await _dioClient.get(
        '/doc/me',
        options: Options(
          headers: <String, dynamic>{
            'x-auth-token': token,
          },
        ),
      );
      if (result.statusCode == 200 && result.data['documents'] != null) {
        return ErrorModel(
          data: (result.data['documents'] as List<dynamic>)
              .map<DocumentModel>(
                (dynamic document) => DocumentModel.fromJson(
                  document as Map<String, dynamic>,
                ),
              )
              .toList(),
        );
      }

      return ErrorModel(data: null, error: result.data['message']);
    } on DioException catch (e) {
      return ErrorModel(
        data: null,
        error: e.message,
      );
    }
  }

  Future<ErrorModel> updateTitleDocument({
    required String docId,
    required String token,
    required String newTitle,
  }) async {
    try {
      final Response<dynamic> result = await _dioClient.put(
        '/doc/title',
        data: <String, String>{
          'id': docId,
          'title': newTitle,
        },
        options: Options(
          headers: <String, dynamic>{
            'x-auth-token': token,
          },
        ),
      );
      if (result.statusCode == 200 && result.data['document'] != null) {
        return ErrorModel(
          data: DocumentModel.fromJson(
            result.data['document'],
          ),
        );
      }

      return ErrorModel(data: null, error: result.data['message']);
    } on DioException catch (e) {
      return ErrorModel(
        data: null,
        error: e.message,
      );
    }
  }

  Future<ErrorModel> getDocumentById({
    required String docId,
    required String token,
  }) async {
    try {
      final Response<dynamic> result = await _dioClient.get(
        '/doc/$docId',
        options: Options(
          headers: <String, dynamic>{
            'x-auth-token': token,
          },
        ),
      );
      if (result.statusCode == 200 && result.data['document'] != null) {
        return ErrorModel(
          data: DocumentModel.fromJson(
            result.data['document'],
          ),
        );
      }

      return ErrorModel(data: null, error: result.data['message']);
    } on DioException catch (e) {
      return ErrorModel(
        data: null,
        error: e.message,
      );
    }
  }
}