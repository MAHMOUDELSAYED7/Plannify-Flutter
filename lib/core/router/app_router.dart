import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plannify/core/locator/locator.dart';
import 'package:plannify/presentation/cubit/onboarding/onboarding_cubit.dart';
import 'package:plannify/presentation/view/onboarding_screens.dart';

// import '../../presentation/view/home.dart';
// import '../../presentation/view/login.dart';
import '../../presentation/view/splash_screen.dart';
import 'custom_page_transitions.dart';
import 'routes.dart';

class AppRouter {
  const AppRouter._();
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteManager.initialRoute:
        return CustomPageTransitions.fade(const SplashScreen());
      case RouteManager.onboarding:
        return CustomPageTransitions.fade(
          BlocProvider(
            create: (_) => locator<OnboardingCubit>(),
            child: const OnboardingScreen(),
          ),
        );
      // case RouteManager.login:
      //   return CustomPageTransitions.fadeForwards(LoginPage());
      // case RouteManager.home:
      //   return CustomPageTransitions.fadeForwards(HomePage());

      default:
        return MaterialPageRoute(
          builder:
              (_) => Scaffold(
                appBar: AppBar(title: const Text('Page Not Found')),
                body: const Center(child: Text('404 - Page Not Found')),
              ),
        );
    }
  }
}
