import 'package:flutter/material.dart';

import '../../presentation/view/splash.dart';
import 'custom_page_transitions.dart';
import 'route_manager.dart';

class AppRouter {
  const AppRouter._();
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteManager.initialRoute:
        return CustomPageTransitions.fade(const SplashPage());
      case RouteManager.home:
        return CustomPageTransitions.fadeForwards(const HomePage());

      default:
        return null;
    }
  }
}
