import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../constants/app_constants.dart';

/// 字体工具类 - 提供响应式和最小字体保护
class FontUtils {
  /// 获取移动端字体大小
  static double getMobileFontSize(double fontSize, BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).smallerThan(TABLET);
    if (isMobile) {
      return fontSize < AppConstants.mobileMinFontSize ? AppConstants.mobileMinFontSize : fontSize;
    }
    return fontSize;
  }

  /// 获取移动端标题字体大小
  static double getMobileTitleFontSize(double fontSize, BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).smallerThan(TABLET);
    if (isMobile) {
      return fontSize < AppConstants.mobileMinTitleFontSize ? AppConstants.mobileMinTitleFontSize : fontSize;
    }
    return fontSize;
  }

  /// 获取移动端正文字体大小
  static double getMobileBodyFontSize(double fontSize, BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).smallerThan(TABLET);
    if (isMobile) {
      return fontSize < AppConstants.mobileMinBodyFontSize ? AppConstants.mobileMinBodyFontSize : fontSize;
    }
    return fontSize;
  }

  /// 获取移动端说明文字字体大小
  static double getMobileCaptionFontSize(double fontSize, BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).smallerThan(TABLET);
    if (isMobile) {
      return fontSize < AppConstants.mobileMinCaptionFontSize ? AppConstants.mobileMinCaptionFontSize : fontSize;
    }
    return fontSize;
  }

  /// 强制应用最小字体大小
  static double forceMinFontSize(double fontSize) {
    return fontSize < AppConstants.minFontSize ? AppConstants.minFontSize : fontSize;
  }

  /// 强制应用最小标题字体大小
  static double forceMinTitleFontSize(double fontSize) {
    return fontSize < AppConstants.minTitleFontSize ? AppConstants.minTitleFontSize : fontSize;
  }

  /// 强制应用最小正文字体大小
  static double forceMinBodyFontSize(double fontSize) {
    return fontSize < AppConstants.minBodyFontSize ? AppConstants.minBodyFontSize : fontSize;
  }

  /// 全局强制字体大小控制
  static double globalForceFontSize(double fontSize) {
    return fontSize < AppConstants.mobileMinFontSize ? AppConstants.mobileMinFontSize : fontSize;
  }

  /// 全局强制标题字体大小控制
  static double globalForceTitleFontSize(double fontSize) {
    return fontSize < AppConstants.mobileMinTitleFontSize ? AppConstants.mobileMinTitleFontSize : fontSize;
  }

  /// 全局强制正文字体大小控制
  static double globalForceBodyFontSize(double fontSize) {
    return fontSize < AppConstants.mobileMinBodyFontSize ? AppConstants.mobileMinBodyFontSize : fontSize;
  }

  /// 创建响应式标题样式
  static TextStyle forceResponsiveTitleStyle({
    required double fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? height,
    required BuildContext context,
  }) {
    double finalFontSize = fontSize;
    finalFontSize = getMobileTitleFontSize(fontSize, context);
    finalFontSize = globalForceTitleFontSize(finalFontSize);

    return TextStyle(
      fontSize: finalFontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
    );
  }

  /// 创建响应式正文样式
  static TextStyle forceResponsiveBodyStyle({
    required double fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? height,
    required BuildContext context,
  }) {
    double finalFontSize = fontSize;
    finalFontSize = getMobileBodyFontSize(fontSize, context);
    finalFontSize = globalForceBodyFontSize(finalFontSize);

    return TextStyle(
      fontSize: finalFontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
    );
  }

  /// 创建响应式一般文字样式
  static TextStyle forceResponsiveTextStyle({
    required double fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? height,
    required BuildContext context,
  }) {
    double finalFontSize = fontSize;
    finalFontSize = getMobileFontSize(fontSize, context);
    finalFontSize = globalForceFontSize(finalFontSize);

    return TextStyle(
      fontSize: finalFontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
    );
  }

  /// 全局强制响应式标题样式
  static TextStyle globalForceResponsiveTitleStyle({
    required double fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? height,
    BuildContext? context,
  }) {
    double finalFontSize = fontSize;
    if (context != null) {
      finalFontSize = getMobileTitleFontSize(fontSize, context);
    }
    finalFontSize = globalForceTitleFontSize(finalFontSize);

    return TextStyle(
      fontSize: finalFontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
    );
  }

  /// 全局强制响应式正文样式
  static TextStyle globalForceResponsiveBodyStyle({
    required double fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? height,
    BuildContext? context,
  }) {
    double finalFontSize = fontSize;
    if (context != null) {
      finalFontSize = getMobileBodyFontSize(fontSize, context);
    }
    finalFontSize = globalForceBodyFontSize(finalFontSize);

    return TextStyle(
      fontSize: finalFontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
    );
  }

  /// 全局强制响应式一般文字样式
  static TextStyle globalForceResponsiveTextStyle({
    required double fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? height,
    BuildContext? context,
  }) {
    double finalFontSize = fontSize;
    if (context != null) {
      finalFontSize = getMobileFontSize(fontSize, context);
    }
    finalFontSize = globalForceFontSize(finalFontSize);

    return TextStyle(
      fontSize: finalFontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
    );
  }

  /// 便捷方法：创建受保护的标题文字
  static Widget protectedTitle(
    String text, {
    required double fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? height,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    required BuildContext context,
  }) {
    return Text(
      text,
      style: globalForceResponsiveTitleStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: height,
        context: context,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  /// 便捷方法：创建受保护的正文文字
  static Widget protectedBody(
    String text, {
    required double fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? height,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    required BuildContext context,
  }) {
    return Text(
      text,
      style: globalForceResponsiveBodyStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: height,
        context: context,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  /// 便捷方法：创建受保护的按钮文字
  static Widget protectedButton(
    String text, {
    required BuildContext context,
    double fontSize = 14.0,
    FontWeight? fontWeight,
    Color? color,
  }) {
    return Text(
      text,
      style: globalForceResponsiveBodyStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        context: context,
      ),
    );
  }

  /// 便捷方法：创建受保护的SnackBar
  static SnackBar protectedSnackBar(
    String message, {
    required BuildContext context,
    double fontSize = 14.0,
  }) {
    return SnackBar(
      content: protectedBody(
        message,
        fontSize: fontSize,
        context: context,
      ),
    );
  }

  /// 便捷方法：创建受保护的对话框标题
  static Widget protectedDialogTitle(
    String title, {
    required BuildContext context,
    double fontSize = 18.0,
  }) {
    return protectedTitle(
      title,
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
      context: context,
    );
  }

  /// 便捷方法：创建受保护的对话框内容
  static Widget protectedDialogContent(
    String content, {
    required BuildContext context,
    double fontSize = 14.0,
  }) {
    return protectedBody(
      content,
      fontSize: fontSize,
      context: context,
    );
  }
}
