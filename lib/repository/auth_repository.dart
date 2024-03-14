import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_clone/models/error_model.dart';
import 'package:google_clone/models/user.dart';
import 'package:google_clone/repository/local_storage_repository.dart';
import 'package:google_clone/utils/app_text.dart';
import 'package:google_clone/utils/constant.dart';
import 'package:google_sign_in/google_sign_in.dart';

//For register service
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
final StateProvider<UserModel?> userProvider =
    StateProvider<UserModel?>((StateProviderRef<UserModel?> ref) => null);

class AuthRepository {
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

  Future<ErrorModel> signInWithGoogle() async {
    ErrorModel error = const ErrorModel(
      error: 'ServerError',
      data: null,
    );

    try {
      final GoogleSignInAccount? user = await _googleSignIn.signIn();
      if (user != null) {
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

      throw 'Bad request';
    } catch (e) {
      return const ErrorModel(
        data: null,
        error: AppText.unauthorized,
      );
    }
  }
}
