import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plannify/core/constants/font_family.dart';
import 'package:plannify/core/constants/font_size.dart';

import 'colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: TextStyle(
            fontSize: FontSizeManager.medium + 2.sp,
            fontFamily: FontFamilyManager.sfProDisplay,
          ),
          fixedSize: Size(double.maxFinite, 54.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
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

      fontFamily: FontFamilyManager.sfProDisplay,
      //-----------------------------------------------------------//* APP BAR
      appBarTheme: AppBarTheme(
        titleTextStyle: TextStyle(
          color: ColorManager.black,
          fontSize: 20.sp,
          fontFamily: FontFamilyManager.sfProDisplay,
        ),
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
          fontSize: FontSizeManager.large,
          color: ColorManager.black,
          fontWeight: FontWeight.w600,
        ),
        bodyMedium: TextStyle(
          fontSize: FontSizeManager.medium,
          color: ColorManager.black,
          fontWeight: FontWeight.w500,
        ),
        bodySmall: TextStyle(
          fontSize: FontSizeManager.small,
          color: ColorManager.black,
        ),
        titleLarge: TextStyle(
          fontSize: FontSizeManager.large,
          color: ColorManager.white,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: TextStyle(
          fontSize: FontSizeManager.medium,
          color: ColorManager.white,
          fontWeight: FontWeight.w500,
        ),
        titleSmall: TextStyle(
          fontSize: FontSizeManager.small,
          color: ColorManager.white,
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
        filled: false,
        isDense: true,
        fillColor: ColorManager.grayLight,
        contentPadding: EdgeInsets.only(
          left: 10,
          right: 10,
          top: 14.3.h,
          bottom: 14.3.h,
        ),
        hintStyle: const TextStyle(color: ColorManager.grayMedium),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(color: ColorManager.error),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(color: ColorManager.error),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(color: ColorManager.grayMedium),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(
            color: ColorManager.grayMedium,
            width: 2,
          ),
        ),
      ),
    );
  }
}
