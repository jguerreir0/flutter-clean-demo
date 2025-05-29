import 'package:flutter/material.dart';
import 'package:mydemo/di.dart';
import 'package:mydemo/login/presentation/login_page.dart';

import 'home/presentation/home_page.dart';
import 'splash/presentation/splash_page.dart';
import 'utils/fade_route_transition/fade_route_transition.dart';

const String splashRoute = '/';
const String loginRoute = '/login';
const String homeRoute = '/home';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashRoute:
        return MaterialPageRoute(
          builder: (_) => withAuthBloc(child: const SplashPage()),
        );
      case loginRoute:
        return FadeRouteTransition(
          page: withAuthBloc(child: const LoginPage()),
        );
      case homeRoute:
        return FadeRouteTransition(
          page: withAuthAndProductsBloc(child: const HomePage()),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Page not found')),
          ),
        );
    }
  }
}
