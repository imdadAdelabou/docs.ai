import 'package:flutter/material.dart';
import 'package:google_clone/screens/document/document_screen.dart';
import 'package:google_clone/screens/home.dart';
import 'package:google_clone/screens/login/login.dart';
import 'package:routemaster/routemaster.dart';

/// Contains the routes available when the user is logOut
final RouteMap loggedOutRoute = RouteMap(
  routes: <String, PageBuilder>{
    '/': (RouteData route) => const MaterialPage<dynamic>(
          child: Login(),
        ),
  },
);

/// Contains the routes available when the user is logIn
final RouteMap loggedInRoute = RouteMap(
  routes: <String, PageBuilder>{
    '/': (RouteData route) => const MaterialPage<dynamic>(
          child: Home(),
        ),
    '/document/:id': (RouteData route) => MaterialPage<dynamic>(
          child: DocumentScreen(
            id: route.pathParameters['id'] ?? '',
          ),
        ),
  },
);
