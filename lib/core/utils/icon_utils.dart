import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../constants/app_constants.dart';

/// 图标工具类 - 提供响应式和最小图标保护
class IconUtils {
  /// 确保图标大小不小于最小值
  static double ensureMinIconSize(double iconSize) {
    return iconSize < AppConstants.minIconSize ? AppConstants.minIconSize : iconSize;
  }

  /// 移动端图标大小控制
  static double getMobileIconSize(double iconSize, BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).smallerThan(TABLET);
    if (isMobile) {
      return iconSize < AppConstants.mobileMinIconSize ? AppConstants.mobileMinIconSize : iconSize;
    }
    return ensureMinIconSize(iconSize);
  }

  /// 全局强制图标大小控制
  static double globalForceIconSize(double iconSize) {
    return iconSize < AppConstants.mobileMinIconSize ? AppConstants.mobileMinIconSize : iconSize;
  }

  /// 创建响应式图标大小
  static double responsiveIconSize(double iconSize, BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).smallerThan(TABLET);
    double finalIconSize = iconSize;

    if (isMobile) {
      finalIconSize = getMobileIconSize(iconSize, context);
    } else {
      finalIconSize = ensureMinIconSize(iconSize);
    }

    return globalForceIconSize(finalIconSize);
  }

  /// 便捷方法：创建受保护的Icon组件
  static Widget protectedIcon(
    IconData icon, {
    required double size,
    Color? color,
    required BuildContext context,
  }) {
    return Icon(
      icon,
      size: responsiveIconSize(size, context),
      color: color,
    );
  }

  /// 便捷方法：创建受保护的小图标
  static Widget protectedSmallIcon(
    IconData icon, {
    Color? color,
    required BuildContext context,
  }) {
    return protectedIcon(
      icon,
      size: 16.w,
      color: color,
      context: context,
    );
  }

  /// 便捷方法：创建受保护的中等图标
  static Widget protectedMediumIcon(
    IconData icon, {
    Color? color,
    required BuildContext context,
  }) {
    return protectedIcon(
      icon,
      size: 24.w,
      color: color,
      context: context,
    );
  }

  /// 便捷方法：创建受保护的大图标
  static Widget protectedLargeIcon(
    IconData icon, {
    Color? color,
    required BuildContext context,
  }) {
    return protectedIcon(
      icon,
      size: 32.w,
      color: color,
      context: context,
    );
  }

  /// 便捷方法：创建受保护的超大图标
  static Widget protectedExtraLargeIcon(
    IconData icon, {
    Color? color,
    required BuildContext context,
  }) {
    return protectedIcon(
      icon,
      size: 48.w,
      color: color,
      context: context,
    );
  }

  /// 便捷方法：创建受保护的按钮图标
  static Widget protectedButtonIcon(
    IconData icon, {
    Color? color,
    required BuildContext context,
  }) {
    return protectedIcon(
      icon,
      size: 20.w,
      color: color,
      context: context,
    );
  }

  /// 便捷方法：创建受保护的导航图标
  static Widget protectedNavigationIcon(
    IconData icon, {
    Color? color,
    required BuildContext context,
  }) {
    return protectedIcon(
      icon,
      size: 24.w,
      color: color,
      context: context,
    );
  }

  /// 便捷方法：创建受保护的操作图标
  static Widget protectedActionIcon(
    IconData icon, {
    Color? color,
    required BuildContext context,
  }) {
    return protectedIcon(
      icon,
      size: 20.w,
      color: color,
      context: context,
    );
  }

  /// 便捷方法：创建受保护的状态图标
  static Widget protectedStatusIcon(
    IconData icon, {
    Color? color,
    required BuildContext context,
  }) {
    return protectedIcon(
      icon,
      size: 16.w,
      color: color,
      context: context,
    );
  }

  /// 便捷方法：创建受保护的菜单图标
  static Widget protectedMenuIcon(
    IconData icon, {
    Color? color,
    required BuildContext context,
  }) {
    return protectedIcon(
      icon,
      size: 20.w,
      color: color,
      context: context,
    );
  }

  /// 便捷方法：创建受保护的卡片图标
  static Widget protectedCardIcon(
    IconData icon, {
    Color? color,
    required BuildContext context,
  }) {
    return protectedIcon(
      icon,
      size: 24.w,
      color: color,
      context: context,
    );
  }

  /// 便捷方法：创建受保护的统计图标
  static Widget protectedStatIcon(
    IconData icon, {
    Color? color,
    required BuildContext context,
  }) {
    return protectedIcon(
      icon,
      size: 32.w,
      color: color,
      context: context,
    );
  }

  /// 便捷方法：创建受保护的空状态图标
  static Widget protectedEmptyStateIcon(
    IconData icon, {
    Color? color,
    required BuildContext context,
  }) {
    return protectedIcon(
      icon,
      size: 80.w,
      color: color,
      context: context,
    );
  }

  /// 便捷方法：创建受保护的输入框图标
  static Widget protectedInputIcon(
    IconData icon, {
    Color? color,
    required BuildContext context,
  }) {
    return protectedIcon(
      icon,
      size: 24.w,
      color: color,
      context: context,
    );
  }

  /// 便捷方法：创建受保护的可见性图标
  static Widget protectedVisibilityIcon(
    IconData icon, {
    Color? color,
    required BuildContext context,
  }) {
    return protectedIcon(
      icon,
      size: 20.w,
      color: color,
      context: context,
    );
  }
}
