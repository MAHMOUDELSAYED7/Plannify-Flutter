import 'package:flutter/material.dart';

// import '../../presentation/view/home.dart';
// import '../../presentation/view/login.dart';
// import '../../presentation/view/splash.dart';
// import 'custom_page_transitions.dart';
// import 'routes.dart';

class AppRouter {
  const AppRouter._();
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case RouteManager.initialRoute:
      //   return CustomPageTransitions.fade(const SplashPage());
      // case RouteManager.login:
      //   return CustomPageTransitions.fadeForwards(LoginPage());
      // case RouteManager.home:
      //   return CustomPageTransitions.fadeForwards(HomePage());

      default:
        return null;
    }
  }
}
