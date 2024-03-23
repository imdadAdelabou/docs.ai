import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_clone/models/error_model.dart';
import 'package:google_clone/models/user.dart';
import 'package:google_clone/repository/local_storage_repository.dart';
import 'package:google_clone/utils/app_text.dart';
import 'package:google_clone/utils/constant.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// Contains all the functions using for authentification (SignIn, Logout, getUserData)
/// and Provider allow to access the service globaly
final Provider<AuthRepository> authRepositoryProvider =
    Provider<AuthRepository>(
  (ProviderRef<Object?> ref) => AuthRepository(
    googleSignIn: GoogleSignIn(),
    dioClient: dioClient,
    localStorageRepository: LocalStorageRepository(),
    providerRef: ref,
  ),
);

//StateProvider to create a provider for variables
/// Contains a provider for the UserModel that allow it to be access from any component
final StateProvider<UserModel?> userProvider = StateProvider<UserModel?>(
  (StateProviderRef<UserModel?> ref) => null,
);

/// Represent the Authentification service
class AuthRepository {
  /// Creates a [AuthRepository] instance
  AuthRepository({
    required GoogleSignIn googleSignIn,
    required Dio dioClient,
    required LocalStorageRepository localStorageRepository,
    required ProviderRef<Object?> providerRef,
  })  : _googleSignIn = googleSignIn,
        _dioClient = dioClient,
        _localStorageRepository = localStorageRepository,
        _providerRef = providerRef;
  final GoogleSignIn _googleSignIn;
  final Dio _dioClient;
  final LocalStorageRepository _localStorageRepository;
  final ProviderRef<Object?> _providerRef;

  /// A function used to sign out a user from the app
  Future<bool> signOut() async {
    try {
      await _googleSignIn.signOut();
      final bool isRemove = await LocalStorageRepository().removeToken();
      if (isRemove) {
        _providerRef
            .read(userProvider.notifier)
            .update((UserModel? state) => null);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  /// A function used to sign-in a user to the app
  Future<ErrorModel> signInWithGoogle() async {
    ErrorModel error = const ErrorModel(
      error: 'ServerError',
      data: null,
    );

    try {
      final GoogleSignInAccount? user = await _googleSignIn.signIn();
      if (user != null) {
        log('Photo Url: ${user.photoUrl}');
        final UserModel userData = UserModel(
          email: user.email,
          name: user.displayName ?? '',
          photoUrl: user.photoUrl ?? '',
          token: '',
          id: '',
        );
        final Response<dynamic> res = await _dioClient.post(
          '/signup',
          data: userData.toJson(),
        );
        switch (res.statusCode) {
          case 201:
            {
              final UserModel newUser = userData.copyWith(
                id: res.data['user']['_id'],
                token: res.data['token'],
                isNewUser: res.data['isNewUser'],
              );

              error = ErrorModel(data: newUser);
              await _localStorageRepository.setToken(token: newUser.token);
              break;
            }
        }
      }
    } catch (e) {
      error = ErrorModel(data: null, error: e.toString());
    }

    return error;
  }

  /// A function to get a data of the connected user
  Future<ErrorModel> getUserData() async {
    ErrorModel errorModel = const ErrorModel(data: null);

    try {
      final String? token = await _localStorageRepository.getToken();

      if (token != null) {
        final Response<dynamic> res = await _dioClient.get(
          '/me',
          options: Options(
            headers: <String, dynamic>{
              'x-auth-token': token,
            },
          ),
        );

        res.data['user']['token'] = '';
        errorModel = ErrorModel(
          data: UserModel.fromJson(
            res.data['user'],
          ).copyWith(token: token),
        );
        return errorModel;
      }

      return const ErrorModel(
        error: 'Bad request',
        data: null,
      );
    } catch (e) {
      return const ErrorModel(
        data: null,
        error: AppText.unauthorized,
      );
    }
  }
}
