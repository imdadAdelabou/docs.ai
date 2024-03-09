import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_clone/models/error_model.dart';
import 'package:google_clone/repository/auth_repository.dart';
import 'package:google_clone/router.dart';
import 'package:routemaster/routemaster.dart';

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

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // initialRoute: '',
      // home: user == null ? const Login() : const Home(),
      // routes: {
      //   Login.routeName: (_) => const Login(),
      //   Home.routeName: (_) => const Home()
      // },
      debugShowCheckedModeBanner: false,
      routerDelegate: RoutemasterDelegate(
        routesBuilder: (context) {
          final user = ref.watch(userProvider);
          if (user != null && user.token.isNotEmpty) {
            //User is connected
            return loggedInRoute;
          }

          return loggedOutRoute;
        },
      ),
      routeInformationParser: const RoutemasterParser(),
    );
  }
}

//flutter run -d chrome --web-port 3000