import 'package:flutter/material.dart';

class ColorManager {
  const ColorManager._();

  // Primary Colors
  static const Color primary = Color(0xFF24A19C); // Teal
  static const Color primaryLight = Color(0xFFCBF1F0); // Light teal
  static const Color primaryDark = Color(0xFF1B8A86); // Darker teal (derived)

  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF1B1C1F);
  static const Color grayDark = Color(0xFF767E8C);
  static const Color grayMedium = Color(0xFFA9B0C5);
  static const Color grayLight = Color(0xFFE0E5ED);

  // Accent Colors
  static const Color accentPink = Color(0xFFFF486A);
  static const Color accentRed = Color(0xFFEA4335);
  static const Color accentBlue = Color(0xFF1877F2);

  // Semantic Colors
  static const Color success = primary;
  static const Color error = accentRed;
  static const Color warning = Color(0xFFFFA000);
  static const Color info = accentBlue;

  // Background Colors
  static const Color backgroundLight = white;
  static const Color backgroundDark = black;

  // Text Colors
  static const Color textPrimary = black;
  static const Color textSecondary = grayDark;
  static const Color textDisabled = grayMedium;
  static const Color textInverted = white;

  // Component Colors
  static const Color divider = grayLight;
  static const Color border = grayLight;
}
