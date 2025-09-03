import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../core/constants/app_constants.dart';
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
    // Don't call _updateSelectedIndex in initState because context is not fully initialized at this point
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
      // If GoRouterState is not ready yet, ignore the error
      debugPrint('GoRouterState not ready: $e');
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
    return AppBar(
      title: Row(
        children: [
          Icon(
            Icons.medical_services_rounded,
            color: AppColors.onPrimary,
            // Apply icon size protection
            size: IconUtils.getResponsiveIconSize(IconSizeType.medium, context),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              AppConstants.appName,
              style: FontUtils.title(
                context: context,
                fontWeight: FontWeight.bold,
                color: AppColors.onPrimary,
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
            size: IconUtils.getResponsiveIconSize(IconSizeType.medium, context),
          ),
          onPressed: () {
            // TODO: Show notifications
          },
        ),
        PopupMenuButton<String>(
          icon: CircleAvatar(
            child: Icon(
              Icons.person,
              size: IconUtils.getResponsiveIconSize(IconSizeType.medium, context),
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
                    size: IconUtils.getResponsiveIconSize(IconSizeType.medium, context),
                  ),
                  const SizedBox(width: 8),
                  const Text('Profile'),
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
                    size: IconUtils.getResponsiveIconSize(IconSizeType.medium, context),
                  ),
                  const SizedBox(width: 8),
                  const Text('Logout'),
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
      decoration: const BoxDecoration(
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
                      size: IconUtils.getResponsiveIconSize(IconSizeType.medium, context),
                    ),
                    title: Text(
                      item.label,
                      style: FontUtils.body(
                        context: context,
                        color: isSelected ? AppColors.primary : AppColors.lightOnSurface,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    selectedTileColor: AppColors.primary.withValues(alpha: 0.1),
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
      selectedLabelStyle: FontUtils.caption(
        context: context,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: FontUtils.caption(
        context: context,
        fontWeight: FontWeight.w500,
      ),
      items: _navigationItems
          .map(
            (item) => BottomNavigationBarItem(
              icon: Icon(
                item.icon,
                size: IconUtils.getResponsiveIconSize(IconSizeType.medium, context),
              ),
              activeIcon: Icon(
                item.selectedIcon,
                size: IconUtils.getResponsiveIconSize(IconSizeType.medium, context),
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
              // Clear authentication state and navigate to login
              // TODO: integrate real auth state reset via bloc/service
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
