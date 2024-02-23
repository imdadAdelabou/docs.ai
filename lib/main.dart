import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_clone/screens/home.dart';
import 'package:google_clone/screens/login.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Login.routeName,
      routes: {
        Login.routeName: (_) => const Login(),
        Home.routeName: (_) => const Home()
      },
    );
  }
}
