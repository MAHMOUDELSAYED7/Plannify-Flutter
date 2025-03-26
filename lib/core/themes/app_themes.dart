import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plannify/core/constants/font_size.dart';

import 'colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: ColorManager.primary,
          foregroundColor: ColorManager.white,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(width: 2),
          ),
          foregroundColor: ColorManager.black,
        ),
      ),
      //-----------------------------------------------------------//* COLOR SCHEME
      colorScheme: ColorScheme.fromSeed(seedColor: ColorManager.primaryDark),

      iconTheme: const IconThemeData(color: ColorManager.black, size: 25),
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: ColorManager.backgroundLight,
      //-----------------------------------------------------------//* APP BAR
      appBarTheme: AppBarTheme(
        titleTextStyle: TextStyle(color: ColorManager.black, fontSize: 20.sp),
        backgroundColor: ColorManager.transparent,
        centerTitle: true,
        scrolledUnderElevation: 0,
        titleSpacing: 0,
        iconTheme: const IconThemeData(color: ColorManager.black),
        elevation: 0,
        shadowColor: ColorManager.shadowDark,
      ),

      //-----------------------------------------------------------//* TEXT
      textTheme: TextTheme(
        bodyLarge: TextStyle(
          fontSize: FontSizeManager.small,
          color: ColorManager.black,
          fontWeight: FontWeight.w600,
        ),
        bodyMedium: TextStyle(
          fontSize: FontSizeManager.medium,
          color: ColorManager.black,
          fontWeight: FontWeight.w300,
        ),
        bodySmall: TextStyle(
          fontSize: FontSizeManager.large,
          color: ColorManager.black,
          fontWeight: FontWeight.w400,
        ),
      ),

      //-----------------------------------------------------------//* TEXT SELECTION
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: ColorManager.primaryDark,
        selectionColor: ColorManager.primary.withValues(alpha: 0.3),
        selectionHandleColor: ColorManager.primaryDark,
      ),

      //--------------------------------------------------//* INPUT DECORATION Text Field
      inputDecorationTheme: InputDecorationTheme(
        // filled: false,
        // isDense: true,
        // fillColor: ColorManager.grey.withOpacity(0.12),
        contentPadding: EdgeInsets.only(
          left: 10,
          right: 10,
          top: 13.h,
          bottom: 13.h,
        ),
        hintStyle: const TextStyle(color: ColorManager.white),
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
      ),
    );
  }
}
