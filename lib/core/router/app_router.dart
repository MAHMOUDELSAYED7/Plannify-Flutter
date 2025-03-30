import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plannify/presentation/cubit/auth/auth_status/auth_status_cubit.dart';
import 'package:plannify/presentation/cubit/auth/reset_password/reset_password_cubit.dart';
import 'package:plannify/presentation/cubit/auth/verify_otp/verify_otp_cubit.dart';
import 'package:plannify/presentation/view/forgot_password_screen.dart';

import '../../presentation/cubit/auth/forgot_password/forgot_password_cubit.dart';
import '../../presentation/cubit/auth/login/login_cubit.dart';
import '../../presentation/cubit/auth/register/register_cubit.dart';
import '../../presentation/cubit/onboarding/onboarding_cubit.dart';
import '../../presentation/view/home_screen.dart';
import '../../presentation/view/login_screen.dart';
import '../../presentation/view/onboarding_screens.dart';
import '../../presentation/view/register_screen.dart';
import '../../presentation/view/reset_password_screen.dart';
import '../../presentation/view/splash_screen.dart';
import '../../presentation/view/verify_otp_screen.dart';
import '../locator/locator.dart';
import 'custom_page_transitions.dart';
import 'routes.dart';

class AppRouter {
  const AppRouter._();
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteManager.initialRoute:
        return CustomPageTransitions.fade(
          BlocProvider(
            create: (_) => sl<AuthStatusCubit>(),
            child: const SplashScreen(),
          ),
        );
      case RouteManager.onboarding:
        return CustomPageTransitions.fade(
          BlocProvider(
            create: (_) => sl<OnboardingCubit>(),
            child: const OnboardingScreen(),
          ),
        );
      case RouteManager.login:
        return CustomPageTransitions.fadeForwards(
          BlocProvider(
            create: (_) => sl<LoginCubit>(),
            child: LoginScreen(),
          ),
        );
      case RouteManager.register:
        return CustomPageTransitions.fadeForwards(
          BlocProvider(
            create: (_) => sl<RegisterCubit>(),
            child: RegisterScreen(),
          ),
        );
      case RouteManager.forgotPassword:
        return CustomPageTransitions.fadeForwards(
          BlocProvider(
            create: (_) => sl<ForgotPasswordCubit>(),
            child: const ForgotPasswordScreen(),
          ),
        );
      case RouteManager.verifyOtp:
        final email = settings.arguments as String;
        return CustomPageTransitions.fadeForwards(
          BlocProvider(
            create: (_) => sl<VerifyOtpCubit>(),
            child: VerifyOtpScreen(email: email),
          ),
        );
      case RouteManager.resetPassword:
        final email = settings.arguments as String;
        return CustomPageTransitions.fadeForwards(
          BlocProvider(
            create: (_) => sl<ResetPasswordCubit>(),
            child: ResetPasswordScreen(email: email),
          ),
        );
      case RouteManager.home:
        return CustomPageTransitions.fadeForwards(
          BlocProvider(
            create: (_) => sl<AuthStatusCubit>(),
            child: HomeScreen(),
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
