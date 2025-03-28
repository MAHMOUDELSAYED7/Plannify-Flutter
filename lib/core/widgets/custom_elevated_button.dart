import 'package:flutter/material.dart';
import 'package:plannify/core/utils/extensions/extensions.dart';

class MyElevatedButton extends StatelessWidget {
  const MyElevatedButton({
    super.key,
    required this.title,
    this.iconData,
    this.onPressed,
  });
  final String title;
  final String? iconData;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: context.elevatedButtonTheme.style,
      child: Text(title),
    );
  }
}
