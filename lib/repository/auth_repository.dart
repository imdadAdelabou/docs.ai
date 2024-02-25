import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_clone/models/error_model.dart';
import 'package:google_clone/models/user.dart';
import 'package:google_clone/repository/local_storage_repository.dart';
import 'package:google_clone/utils/app_text.dart';
import 'package:google_clone/utils/constant.dart';
import 'package:google_sign_in/google_sign_in.dart';

//For register service
final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
      googleSignIn: GoogleSignIn(),
      dioClient: Dio(
        BaseOptions(
          baseUrl: apiHost,
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
        ),
      ),
      localStorageRepository: LocalStorageRepository()),
);

//StateProvider to create a provider for variables
final userProvider = StateProvider<UserModel?>((ref) => null);
final stateViewCheckLogin = StateProvider<ViewState>((ref) => ViewState.busy);


class AuthRepository {
  final GoogleSignIn _googleSignIn;
  final Dio _dioClient;
  final LocalStorageRepository _localStorageRepository;

  AuthRepository(
      {required GoogleSignIn googleSignIn,
      required Dio dioClient,
      required LocalStorageRepository localStorageRepository})
      : _googleSignIn = googleSignIn,
        _dioClient = dioClient,
        _localStorageRepository = localStorageRepository;

  Future<ErrorModel> signInWithGoogle() async {
    ErrorModel error = const ErrorModel(
      error: 'ServerError',
      data: null,
    );

    try {
      final user = await _googleSignIn.signIn();
      if (user != null) {
        final userData = UserModel(
          email: user.email,
          name: user.displayName ?? "",
          photoUrl: user.photoUrl ?? "",
          token: '',
          id: '',
        );

        final res = await _dioClient.post(
          '/signup',
          data: userData.toJson(),
        );
        switch (res.statusCode) {
          case 201:
            {
              final newUser = userData.copyWith(
                  id: res.data['user']['_id'], token: res.data['token']);

              error = ErrorModel(data: newUser);
              _localStorageRepository.setToken(token: newUser.token);
              break;
            }
        }
      }
    } catch (e) {
      error = ErrorModel(data: null, error: e.toString());
    }

    return error;
  }

  Future<ErrorModel> getUserData() async {
    ErrorModel errorModel = const ErrorModel(data: null, error: null);

    try {
      String? token = await _localStorageRepository.getToken();

      if (token != null) {
        final res = await _dioClient.get(
          '/me',
          options: Options(
            headers: {
              'x-auth-token': token,
            },
          ),
        );

        res.data['user']['token'] = '';
        errorModel = ErrorModel(
          error: null,
          data: UserModel.fromJson(
            res.data['user'],
          ).copyWith(token: token),
        );
        return errorModel;
      }

      throw "Bad request";
    } catch (e) {
      return const ErrorModel(
        data: null,
        error: AppText.unauthorized,
      );
    }
  }
}
