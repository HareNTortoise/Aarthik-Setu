import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:aarthik_setu/main.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => MaterialPage(child: const MyHomePage(title: 'Flutter Demo Home Page')),
    ),
    // Add more routes here as needed
  ],
);
