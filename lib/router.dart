import 'package:flutter/material.dart';
import 'package:google_clone/screens/document/document_screen.dart';
import 'package:google_clone/screens/home.dart';
import 'package:google_clone/screens/login/login.dart';
import 'package:routemaster/routemaster.dart';

final RouteMap loggedOutRoute = RouteMap(
  routes: <String, PageBuilder>{
    '/': (RouteData route) => const MaterialPage(
          child: Login(),
        ),
  },
);

final RouteMap loggedInRoute = RouteMap(
  routes: <String, PageBuilder>{
    '/': (RouteData route) => const MaterialPage(
          child: Home(),
        ),
    '/document/:id': (RouteData route) => MaterialPage(
          child: DocumentScreen(
            id: route.pathParameters['id'] ?? '',
          ),
        ),
  },
);
