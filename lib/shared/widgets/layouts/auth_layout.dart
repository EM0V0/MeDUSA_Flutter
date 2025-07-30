import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../core/theme/app_colors.dart';

class AuthLayout extends StatelessWidget {
  final Widget child;

  const AuthLayout({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveBreakpoints.of(context).largerThan(TABLET) ? _buildDesktopLayout(context) : child,
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      children: [
        // Left side - Branding
        Expanded(
          flex: 1,
          child: Container(
            decoration: const BoxDecoration(
              gradient: AppColors.primaryGradient,
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(48.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.medical_services_rounded,
                      size: 120.w,
                      color: AppColors.onPrimary,
                    ),
                    SizedBox(height: 24.h),
                    Text(
                      'NeuroMotion',
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            color: AppColors.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Advanced Parkinson\'s Disease\nMonitoring System',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColors.onPrimary.withOpacity(0.9),
                          ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 32.h),
                    Card(
                      color: AppColors.onPrimary.withOpacity(0.1),
                      child: Padding(
                        padding: EdgeInsets.all(16.w),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.security,
                                  color: AppColors.onPrimary,
                                  size: 20.w,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  'End-to-End Encryption',
                                  style: TextStyle(
                                    color: AppColors.onPrimary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.h),
                            Row(
                              children: [
                                Icon(
                                  Icons.cloud_sync,
                                  color: AppColors.onPrimary,
                                  size: 20.w,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  'Real-time Monitoring',
                                  style: TextStyle(
                                    color: AppColors.onPrimary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.h),
                            Row(
                              children: [
                                Icon(
                                  Icons.analytics,
                                  color: AppColors.onPrimary,
                                  size: 20.w,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  'Advanced Analytics',
                                  style: TextStyle(
                                    color: AppColors.onPrimary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // Right side - Auth form
        Expanded(
          flex: 1,
          child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Center(
              child: Container(
                constraints: BoxConstraints(maxWidth: 400.w),
                padding: EdgeInsets.all(32.w),
                child: child,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
