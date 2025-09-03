import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/font_utils.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> with TickerProviderStateMixin {
  late TabController _tabController;

  // User Profile Settings
  final _nameController = TextEditingController(text: 'Dr. Sarah Johnson');
  final _emailController = TextEditingController(text: 'sarah.johnson@medusa.com');
  final _phoneController = TextEditingController(text: '+1 (555) 123-4567');
  final _specialtyController = TextEditingController(text: 'Neurologist');
  final _licenseController = TextEditingController(text: 'MD-12345678');

  // Notification Settings
  bool emailNotifications = true;
  bool pushNotifications = true;
  bool smsNotifications = false;
  bool criticalAlerts = true;
  bool dailyReports = true;
  bool weeklyReports = false;

  // Security Settings
  bool twoFactorAuth = false;
  bool biometricAuth = true;
  String sessionTimeout = '30 minutes';
  bool autoLogout = true;

  // System Settings (Admin only)
  double alertThreshold = 7.5;
  int dataRetentionDays = 365;
  bool debugMode = false;
  String backupFrequency = 'Daily';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _specialtyController.dispose();
    _licenseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).smallerThan(TABLET);

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: Padding(
        padding: EdgeInsets.all(isMobile ? 16.w : 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(isMobile),
            SizedBox(height: 24.h),
            _buildTabBar(isMobile),
            SizedBox(height: 16.h),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildNotificationsTab(isMobile),
                  _buildSecurityTab(isMobile),
                  _buildSystemTab(isMobile),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Settings',
          style: FontUtils.title(
            fontWeight: FontWeight.bold,
            color: AppColors.lightOnSurface,
            context: context,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Manage your account, notifications, and system preferences',
          style: FontUtils.body(
            color: AppColors.lightOnSurfaceVariant,
            context: context,
          ),
        ),
      ],
    );
  }

  Widget _buildTabBar(bool isMobile) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightSurface,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TabBar(
        controller: _tabController,
        isScrollable: isMobile,
        tabAlignment: isMobile ? TabAlignment.start : TabAlignment.fill,
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.lightOnSurfaceVariant,
        indicatorColor: AppColors.primary,
        labelStyle: FontUtils.body(
          fontWeight: FontWeight.w600,
          context: context,
        ),
        unselectedLabelStyle: FontUtils.body(
          fontWeight: FontWeight.w500,
          context: context,
        ),
        indicatorPadding: EdgeInsets.symmetric(horizontal: 16.w),
        labelPadding: EdgeInsets.symmetric(
          horizontal: isMobile ? 16.w : 8.w,
          vertical: isMobile ? 16.h : 12.h,
        ),
        tabs: const [
          Tab(text: 'Notifications'),
          Tab(text: 'Security'),
          Tab(text: 'System'),
        ],
      ),
    );
  }

  Widget _buildNotificationsTab(bool isMobile) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: AppColors.lightSurface,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Notification Preferences',
              style: FontUtils.title(
                fontWeight: FontWeight.w600,
                color: AppColors.lightOnSurface,
                context: context,
              ),
            ),
            SizedBox(height: 20.h),
            _buildSwitchTile(
              'Email Notifications',
              emailNotifications,
              (value) => setState(() => emailNotifications = value),
              isMobile,
            ),
            _buildSwitchTile(
              'Push Notifications',
              pushNotifications,
              (value) => setState(() => pushNotifications = value),
              isMobile,
            ),
            _buildSwitchTile(
              'SMS Notifications',
              smsNotifications,
              (value) => setState(() => smsNotifications = value),
              isMobile,
            ),
            _buildSwitchTile(
              'Critical Alerts',
              criticalAlerts,
              (value) => setState(() => criticalAlerts = value),
              isMobile,
            ),
            _buildSwitchTile(
              'Daily Reports',
              dailyReports,
              (value) => setState(() => dailyReports = value),
              isMobile,
            ),
            _buildSwitchTile(
              'Weekly Reports',
              weeklyReports,
              (value) => setState(() => weeklyReports = value),
              isMobile,
            ),
            SizedBox(height: 24.h),
            ElevatedButton(
              onPressed: _saveNotificationSettings,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: FontUtils.bodyText('Save Notification Settings', context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecurityTab(bool isMobile) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: AppColors.lightSurface,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Security Settings',
              style: FontUtils.title(
                fontWeight: FontWeight.w600,
                color: AppColors.lightOnSurface,
                context: context,
              ),
            ),
            SizedBox(height: 24.h),
            _buildSectionHeader('Authentication', isMobile),
            SizedBox(height: 16.h),
            _buildSwitchTile('Two-Factor Authentication', twoFactorAuth, (value) {
              setState(() {
                twoFactorAuth = value;
              });
            }, isMobile),
            _buildSwitchTile('Biometric Authentication', biometricAuth, (value) {
              setState(() {
                biometricAuth = value;
              });
            }, isMobile),
            _buildSwitchTile('Auto Logout', autoLogout, (value) {
              setState(() {
                autoLogout = value;
              });
            }, isMobile),
            SizedBox(height: 24.h),
            _buildDropdownField(
              'Session Timeout',
              sessionTimeout,
              ['15 minutes', '30 minutes', '1 hour', '2 hours', '4 hours'],
              (value) {
                setState(() {
                  sessionTimeout = value!;
                });
              },
              isMobile,
            ),
            SizedBox(height: 32.h),
            _buildSectionHeader('Password Management', isMobile),
            SizedBox(height: 16.h),
            Center(
              child: SizedBox(
                width: isMobile ? double.infinity : 200.w,
                height: isMobile ? 56.h : 48.h,
                child: OutlinedButton(
                  onPressed: () {
                    _changePassword();
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: const BorderSide(color: AppColors.primary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Change Password',
                    style: FontUtils.body(
                      fontWeight: FontWeight.w600,
                      context: context,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSystemTab(bool isMobile) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: AppColors.lightSurface,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'System Configuration',
              style: FontUtils.title(
                fontWeight: FontWeight.w600,
                color: AppColors.lightOnSurface,
                context: context,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Administrative settings (requires admin privileges)',
              style: FontUtils.body(
                color: AppColors.lightOnSurfaceVariant,
                context: context,
              ),
            ),
            SizedBox(height: 24.h),
            _buildSectionHeader('Alert Configuration', isMobile),
            SizedBox(height: 16.h),
            _buildNumberField(
              'Tremor Alert Threshold',
              alertThreshold,
              (value) {
                setState(() {
                  alertThreshold = value as double;
                });
              },
              isMobile,
              suffix: 'Hz',
              min: 0.0,
              max: 20.0,
            ),
            SizedBox(height: 24.h),
            _buildSectionHeader('Data Management', isMobile),
            SizedBox(height: 16.h),
            _buildNumberField(
              'Data Retention Period',
              dataRetentionDays.toDouble(),
              (value) {
                setState(() {
                  dataRetentionDays = (value as double).round();
                });
              },
              isMobile,
              suffix: 'days',
              min: 30.0,
              max: 3650.0,
            ),
            SizedBox(height: 16.h),
            _buildDropdownField(
              'Backup Frequency',
              backupFrequency,
              ['Daily', 'Weekly', 'Monthly'],
              (value) {
                setState(() {
                  backupFrequency = value!;
                });
              },
              isMobile,
            ),
            SizedBox(height: 24.h),
            _buildSectionHeader('Developer Options', isMobile),
            SizedBox(height: 16.h),
            _buildSwitchTile('Debug Mode', debugMode, (value) {
              setState(() {
                debugMode = value;
              });
            }, isMobile),
            SizedBox(height: 32.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      _exportData();
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      side: const BorderSide(color: AppColors.primary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: isMobile ? 16.h : 12.h),
                    ),
                    child: Text(
                      'Export Data',
                      style: FontUtils.body(
                        fontWeight: FontWeight.w600,
                        context: context,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _saveSystemSettings();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.lightSurface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: isMobile ? 16.h : 12.h),
                    ),
                    child: Text(
                      'Save Settings',
                      style: FontUtils.body(
                        fontWeight: FontWeight.w600,
                        context: context,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }



  Widget _buildSectionHeader(String title, bool isMobile) {
    return Text(
      title,
      style: FontUtils.title(
        fontWeight: FontWeight.w600,
        color: AppColors.primary,
        context: context,
      ),
    );
  }

  Widget _buildSwitchTile(String title, bool value, Function(bool) onChanged, bool isMobile) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: FontUtils.body(
                color: AppColors.lightOnSurface,
                context: context,
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField(
    String label,
    String value,
    List<String> options,
    Function(String?) onChanged,
    bool isMobile,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: FontUtils.body(
            fontWeight: FontWeight.w500,
            color: AppColors.lightOnSurface,
            context: context,
          ),
        ),
        SizedBox(height: 8.h),
        DropdownButtonFormField<String>(
          value: value,
          style: FontUtils.body(
            color: AppColors.lightOnSurface,
            context: context,
          ),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: AppColors.lightOnSurfaceVariant.withValues(alpha: 0.3)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: AppColors.lightOnSurfaceVariant.withValues(alpha: 0.3)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: isMobile ? 16.h : 12.h,
            ),
          ),
          items: options.map((option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(option),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildNumberField(
    String label,
    double value,
    Function(num) onChanged,
    bool isMobile, {
    String? suffix,
    double? min,
    double? max,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: FontUtils.body(
            fontWeight: FontWeight.w500,
            color: AppColors.lightOnSurface,
            context: context,
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          initialValue: value.toString(),
          keyboardType: TextInputType.number,
          style: FontUtils.body(
            color: AppColors.lightOnSurface,
            context: context,
          ),
          decoration: InputDecoration(
            suffixText: suffix,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: AppColors.lightOnSurfaceVariant.withValues(alpha: 0.3)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: AppColors.lightOnSurfaceVariant.withValues(alpha: 0.3)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: isMobile ? 16.h : 12.h,
            ),
          ),
          onChanged: (val) {
            final parsedValue = double.tryParse(val);
            if (parsedValue != null) {
              if (min != null && parsedValue < min) return;
              if (max != null && parsedValue > max) return;
              onChanged(parsedValue);
            }
          },
        ),
      ],
    );
  }

  // Action methods

  void _changePassword() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Change Password',
          style: FontUtils.title(
            context: context,
          ),
        ),
        content: Text(
          'Password change feature will be implemented soon.',
          style: FontUtils.body(
            context: context,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'OK',
              style: FontUtils.body(
                context: context,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _saveSystemSettings() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
        'System settings saved successfully',
        style: FontUtils.body(
          context: context,
        ),
      )),
    );
  }

  void _exportData() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
        'Data export initiated',
        style: FontUtils.body(
          context: context,
        ),
      )),
    );
  }

  void _saveNotificationSettings() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
        'Notification settings saved successfully',
        style: FontUtils.body(
          context: context,
        ),
      )),
    );
  }
}
