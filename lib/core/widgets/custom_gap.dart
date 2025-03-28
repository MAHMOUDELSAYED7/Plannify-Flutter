import 'package:flutter/material.dart';

class Gap extends StatelessWidget {
  final double size;
  final Axis axis;

  const Gap({super.key, this.size = 8.0, this.axis = Axis.vertical});

  @override
  Widget build(BuildContext context) {
    return axis == Axis.vertical
        ? SizedBox(height: size)
        : SizedBox(width: size);
  }
}
