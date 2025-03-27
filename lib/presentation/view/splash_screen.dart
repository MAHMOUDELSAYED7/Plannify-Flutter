import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plannify/core/constants/font_size.dart';
import 'package:plannify/core/constants/images.dart';
import 'package:plannify/core/locator/locator.dart';
import 'package:plannify/core/utils/extensions/extensions.dart';
import 'package:plannify/core/utils/helpers/image_handler.dart';
import 'package:plannify/presentation/viewmodel/splash_viewmodel.dart';

import '../../core/themes/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    locator<SplashViewModel>().redirect(context);
    return Scaffold(
      backgroundColor: ColorManager.primary,

      body: Stack(
        alignment: Alignment.center,
        children: [
          ImageHandler.image(ImageManager.splashLogo).center(),
          Text(
            "Plannify",
            style: context.textTheme.titleLarge?.copyWith(
              fontSize: FontSizeManager.large * 1.4,
            ),
          ).withOnlyPadding(top: 100.sp),
          Text(
            "The best to do list application for you",
            style: context.textTheme.titleMedium,
          ).center().positionedBottom(bottom: 50.sp),
        ],
      ),
    );
  }
}
