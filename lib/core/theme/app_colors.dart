import 'package:flutter/material.dart';

/// 应用颜色配置 - 专为医疗应用设计的专业配色方案
class AppColors {
  // 主色调 - 医疗蓝
  static const Color primary = Color(0xFF1976D2); // 专业医疗蓝
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFFD3E3FD);
  static const Color onPrimaryContainer = Color(0xFF001C38);

  // 次要色调 - 科技绿
  static const Color secondary = Color(0xFF2E7D57); // 健康绿
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFFB8F2D1);
  static const Color onSecondaryContainer = Color(0xFF002114);

  // 第三色调 - 警告橙
  static const Color tertiary = Color(0xFFFF8F00); // 监控警告色
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color tertiaryContainer = Color(0xFFFFE0B2);
  static const Color onTertiaryContainer = Color(0xFF2D1600);

  // 错误色 - 医疗红
  static const Color error = Color(0xFFD32F2F); // 紧急/危险红
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onErrorContainer = Color(0xFF410002);

  // 警告色
  static const Color warning = Color(0xFFF57C00); // 警告橙
  static const Color onWarning = Color(0xFFFFFFFF);
  static const Color warningContainer = Color(0xFFFFE0B2);
  static const Color onWarningContainer = Color(0xFF2D1600);

  // 成功色
  static const Color success = Color(0xFF388E3C); // 成功绿
  static const Color onSuccess = Color(0xFFFFFFFF);
  static const Color successContainer = Color(0xFFC8E6C9);
  static const Color onSuccessContainer = Color(0xFF1B5E20);

  // 信息色
  static const Color info = Color(0xFF0288D1); // 信息蓝
  static const Color onInfo = Color(0xFFFFFFFF);
  static const Color infoContainer = Color(0xFFB3E5FC);
  static const Color onInfoContainer = Color(0xFF01579B);

  // 浅色主题表面颜色 - 优化为更明亮的配色
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightOnSurface = Color(0xFF2D3748);
  static const Color lightOnSurfaceVariant = Color(0xFF4A5568);
  static const Color lightBackground = Color(0xFFF8FAFC);
  static const Color lightOnBackground = Color(0xFF2D3748);
  static const Color lightSurfaceVariant = Color(0xFFE7E0EC);
  static const Color lightInverseSurface = Color(0xFF313033);
  static const Color lightInverseOnSurface = Color(0xFFF4EFF4);
  static const Color lightInversePrimary = Color(0xFFBAC3FF);
  static const Color lightShadow = Color(0xFF000000);
  static const Color lightScrim = Color(0xFF000000);
  static const Color lightOutline = Color(0xFF79747E);
  static const Color lightOutlineVariant = Color(0xFFCAC4D0);
  static const Color lightDivider = Color(0xFFE0E0E0);

  // 深色主题表面颜色
  static const Color darkSurface = Color(0xFF141218);
  static const Color darkOnSurface = Color(0xFFE6E1E5);
  static const Color darkOnSurfaceVariant = Color(0xFFCAC4D0);
  static const Color darkBackground = Color(0xFF101014);
  static const Color darkOnBackground = Color(0xFFE6E1E5);
  static const Color darkSurfaceVariant = Color(0xFF49454F);
  static const Color darkInverseSurface = Color(0xFFE6E1E5);
  static const Color darkInverseOnSurface = Color(0xFF313033);
  static const Color darkInversePrimary = Color(0xFF1976D2);
  static const Color darkShadow = Color(0xFF000000);
  static const Color darkScrim = Color(0xFF000000);
  static const Color darkOutline = Color(0xFF938F99);
  static const Color darkOutlineVariant = Color(0xFF49454F);
  static const Color darkDivider = Color(0xFF2C2C2C);

  // 通用系统颜色
  static const Color outline = Color(0xFF79747E);
  static const Color shadow = Color(0xFF000000);
  static const Color surfaceTint = primary;
  static const Color inverseSurface = Color(0xFF313033);
  static const Color inverseOnSurface = Color(0xFFF4EFF4);
  static const Color inversePrimary = Color(0xFFBAC3FF);
  static const Color onSurfaceVariant = Color(0xFF49454F);

  // 医疗数据可视化专用颜色
  static const List<Color> chartColors = [
    Color(0xFF1976D2), // 主蓝色
    Color(0xFF2E7D57), // 绿色
    Color(0xFFFF8F00), // 橙色
    Color(0xFF7B1FA2), // 紫色
    Color(0xFFD32F2F), // 红色
    Color(0xFF388E3C), // 深绿
    Color(0xFF1976D2), // 深蓝
    Color(0xFF795548), // 棕色
  ];

  // 震颤等级颜色
  static const Color lowTremor = Color(0xFF4CAF50); // 低等级 - 绿色
  static const Color mediumTremor = Color(0xFFFF9800); // 中等级 - 橙色
  static const Color highTremor = Color(0xFFF44336); // 高等级 - 红色
  static const Color criticalTremor = Color(0xFF9C27B0); // 危险等级 - 紫色

  // 患者状态颜色
  static const Color stablePatient = Color(0xFF4CAF50); // 稳定 - 绿色
  static const Color monitoringPatient = Color(0xFF2196F3); // 监控中 - 蓝色
  static const Color warningPatient = Color(0xFFFF9800); // 警告 - 橙色
  static const Color criticalPatient = Color(0xFFF44336); // 危急 - 红色
  static const Color inactivePatient = Color(0xFF9E9E9E); // 不活跃 - 灰色

  // 数据质量指示器颜色
  static const Color excellentData = Color(0xFF4CAF50); // 优秀数据质量
  static const Color goodData = Color(0xFF8BC34A); // 良好数据质量
  static const Color fairData = Color(0xFFFF9800); // 一般数据质量
  static const Color poorData = Color(0xFFF44336); // 差数据质量
  static const Color noData = Color(0xFF9E9E9E); // 无数据

  // 渐变色组合
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF1976D2), Color(0xFF1565C0)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient successGradient = LinearGradient(
    colors: [Color(0xFF4CAF50), Color(0xFF388E3C)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient warningGradient = LinearGradient(
    colors: [Color(0xFFFF9800), Color(0xFFF57C00)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient errorGradient = LinearGradient(
    colors: [Color(0xFFF44336), Color(0xFFD32F2F)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // 背景渐变
  static const LinearGradient lightBackgroundGradient = LinearGradient(
    colors: [Color(0xFFFFFBFE), Color(0xFFF5F5F5)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient darkBackgroundGradient = LinearGradient(
    colors: [Color(0xFF101014), Color(0xFF1A1A1A)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // 透明度变体
  static Color get primaryWithOpacity => primary.withOpacity(0.12);
  static Color get secondaryWithOpacity => secondary.withOpacity(0.12);
  static Color get errorWithOpacity => error.withOpacity(0.12);
  static Color get warningWithOpacity => warning.withOpacity(0.12);
  static Color get successWithOpacity => success.withOpacity(0.12);

  // 医疗等级颜色映射
  static Color getTremorLevelColor(double tremorLevel) {
    if (tremorLevel < 40) return lowTremor;
    if (tremorLevel < 70) return mediumTremor;
    if (tremorLevel < 90) return highTremor;
    return criticalTremor;
  }

  // 患者状态颜色映射
  static Color getPatientStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'stable':
        return stablePatient;
      case 'monitoring':
        return monitoringPatient;
      case 'warning':
        return warningPatient;
      case 'critical':
        return criticalPatient;
      case 'inactive':
        return inactivePatient;
      default:
        return monitoringPatient;
    }
  }

  // 数据质量颜色映射
  static Color getDataQualityColor(double quality) {
    if (quality >= 0.9) return excellentData;
    if (quality >= 0.7) return goodData;
    if (quality >= 0.5) return fairData;
    if (quality > 0) return poorData;
    return noData;
  }
}
