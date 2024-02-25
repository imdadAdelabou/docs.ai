import 'package:flutter/material.dart';

class LoaderScreen extends StatelessWidget {
  static const String routeName = "/loader-screen";
  const LoaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  AlertDialog(content: Column(children: [CircularProgressIndicator()],),);
  }
}