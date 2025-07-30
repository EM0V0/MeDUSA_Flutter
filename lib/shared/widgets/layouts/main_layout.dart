import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/font_utils.dart';
import '../../../core/utils/icon_utils.dart';

class MainLayout extends StatefulWidget {
  final Widget child;

  const MainLayout({
    super.key,
    required this.child,
  });

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;

  final List<NavigationItem> _navigationItems = [
    NavigationItem(
      icon: Icons.dashboard_outlined,
      selectedIcon: Icons.dashboard,
      label: 'Dashboard',
      route: '/dashboard',
    ),
    NavigationItem(
      icon: Icons.people_outlined,
      selectedIcon: Icons.people,
      label: 'Patients',
      route: '/patients',
    ),
    NavigationItem(
      icon: Icons.analytics_outlined,
      selectedIcon: Icons.analytics,
      label: 'Reports',
      route: '/reports',
    ),
    NavigationItem(
      icon: Icons.settings_outlined,
      selectedIcon: Icons.settings,
      label: 'Settings',
      route: '/settings',
    ),
  ];

  @override
  void initState() {
    super.initState();
    // 不在initState中调用_updateSelectedIndex，因为此时context未完全初始化
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateSelectedIndex();
    });
  }

  void _updateSelectedIndex() {
    if (!mounted) return;

    try {
      final currentLocation = GoRouterState.of(context).matchedLocation;
      for (int i = 0; i < _navigationItems.length; i++) {
        if (currentLocation.startsWith(_navigationItems[i].route)) {
          if (_selectedIndex != i) {
            setState(() {
              _selectedIndex = i;
            });
          }
          break;
        }
      }
    } catch (e) {
      // 如果GoRouterState还未准备好，忽略错误
      print('GoRouterState not ready: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: ResponsiveBreakpoints.of(context).largerThan(TABLET) ? _buildDesktopLayout() : widget.child,
      bottomNavigationBar: ResponsiveBreakpoints.of(context).smallerThan(DESKTOP) ? _buildBottomNavigation() : null,
    );
  }

  PreferredSizeWidget _buildAppBar() {
    final isMobile = ResponsiveBreakpoints.of(context).smallerThan(TABLET);

    return AppBar(
      title: Row(
        children: [
          Icon(
            Icons.medical_services_rounded,
            color: AppColors.onPrimary,
            // 应用图标大小保护
            size: IconUtils.responsiveIconSize(isMobile ? 28.w : 20.w, context),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              AppConstants.appName,
              style: FontUtils.globalForceResponsiveTitleStyle(
                fontSize: isMobile ? 20.sp : 18.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.onPrimary,
                context: context,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.notifications_outlined,
            size: IconUtils.responsiveIconSize(24.w, context),
          ),
          onPressed: () {
            // TODO: Show notifications
          },
        ),
        PopupMenuButton<String>(
          icon: CircleAvatar(
            child: Icon(
              Icons.person,
              size: IconUtils.responsiveIconSize(20.w, context),
            ),
          ),
          onSelected: (value) {
            switch (value) {
              case 'profile':
                context.go('/profile');
                break;
              case 'logout':
                _handleLogout();
                break;
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'profile',
              child: Row(
                children: [
                  Icon(
                    Icons.person_outline,
                    color: AppColors.primary,
                    size: IconUtils.responsiveIconSize(20.w, context),
                  ),
                  SizedBox(width: 8),
                  Text('Profile'),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'logout',
              child: Row(
                children: [
                  Icon(
                    Icons.logout,
                    color: AppColors.error,
                    size: IconUtils.responsiveIconSize(20.w, context),
                  ),
                  SizedBox(width: 8),
                  Text('Logout'),
                ],
              ),
            ),
          ],
        ),
        SizedBox(width: 8.w),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      children: [
        _buildSideNavigation(),
        Expanded(child: widget.child),
      ],
    );
  }

  Widget _buildSideNavigation() {
    return Container(
      width: 240.w,
      decoration: BoxDecoration(
        color: AppColors.lightSurface,
        border: Border(
          right: BorderSide(
            color: AppColors.lightDivider,
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 20.h),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              itemCount: _navigationItems.length,
              itemBuilder: (context, index) {
                final item = _navigationItems[index];
                final isSelected = _selectedIndex == index;

                return Container(
                  margin: EdgeInsets.only(bottom: 8.h),
                  child: ListTile(
                    selected: isSelected,
                    leading: Icon(
                      isSelected ? item.selectedIcon : item.icon,
                      color: isSelected ? AppColors.primary : AppColors.lightOnSurfaceVariant,
                      size: IconUtils.responsiveIconSize(24.w, context),
                    ),
                    title: Text(
                      item.label,
                      style: FontUtils.globalForceResponsiveBodyStyle(
                        fontSize: 14.sp,
                        color: isSelected ? AppColors.primary : AppColors.lightOnSurface,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                        context: context,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    selectedTileColor: AppColors.primary.withOpacity(0.1),
                    onTap: () => _onNavItemTapped(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      onTap: _onNavItemTapped,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.lightOnSurfaceVariant,
      selectedLabelStyle: FontUtils.globalForceResponsiveBodyStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
        context: context,
      ),
      unselectedLabelStyle: FontUtils.globalForceResponsiveBodyStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        context: context,
      ),
      items: _navigationItems
          .map(
            (item) => BottomNavigationBarItem(
              icon: Icon(
                item.icon,
                size: IconUtils.responsiveIconSize(24.w, context),
              ),
              activeIcon: Icon(
                item.selectedIcon,
                size: IconUtils.responsiveIconSize(24.w, context),
              ),
              label: item.label,
            ),
          )
          .toList(),
    );
  }

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    final route = _navigationItems[index].route;
    context.go(route);
  }

  void _handleLogout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // 清除认证状态
              AppRouter.setAuthenticated(false);
              // 跳转到登录页面
              context.go('/login');
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}

class NavigationItem {
  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final String route;

  NavigationItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.route,
  });
}
