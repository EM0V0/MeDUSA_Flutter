class AppConstants {
  // App Information
  static const String appName = 'MeDUSA';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'Professional medical data fusion and analysis system';

  // 最小字体大小常量 - 增强移动端可读性
  static const double minFontSize = 16.0; // 从14.0提升到16.0
  static const double minTitleFontSize = 18.0; // 从16.0提升到18.0
  static const double minBodyFontSize = 16.0; // 从14.0提升到16.0
  static const double minCaptionFontSize = 14.0; // 从12.0提升到14.0

  // 移动端专用字体大小 - 进一步减小以提升美观性
  static const double mobileMinFontSize = 14.0; // 从16.0减小到14.0
  static const double mobileMinTitleFontSize = 20.0; // 从22.0减小到20.0
  static const double mobileMinBodyFontSize = 14.0; // 从16.0减小到14.0
  static const double mobileMinCaptionFontSize = 12.0; // 从14.0减小到12.0

  // API Configuration
  static const String baseUrl = 'https://localhost:7001';
  static const String apiVersion = '/api/v1';

  // Storage Keys
  static const String tokenKey = 'auth_token';
  static const String userKey = 'user_data';
  static const String settingsKey = 'app_settings';
  static const String themeKey = 'theme_mode';
  static const String languageKey = 'language_code';
  static const String encryptionKeyKey = 'encryption_key';

  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);

  // Network Timeouts
  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);
  static const Duration sendTimeout = Duration(seconds: 15);

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // Chart Configuration
  static const int realtimeDataPoints = 100;
  static const int hourlyDataPoints = 360; // 6 hours * 60 minutes
  static const int dailyDataPoints = 144; // 6 days * 24 hours
  static const int weeklyDataPoints = 42; // 6 weeks * 7 days

  // Sensor Data Thresholds
  static const double lowTremorThreshold = 40.0;
  static const double mediumTremorThreshold = 70.0;
  static const double highTremorThreshold = 100.0;

  // Refresh Intervals
  static const Duration realtimeRefreshInterval = Duration(seconds: 3);
  static const Duration normalRefreshInterval = Duration(seconds: 30);
  static const Duration backgroundRefreshInterval = Duration(minutes: 5);

  // Security Configuration
  static const int passwordMinLength = 8;
  static const int maxLoginAttempts = 5;
  static const Duration lockoutDuration = Duration(minutes: 15);

  // UI Constants
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double defaultBorderRadius = 8.0;
  static const double cardElevation = 2.0;

  // Icon Size Constants - 确保图标不会过小
  static const double minIconSize = 18.0; // 最小图标大小
  static const double mobileMinIconSize = 20.0; // 移动端最小图标大小
  static const double defaultIconSize = 20.0; // 默认图标大小
  static const double largeIconSize = 28.0; // 大图标大小

  // Border Radius
  static const double defaultRadius = 8.0;
  static const double smallRadius = 4.0;
  static const double largeRadius = 12.0;

  // Responsive Breakpoints
  static const double mobileBreakpoint = 480.0;
  static const double tabletBreakpoint = 800.0;
  static const double desktopBreakpoint = 1200.0;
  static const double largeDesktopBreakpoint = 1600.0;

  // Error Messages
  static const String networkErrorMessage = 'Network connection error. Please check your internet connection.';
  static const String serverErrorMessage = 'Server error occurred. Please try again later.';
  static const String unauthorizedErrorMessage = 'Session expired. Please login again.';
  static const String generalErrorMessage = 'An unexpected error occurred. Please try again.';
}
