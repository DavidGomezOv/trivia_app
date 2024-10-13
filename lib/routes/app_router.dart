import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trivia_app/presentation/pages/category/category_page.dart';
import 'package:trivia_app/presentation/pages/error_page.dart';
import 'package:trivia_app/presentation/pages/menu/menu_page.dart';
import 'package:trivia_app/routes/route_data.dart';

class AppRouter {
  static final AppRouteData menuRouteData = AppRouteData(name: 'menu', path: '/menu');
  static final AppRouteData categoryRouteData = AppRouteData(name: 'category', path: '/category');

  static GoRouter generateAppRouter(BuildContext context) {
    return GoRouter(
      initialLocation: menuRouteData.path,
      routes: [
        GoRoute(
          name: menuRouteData.name,
          path: menuRouteData.path,
          pageBuilder: (context, state) => CustomTransitionPage(
            child: const MenuPage(),
            transitionDuration: const Duration(milliseconds: 500),
            transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(
              opacity: animation,
              child: child,
            ),
          ),
        ),
        GoRoute(
          name: categoryRouteData.name,
          path: categoryRouteData.path,
          pageBuilder: (context, state) => CustomTransitionPage(
            child: const CategoryPage(),
            transitionDuration: const Duration(milliseconds: 500),
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
