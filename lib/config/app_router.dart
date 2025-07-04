import 'package:flutter/material.dart';
import 'package:food_limmit_controller/ui/camera/camera_page.dart';
import 'package:food_limmit_controller/ui/insert_page/insert_item_page.dart';
import 'package:food_limmit_controller/ui/screen/screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return MyScreen();
      },
    ),
    GoRoute(
      path: '/camera',
      builder: (BuildContext context, GoRouterState state) {
        return CameraPage();
      },
    ),
    GoRoute(
      path: '/camera/insert',
      builder: (BuildContext context, GoRouterState state) {
        final String? imagePath = state.extra as String?;
        return InsertPage(imagePath: imagePath ?? '');
      },
    ),
  ],
);
