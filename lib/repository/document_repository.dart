import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_clone/models/document_model.dart';
import 'package:google_clone/models/error_model.dart';
import 'package:google_clone/utils/constant.dart';

final documentRepositoryProvider = Provider(
  (ref) => DocumentRepository(
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
      final result = await _dioClient.post(
        '/doc/create',
        data: {
          'createdAt': DateTime.now().millisecondsSinceEpoch,
        },
        options: Options(
          headers: {
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
      final result = await _dioClient.get(
        '/doc/me',
        options: Options(
          headers: {
            'x-auth-token': token,
          },
        ),
      );
      if (result.statusCode == 200 && result.data["documents"] != null) {
        return ErrorModel(
          data: (result.data["documents"] as List)
              .map<DocumentModel>(
                (document) => DocumentModel.fromJson(
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
}
