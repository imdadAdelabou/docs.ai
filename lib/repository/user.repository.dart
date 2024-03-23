import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_clone/models/error_model.dart';
import 'package:google_clone/models/user.dart';
import 'package:google_clone/repository/local_storage_repository.dart';
import 'package:google_clone/utils/constant.dart';

/// Is used to access the user repository globally
final Provider<UserRepository> userRepositoryProvider =
    Provider<UserRepository>(
  (ProviderRef<UserRepository> ref) => UserRepository(
    dioClient: dioClient,
    localStorageRepository: ref.read(localStorageRepositoryProvider),
  ),
);

/// Contains the functions to interact with the user collection
class UserRepository {
  /// Creates a [UserRepository] instance
  UserRepository({
    required Dio dioClient,
    required LocalStorageRepository localStorageRepository,
  })  : _dioClient = dioClient,
        _localStorageRepository = localStorageRepository;

  final Dio _dioClient;
  final LocalStorageRepository _localStorageRepository;

  /// A function to update some user data
  Future<ErrorModel> update({
    required Map<String, dynamic> data,
  }) async {
    try {
      final String? token = await _localStorageRepository.getToken();
      final Response<dynamic> result = await _dioClient.put(
        '/user/',
        data: data,
        options: Options(
          headers: <String, dynamic>{
            'x-auth-token': token,
          },
        ),
      );
      log('UPDATE USER => ${result.data['user']}');
      if (result.statusCode == 200 && result.data['user'] != null) {
        return ErrorModel(
          data: UserModel.fromJson(
            result.data['user'],
          ).copyWith(
            token: token,
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
