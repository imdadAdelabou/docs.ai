import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_clone/models/error_model.dart';
import 'package:google_clone/models/user.dart';
import 'package:google_clone/repository/auth_repository.dart';
import 'package:google_clone/screens/home.dart';
import 'package:google_clone/screens/loader_screen.dart';
import 'package:google_clone/screens/login.dart';
import 'package:google_clone/utils/constant.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<MainApp> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {
  bool isLoading = false;
  ErrorModel? errorModel;

  void getUserData() async {
    errorModel = await ref.read(authRepositoryProvider).getUserData();
    if (errorModel != null && errorModel!.data != null) {
      ref.read(userProvider.notifier).update(
            (state) => errorModel!.data,
          );
    }
  }

  String getTheRightView({required UserModel? user, required ViewState viewState}) {
    if (viewState != ViewState.busy) {
      return user == null ? Login.routeName : Home.routeName;
    }

    return LoaderScreen.routeName;
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);

    print(user != null  ? user.toJson() : "Is null");
    return MaterialApp(
      initialRoute: user == null ? Login.routeName : Home.routeName,
      routes: {
        Login.routeName: (_) => const Login(),
        Home.routeName: (_) => const Home(),
        LoaderScreen.routeName: (_) => const LoaderScreen()
      },
    );
  }
}

//flutter run -d chrome --web-port 3000