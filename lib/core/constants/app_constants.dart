class AppConstants {
  // App Information
  static const String appName = 'MeDUSA';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'Professional medical data fusion and analysis system';

  // ===== Font system refactoring =====
  // Base font size (desktop first)
  static const double _baseFontSize = 16.0;
  
  // Font ratio system
  static const double _titleRatio = 1.5;      // Title font ratio
  static const double _subtitleRatio = 1.25;  // Subtitle font ratio
  static const double _bodyRatio = 1.0;       // Body font ratio
  static const double _captionRatio = 0.875;  // Caption font ratio
  static const double _buttonRatio = 0.9375;  // Button font ratio
  
  // Desktop font sizes (primary sizes)
  static const double desktopTitleFontSize = _baseFontSize * _titleRatio;      // 24.0
  static const double desktopSubtitleFontSize = _baseFontSize * _subtitleRatio; // 20.0
  static const double desktopBodyFontSize = _baseFontSize * _bodyRatio;         // 16.0
  static const double desktopCaptionFontSize = _baseFontSize * _captionRatio;   // 14.0
  static const double desktopButtonFontSize = _baseFontSize * _buttonRatio;     // 15.0
  
  // Mobile font sizes (secondary sizes, scaled from desktop)
  static const double _mobileScaleFactor = 0.8; // Mobile scale factor - adjusted from 0.875 to 0.8, reduce font size
  static const double mobileTitleFontSize = desktopTitleFontSize * _mobileScaleFactor;      // 19.2 (24.0 * 0.8)
  static const double mobileSubtitleFontSize = desktopSubtitleFontSize * _mobileScaleFactor; // 16.0 (20.0 * 0.8)
  static const double mobileBodyFontSize = desktopBodyFontSize * _mobileScaleFactor;         // 12.8 (16.0 * 0.8)
  static const double mobileCaptionFontSize = desktopCaptionFontSize * _mobileScaleFactor;   // 11.2 (14.0 * 0.8)
  static const double mobileButtonFontSize = desktopButtonFontSize * _mobileScaleFactor;     // 12.0 (15.0 * 0.8)
  
  // Tablet font sizes (medium sizes)
  static const double _tabletScaleFactor = 0.9; // Tablet scale factor - adjusted from 0.9375 to 0.9, moderately reduce font size
  static const double tabletTitleFontSize = desktopTitleFontSize * _tabletScaleFactor;      // 21.6 (24.0 * 0.9)
  static const double tabletSubtitleFontSize = desktopSubtitleFontSize * _tabletScaleFactor; // 18.0 (20.0 * 0.9)
  static const double tabletBodyFontSize = desktopBodyFontSize * _tabletScaleFactor;         // 14.4 (16.0 * 0.9)
  static const double tabletCaptionFontSize = desktopCaptionFontSize * _tabletScaleFactor;   // 12.6 (14.0 * 0.9)
  static const double tabletButtonFontSize = desktopButtonFontSize * _tabletScaleFactor;     // 13.5 (15.0 * 0.9)
  
  // ===== Layered minimum font protection system =====
  
  // Basic readability protection (compliant with WCAG 2.1 AA standards)
  static const double baseMinFontSize = 14.0;           // Base minimum font size
  static const double baseMinTitleFontSize = 18.0;      // Base minimum title font size
  static const double baseMinBodyFontSize = 16.0;       // Base minimum body font size
  static const double baseMinCaptionFontSize = 14.0;    // Base minimum caption font size
  static const double baseMinButtonFontSize = 16.0;     // Base minimum button font size
  
  // Device-specific minimum font protection
  static const double mobileMinFontSize = 16.0;           // Mobile minimum font size (touch-friendly)
  static const double mobileMinTitleFontSize = 20.0;      // Mobile minimum title font size
  static const double mobileMinBodyFontSize = 16.0;       // Mobile minimum body font size
  static const double mobileMinCaptionFontSize = 14.0;    // Mobile minimum caption font size
  static const double mobileMinButtonFontSize = 18.0;     // Mobile minimum button font size (touch-friendly)
  
  static const double tabletMinFontSize = 15.0;           // Tablet minimum font size
  static const double tabletMinTitleFontSize = 19.0;      // Tablet minimum title font size
  static const double tabletMinBodyFontSize = 15.0;       // Tablet minimum body font size
  static const double tabletMinCaptionFontSize = 14.0;    // Tablet minimum caption font size
  static const double tabletMinButtonFontSize = 16.0;     // Tablet minimum button font size
  
  static const double desktopMinFontSize = 14.0;           // Desktop minimum font size
  static const double desktopMinTitleFontSize = 18.0;      // Desktop minimum title font size
  static const double desktopMinBodyFontSize = 14.0;       // Desktop minimum body font size
  static const double desktopMinCaptionFontSize = 12.0;    // Desktop minimum caption font size
  static const double desktopMinButtonFontSize = 14.0;     // Desktop minimum button font size
  
  // Accessibility enhanced font sizes
  static const double accessibilityMinFontSize = 18.0;     // Accessibility minimum font size
  static const double accessibilityMinTitleFontSize = 22.0; // Accessibility minimum title font size
  static const double accessibilityMinBodyFontSize = 18.0;  // Accessibility minimum body font size
  static const double accessibilityMinCaptionFontSize = 16.0; // Accessibility minimum caption font size
  static const double accessibilityMinButtonFontSize = 18.0;  // Accessibility minimum button font size
  
  // High contrast mode font sizes
  static const double highContrastMinFontSize = 16.0;      // High contrast minimum font size
  static const double highContrastMinTitleFontSize = 20.0;  // High contrast minimum title font size
  static const double highContrastMinBodyFontSize = 16.0;   // High contrast minimum body font size
  
  // Touch device optimized font sizes
  static const double touchFriendlyMinFontSize = 16.0;     // Touch-friendly minimum font size
  static const double touchFriendlyMinButtonFontSize = 18.0; // Touch-friendly minimum button font size
  
  // High DPI screen font size adjustment factors
  static const double highDpiFontScaleFactor = 1.1;        // High DPI screen font scale factor
  static const double ultraHighDpiFontScaleFactor = 1.2;   // Ultra high DPI screen font scale factor
  
  // User font preference thresholds
  static const double userPreferenceThreshold = 1.2;        // User font preference threshold (1.2x+ considered preference for large font)
  static const double accessibilityModeThreshold = 1.5;     // Accessibility mode threshold (1.5x+ considered need for accessibility support)

  // ===== Spacing system refactoring =====
  // Base spacing unit
  static const double _baseSpacing = 8.0;
  
  // Spacing ratio system
  static const double _smallSpacingRatio = 0.5;    // 0.5x
  static const double _mediumSpacingRatio = 1.0;   // 1.0x
  static const double _largeSpacingRatio = 1.5;    // 1.5x
  static const double _xlargeSpacingRatio = 2.0;   // 2.0x
  static const double _xxlargeSpacingRatio = 3.0;  // 3.0x
  
  // Spacing constants
  static const double spacing = _baseSpacing * _mediumSpacingRatio;      // 8.0
  static const double spacingSmall = _baseSpacing * _smallSpacingRatio;  // 4.0
  static const double spacingMedium = _baseSpacing * _mediumSpacingRatio; // 8.0
  static const double spacingLarge = _baseSpacing * _largeSpacingRatio;  // 12.0
  static const double spacingXLarge = _baseSpacing * _xlargeSpacingRatio; // 16.0
  static const double spacingXXLarge = _baseSpacing * _xxlargeSpacingRatio; // 24.0
  
  // Legacy naming for compatibility
  static const double defaultPadding = spacingXLarge;    // 16.0
  static const double smallPadding = spacingMedium;      // 8.0
  static const double largePadding = spacingXXLarge;     // 24.0

  // ===== Icon system refactoring =====
  // Base icon size
  static const double _baseIconSize = 24.0;
  
  // Icon ratio system
  static const double _smallIconRatio = 0.75;     // 0.75x
  static const double _mediumIconRatio = 1.0;     // 1.0x
  static const double _largeIconRatio = 1.33;     // 1.33x
  static const double _xlargeIconRatio = 1.67;    // 1.67x
  static const double _xxlargeIconRatio = 2.0;    // 2.0x
  
  // Icon size constants
  static const double iconSizeSmall = _baseIconSize * _smallIconRatio;     // 18.0
  static const double iconSizeMedium = _baseIconSize * _mediumIconRatio;   // 24.0
  static const double iconSizeLarge = _baseIconSize * _largeIconRatio;     // 32.0
  static const double iconSizeXLarge = _baseIconSize * _xlargeIconRatio;   // 40.0
  static const double iconSizeXXLarge = _baseIconSize * _xxlargeIconRatio; // 48.0
  
  // Legacy naming for compatibility
  static const double minIconSize = iconSizeSmall;      // 18.0
  static const double mobileMinIconSize = iconSizeMedium; // 24.0
  static const double defaultIconSize = iconSizeMedium;   // 24.0
  static const double largeIconSize = iconSizeLarge;      // 32.0

  // ===== Border radius system refactoring =====
  // Base radius unit
  static const double _baseRadius = 8.0;
  
  // Radius ratio system
  static const double _smallRadiusRatio = 0.5;    // 0.5x
  static const double _mediumRadiusRatio = 1.0;   // 1.0x
  static const double _largeRadiusRatio = 1.5;    // 1.5x
  
  // Radius constants
  static const double radiusSmall = _baseRadius * _smallRadiusRatio;   // 4.0
  static const double radiusMedium = _baseRadius * _mediumRadiusRatio; // 8.0
  static const double radiusLarge = _baseRadius * _largeRadiusRatio;   // 12.0
  
  // Legacy naming for compatibility
  static const double defaultRadius = radiusMedium; // 8.0
  static const double smallRadius = radiusSmall;    // 4.0
  static const double largeRadius = radiusLarge;    // 12.0

  // ===== Responsive breakpoint system refactoring =====
  // Desktop-first breakpoint design
  static const double breakpointMobile = 768.0;      // Mobile breakpoint
  static const double breakpointTablet = 1024.0;     // Tablet breakpoint
  static const double breakpointDesktop = 1440.0;    // Desktop breakpoint
  static const double breakpointLargeDesktop = 1920.0; // Large desktop breakpoint
  
  // Legacy naming for compatibility
  static const double mobileBreakpoint = breakpointMobile;
  static const double tabletBreakpoint = breakpointTablet;
  static const double desktopBreakpoint = breakpointDesktop;
  static const double largeDesktopBreakpoint = breakpointLargeDesktop;

  // ===== Layout dimension system =====
  // Sidebar width (based on screen ratio)
  static const double sidebarWidthRatio = 0.2;        // 20% of screen width
  static const double sidebarMinWidth = 240.0;        // Minimum width
  static const double sidebarMaxWidth = 320.0;        // Maximum width
  
  // Content area maximum width
  static const double contentMaxWidth = 1200.0;       // Content area maximum width
  static const double contentPaddingRatio = 0.05;     // 5% of screen width as padding

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
  static const double cardElevation = 2.0;

  // Error Messages
  static const String networkErrorMessage = 'Network connection error. Please check your internet connection.';
  static const String serverErrorMessage = 'Server error occurred. Please try again later.';
  static const String unauthorizedErrorMessage = 'Session expired. Please login again.';
  static const String generalErrorMessage = 'An unexpected error occurred. Please try again.';
}
