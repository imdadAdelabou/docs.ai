import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_clone/models/error_model.dart';
import 'package:google_clone/models/user.dart';
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

/// The first widget that is load when the application is launch for the first time
class MainApp extends ConsumerStatefulWidget {
  /// Creates a [MainApp] widget
  const MainApp({super.key});

  @override
  ConsumerState<MainApp> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {
  bool isLoading = false;
  ErrorModel? errorModel;

  Future<void> getUserData() async {
    errorModel = await ref.read(authRepositoryProvider).getUserData();
    if (errorModel != null && errorModel!.data != null) {
      ref.read(userProvider.notifier).update(
            (UserModel? state) => errorModel!.data,
          );
    }
  }

  @override
  void initState() {
    super.initState();
    unawaited(getUserData());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerDelegate: RoutemasterDelegate(
        routesBuilder: (BuildContext context) {
          final UserModel? user = ref.watch(userProvider);
          if (user != null && user.token.isNotEmpty) {
            //User is connected root
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
