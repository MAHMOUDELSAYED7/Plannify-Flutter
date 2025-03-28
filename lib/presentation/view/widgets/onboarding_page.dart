import 'package:flutter/material.dart';
import 'package:plannify/core/utils/extensions/extensions.dart';

import '../../../core/constants/font_size.dart';
import '../../../core/themes/colors.dart';
import '../../../core/utils/helpers/image_handler.dart';
import '../../../core/widgets/custom_gap.dart';
import '../../../data/models/onboarding_page_model.dart';

class OnboardingPageWidget extends StatelessWidget {
  final OnboardingPage page;

  const OnboardingPageWidget({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Stack(
        children: [
          ImageHandler.image(
            page.image,
            fit: BoxFit.cover,
            height: context.height * 0.5,
          ).center().positionedTop(top: context.height * 0.1),
          Column(
            children: [
              Text(
                page.title,
                style: context.textTheme.bodyLarge?.copyWith(
                  fontSize: FontSizeManager.large * 1.3,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const Gap(size: 15),
              Text(
                page.description,
                style: context.textTheme.bodyMedium?.copyWith(
                  fontSize: FontSizeManager.medium * 0.85,
                  color: ColorManager.grayDark,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ).positionedTop(top: context.height * 0.49),
        ],
      ),
    );
  }
}
