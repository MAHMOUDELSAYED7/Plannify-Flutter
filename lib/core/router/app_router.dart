import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plannify/presentation/view/forgot_password_screen.dart';

import '../../presentation/cubit/auth/forgot_password/forgot_password_cubit.dart';
import '../../presentation/cubit/auth/login/login_cubit.dart';
import '../../presentation/cubit/auth/register/register_cubit.dart';
import '../../presentation/cubit/onboarding/onboarding_cubit.dart';
import '../../presentation/view/login_screen.dart';
import '../../presentation/view/onboarding_screens.dart';
import '../../presentation/view/register_screen.dart';
import '../../presentation/view/splash_screen.dart';
import '../locator/locator.dart';
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
      case RouteManager.login:
        return CustomPageTransitions.fadeForwards(
          BlocProvider(
            create: (_) => locator<LoginCubit>(),
            child: LoginScreen(),
          ),
        );
      case RouteManager.register:
        return CustomPageTransitions.fadeForwards(
          BlocProvider(
            create: (_) => locator<RegisterCubit>(),
            child: RegisterScreen(),
          ),
        );
      case RouteManager.forgotPassword:
        return CustomPageTransitions.fadeForwards(
          BlocProvider(
            create: (_) => locator<ForgotPasswordCubit>(),
            child: const ForgotPasswordScreen(),
          ),
        );

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
