import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_constants.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.primary,
        onPrimary: AppColors.onPrimary,
        primaryContainer: AppColors.primaryContainer,
        onPrimaryContainer: AppColors.onPrimaryContainer,
        secondary: AppColors.secondary,
        onSecondary: AppColors.onSecondary,
        secondaryContainer: AppColors.secondaryContainer,
        onSecondaryContainer: AppColors.onSecondaryContainer,
        tertiary: AppColors.tertiary,
        onTertiary: AppColors.onTertiary,
        tertiaryContainer: AppColors.tertiaryContainer,
        onTertiaryContainer: AppColors.onTertiaryContainer,
        error: AppColors.error,
        onError: AppColors.onError,
        errorContainer: AppColors.errorContainer,
        onErrorContainer: AppColors.onErrorContainer,
        surface: AppColors.lightSurface,
        onSurface: AppColors.lightOnSurface,
        surfaceContainerHighest: AppColors.lightSurfaceVariant,
        onSurfaceVariant: AppColors.lightOnSurfaceVariant,
        outline: AppColors.lightOutline,
        outlineVariant: AppColors.lightOutlineVariant,
        shadow: AppColors.lightShadow,
        scrim: AppColors.lightScrim,
        inverseSurface: AppColors.lightInverseSurface,
        onInverseSurface: AppColors.lightInverseOnSurface,
        inversePrimary: AppColors.lightInversePrimary,
        surfaceTint: AppColors.surfaceTint,
      ),
      scaffoldBackgroundColor: AppColors.lightBackground,

      // 全局字体大小控制
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: AppConstants.minTitleFontSize,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: TextStyle(
          fontSize: AppConstants.minTitleFontSize,
          fontWeight: FontWeight.bold,
        ),
        displaySmall: TextStyle(
          fontSize: AppConstants.minTitleFontSize,
          fontWeight: FontWeight.w600,
        ),
        headlineLarge: TextStyle(
          fontSize: AppConstants.minTitleFontSize,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          fontSize: AppConstants.minTitleFontSize,
          fontWeight: FontWeight.w600,
        ),
        headlineSmall: TextStyle(
          fontSize: AppConstants.minTitleFontSize,
          fontWeight: FontWeight.w600,
        ),
        titleLarge: TextStyle(
          fontSize: AppConstants.minBodyFontSize,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: TextStyle(
          fontSize: AppConstants.minBodyFontSize,
          fontWeight: FontWeight.w500,
        ),
        titleSmall: TextStyle(
          fontSize: AppConstants.minBodyFontSize,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: TextStyle(
          fontSize: AppConstants.minBodyFontSize,
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: TextStyle(
          fontSize: AppConstants.minBodyFontSize,
          fontWeight: FontWeight.w400,
        ),
        bodySmall: TextStyle(
          fontSize: AppConstants.minCaptionFontSize,
          fontWeight: FontWeight.w400,
        ),
        labelLarge: TextStyle(
          fontSize: AppConstants.minBodyFontSize,
          fontWeight: FontWeight.w500,
        ),
        labelMedium: TextStyle(
          fontSize: AppConstants.minCaptionFontSize,
          fontWeight: FontWeight.w500,
        ),
        labelSmall: TextStyle(
          fontSize: AppConstants.minCaptionFontSize,
          fontWeight: FontWeight.w400,
        ),
      ),

      // 组件主题
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontSize: AppConstants.minTitleFontSize,
          fontWeight: FontWeight.bold,
          color: AppColors.onPrimary,
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          elevation: 2,
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          textStyle: TextStyle(
            fontSize: AppConstants.minBodyFontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: BorderSide(color: AppColors.primary),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          textStyle: TextStyle(
            fontSize: AppConstants.minBodyFontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          textStyle: TextStyle(
            fontSize: AppConstants.minBodyFontSize,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.lightSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AppColors.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AppColors.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AppColors.error),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        labelStyle: TextStyle(
          fontSize: AppConstants.minBodyFontSize,
          color: AppColors.onSurfaceVariant,
        ),
        hintStyle: TextStyle(
          fontSize: AppConstants.minBodyFontSize,
          color: AppColors.onSurfaceVariant,
        ),
      ),

      cardTheme: CardThemeData(
        color: AppColors.lightSurface,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.lightSurface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.onSurfaceVariant,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(
          fontSize: AppConstants.minCaptionFontSize,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: AppConstants.minCaptionFontSize,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
