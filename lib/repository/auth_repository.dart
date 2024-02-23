import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_clone/models/error_model.dart';
import 'package:google_clone/models/user.dart';
import 'package:google_clone/utils/constant.dart';
import 'package:google_sign_in/google_sign_in.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    googleSignIn: GoogleSignIn(),
    dioClient: Dio(
      BaseOptions(
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      ),
    ),
  ),
);

//StateProvider to create a provider for variables
final userProvider = StateProvider<UserModel?>((ref) => null);

class AuthRepository {
  final GoogleSignIn _googleSignIn;
  final Dio _dioClient;

  AuthRepository({
    required GoogleSignIn googleSignIn,
    required Dio dioClient,
  })  : _googleSignIn = googleSignIn,
        _dioClient = dioClient;

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
          '$apiHost/signup',
          data: userData.toJson(),
        );
        switch (res.statusCode) {
          case 201:
            {
              final newUser = userData.copyWith(id: res.data['user']['_id']);

              error = ErrorModel(data: newUser);
              break;
            }
        }
      }
    } catch (e) {
      print(e);
      error = ErrorModel(data: null, error: e.toString());
    }

    return error;
  }
}
