import 'package:flutter/material.dart';

import '../constants/app_constants.dart';

/// Font utility class - Responsive font management
class FontUtils {
  // ===== Breakpoint Checks =====
  
  /// Check if current screen is mobile
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < AppConstants.breakpointMobile;
  }
  
  /// Check if current screen is tablet
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= AppConstants.breakpointMobile && width < AppConstants.breakpointTablet;
  }
  
  /// Check if current screen is desktop
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= AppConstants.breakpointTablet;
  }

  // ===== Font Size Calculation =====
  
  /// Get responsive font size based on screen type
  static double getFontSize(BuildContext context, {
    required double mobileSize,
    required double tabletSize,
    required double desktopSize,
  }) {
    if (isMobile(context)) return mobileSize;
    if (isTablet(context)) return tabletSize;
    return desktopSize;
  }
  
  /// Get responsive title font size
  static double getResponsiveTitleFontSize(BuildContext context) {
    return getFontSize(
      context,
      mobileSize: AppConstants.mobileTitleFontSize,
      tabletSize: AppConstants.tabletTitleFontSize,
      desktopSize: AppConstants.desktopTitleFontSize,
    );
  }
  
  /// Get responsive subtitle font size
  static double getResponsiveSubtitleFontSize(BuildContext context) {
    return getResponsiveTitleFontSize(context) * 0.8;
  }
  
  /// Get responsive body font size
  static double getResponsiveBodyFontSize(BuildContext context) {
    return getFontSize(
      context,
      mobileSize: AppConstants.mobileBodyFontSize,
      tabletSize: AppConstants.tabletBodyFontSize,
      desktopSize: AppConstants.desktopBodyFontSize,
    );
  }
  
  /// Get responsive caption font size
  static double getResponsiveCaptionFontSize(BuildContext context) {
    return getFontSize(
      context,
      mobileSize: AppConstants.mobileCaptionFontSize,
      tabletSize: AppConstants.tabletCaptionFontSize,
      desktopSize: AppConstants.desktopCaptionFontSize,
    );
  }
  
  /// Get responsive button font size
  static double getResponsiveButtonFontSize(BuildContext context) {
    return getResponsiveBodyFontSize(context);
  }

  // ===== Text Style Creation =====
  
  /// Create responsive title text style
  static TextStyle responsiveTitleStyle({
    required BuildContext context,
    Color? color,
    FontWeight? fontWeight,
  }) {
    return TextStyle(
      fontSize: getResponsiveTitleFontSize(context),
      fontWeight: fontWeight ?? FontWeight.w600,
      color: color,
    );
  }
  
  /// Create responsive subtitle text style
  static TextStyle responsiveSubtitleStyle({
    required BuildContext context,
    Color? color,
    FontWeight? fontWeight,
  }) {
    return TextStyle(
      fontSize: getResponsiveSubtitleFontSize(context),
      fontWeight: fontWeight ?? FontWeight.w500,
      color: color,
    );
  }
  
  /// Create responsive body text style
  static TextStyle responsiveBodyStyle({
    required BuildContext context,
    Color? color,
    FontWeight? fontWeight,
  }) {
    return TextStyle(
      fontSize: getResponsiveBodyFontSize(context),
      fontWeight: fontWeight ?? FontWeight.w400,
      color: color,
    );
  }
  
  /// Create responsive caption text style
  static TextStyle responsiveCaptionStyle({
    required BuildContext context,
    Color? color,
    FontWeight? fontWeight,
  }) {
    return TextStyle(
      fontSize: getResponsiveCaptionFontSize(context),
      fontWeight: fontWeight ?? FontWeight.w400,
      color: color,
    );
  }
  
  /// Create responsive button text style
  static TextStyle responsiveButtonStyle({
    required BuildContext context,
    Color? color,
    FontWeight? fontWeight,
  }) {
    return TextStyle(
      fontSize: getResponsiveButtonFontSize(context),
      fontWeight: fontWeight ?? FontWeight.w500,
      color: color,
    );
  }

  // ===== Style Method Shortcuts (for backward compatibility) =====
  
  /// Title style method
  static TextStyle title({
    required BuildContext context,
    Color? color,
    FontWeight? fontWeight,
  }) {
    return responsiveTitleStyle(
      context: context,
      color: color,
      fontWeight: fontWeight,
    );
  }
  
  /// Body style method
  static TextStyle body({
    required BuildContext context,
    Color? color,
    FontWeight? fontWeight,
  }) {
    return responsiveBodyStyle(
      context: context,
      color: color,
      fontWeight: fontWeight,
    );
  }
  
  /// Caption style method
  static TextStyle caption({
    required BuildContext context,
    Color? color,
    FontWeight? fontWeight,
  }) {
    return responsiveCaptionStyle(
      context: context,
      color: color,
      fontWeight: fontWeight,
    );
  }
  
  /// Subtitle style method
  static TextStyle subtitle({
    required BuildContext context,
    Color? color,
    FontWeight? fontWeight,
  }) {
    return responsiveSubtitleStyle(
      context: context,
      color: color,
      fontWeight: fontWeight,
    );
  }

  // ===== Widget Creation Methods =====
  
  /// Create responsive title text widget
  static Widget titleText(String text, BuildContext context, {
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    FontWeight? fontWeight,
  }) {
    return Text(
      text,
      style: title(
        context: context,
        color: color,
        fontWeight: fontWeight,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
    );
  }
  
  /// Create responsive body text widget
  static Widget bodyText(String text, BuildContext context, {
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    FontWeight? fontWeight,
  }) {
    return Text(
      text,
      style: body(
        context: context,
        color: color,
        fontWeight: fontWeight,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
    );
  }
  
  /// Create responsive caption text widget
  static Widget captionText(String text, BuildContext context, {
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    FontWeight? fontWeight,
  }) {
    return Text(
      text,
      style: caption(
        context: context,
        color: color,
        fontWeight: fontWeight,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
    );
  }
}