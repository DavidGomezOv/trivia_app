import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trivia_app/pages/error_page.dart';
import 'package:trivia_app/pages/menu/menu_page.dart';
import 'package:trivia_app/routes/route_data.dart';

class AppRouter {
  static final AppRouteData menuRouteData = AppRouteData(name: 'menu', path: '/menu');

  static GoRouter generateAppRouter(BuildContext context) {
    return GoRouter(
      initialLocation: menuRouteData.path,
      routes: [
        GoRoute(
          name: menuRouteData.name,
          path: menuRouteData.path,
          pageBuilder: (context, state) => CustomTransitionPage(
            child: const MenuPage(),
            transitionDuration: const Duration(milliseconds: 200),
            transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(
              opacity: animation,
              child: child,
            ),
          ),
        ),
      ],
      errorBuilder: (context, state) => ErrorPage(errorMessage: state.error?.message),
    );
  }
}
