import 'package:aarthik_setu/pages/breakpoints/sign_in.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';


final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => const MaterialPage(child: SignInPage()),
    ),
  ],
);
