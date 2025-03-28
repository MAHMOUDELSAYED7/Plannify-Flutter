import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plannify/core/themes/colors.dart';
import 'package:plannify/core/utils/extensions/extensions.dart';

class MyTextButton extends StatelessWidget {
  const MyTextButton({super.key, this.onTap, required this.title});
  final void Function()? onTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: ColorManager.primary.withValues(alpha: 0.2),
      overlayColor: WidgetStatePropertyAll(
        ColorManager.primary.withValues(alpha: 0.2),
      ),
      radius: 30,
      borderRadius: BorderRadius.circular(8.r),
      child: Text(
        title,
        style: context.textTheme.bodyMedium?.copyWith(
          color: ColorManager.primary,
        ),
      ).withSymmetricPadding(horizontal: 12, vertical: 4),
    );
  }
}
