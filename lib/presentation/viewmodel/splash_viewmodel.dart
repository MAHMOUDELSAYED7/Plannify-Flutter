import 'package:flutter/material.dart';
import 'package:plannify/core/utils/extensions/extensions.dart';

import '../../core/router/routes.dart';

class SplashViewModel {
  void redirect(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 2),
      () => context.pushReplacementNamed(RouteManager.onboarding),
    );
  }
}
