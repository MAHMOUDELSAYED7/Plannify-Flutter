import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plannify/core/themes/colors.dart';
import 'package:plannify/core/utils/extensions/extensions.dart';

class MyElevatedButton extends StatelessWidget {
  const MyElevatedButton({
    super.key,
    required this.title,
    this.iconData,
    this.onPressed,
    this.isLoading = false,
  });
  final String title;
  final String? iconData;
  final bool isLoading;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: context.elevatedButtonTheme.style,
      child:
          isLoading
              ? CircularProgressIndicator(
                strokeCap: StrokeCap.round,
                backgroundColor: ColorManager.primary.withValues(alpha: 0.2),
              ).withSquareSize(25.w)
              : Text(title),
    );
  }
}
