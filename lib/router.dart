import 'package:flutter/material.dart';
import 'package:google_clone/screens/document/document_screen.dart';
import 'package:google_clone/screens/home.dart';
import 'package:google_clone/screens/login/login.dart';
import 'package:routemaster/routemaster.dart';

final loggedOutRoute = RouteMap(
  routes: {
    '/': (route) => const MaterialPage(
          child: Login(),
        ),
  },
);

final loggedInRoute = RouteMap(
  routes: {
    '/': (route) => const MaterialPage(
          child: Home(),
        ),
    '/document/:id': (route) => MaterialPage(
          child: DocumentScreen(
            id: route.pathParameters['id'] ?? '',
          ),
        ),
  },
);
