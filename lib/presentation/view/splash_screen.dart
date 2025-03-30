import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plannify/core/constants/font_size.dart';
import 'package:plannify/core/constants/images.dart';
import 'package:plannify/core/utils/extensions/extensions.dart';
import 'package:plannify/core/utils/helpers/image_handler.dart';
import 'package:plannify/presentation/cubit/auth/auth_status/auth_status_cubit.dart';

import '../../core/router/routes.dart';
import '../../core/themes/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthStatusCubit, AuthStatusState>(
      listener: (context, state) {
        if (state is AuthStatusAuthenticated) {
          context.pushNamedAndRemoveUntil(RouteManager.home);
        } else if (state is AuthStatusUnauthenticated) {
          context.pushNamedAndRemoveUntil(RouteManager.onboarding);
        } else if (state is AuthStatusError) {
          context.pushNamedAndRemoveUntil(RouteManager.login);
        }
      },
      child: Scaffold(
        backgroundColor: ColorManager.primary,

        body: Stack(
          alignment: Alignment.center,
          children: [
            ImageHandler.image(ImageManager.splashLogo).center(),
            Text(
              "Plannify",
              style: context.textTheme.titleLarge?.copyWith(
                fontSize: FontSizeManager.large.sp * 1.4,
              ),
            ).withOnlyPadding(top: 100.sp),
            Text(
              "The best to do list application for you",
              style: context.textTheme.titleMedium,
            ).center().positionedBottom(bottom: 50.sp),
          ],
        ),
      ),
    );
  }
}
