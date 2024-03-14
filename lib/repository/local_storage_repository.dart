import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Provider<LocalStorageRepository> localStorageRepositoryProvider =
    Provider<LocalStorageRepository>(
        (ProviderRef<Object?> ref) => LocalStorageRepository(),);

class LocalStorageRepository {
  Future<void> setToken({required String token}) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    await sharedPreferences.setString('x-auth-token', token);
  }

  Future<String?> getToken() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    return sharedPreferences.getString('x-auth-token');
  }

  Future<bool> removeToken() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    return sharedPreferences.remove('x-auth-token');
  }
}
