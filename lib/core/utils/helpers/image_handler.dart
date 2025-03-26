import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../themes/colors.dart';

class ImageHandler {
  const ImageHandler._();

  static Image png(
    String path, {
    double? width,
    double? height,
    double? size,
    Color? color,
    BoxFit fit = BoxFit.contain,
  }) {
    return Image.asset(
      path,
      width: size ?? width,
      height: size ?? height,
      fit: fit,
      color: color,
    );
  }

  static SvgPicture svg(
    String path, {
    double? width,
    double? height,
    double? size,
    Color? color,
    BoxFit fit = BoxFit.contain,
  }) {
    return SvgPicture.asset(
      path,
      width: size ?? width,
      height: size ?? height,
      fit: fit,
      colorFilter: ColorFilter.mode(
        color ?? ColorManager.black,
        BlendMode.srcIn,
      ),
    );
  }
}
