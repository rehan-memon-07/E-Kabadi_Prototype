import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_shadows.dart';

class CitizenShell extends StatelessWidget {
  final Widget child;

  const CitizenShell({super.key, required this.child});

  int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    if (location.startsWith('/citizen/sell')) return 1;
    if (location.startsWith('/citizen/orders')) return 2;
    if (location.startsWith('/citizen/profile')) return 3;
    return 0; // /citizen/home
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/citizen/home');
        break;
      case 1:
        context.go('/citizen/sell');
        break;
      case 2:
        context.go('/citizen/orders');
        break;
      case 3:
        context.go('/citizen/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = _calculateSelectedIndex(context);

    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.surface.withValues(alpha: 0.92),
          boxShadow: AppShadows.bottomNav,
          border: const Border(top: BorderSide(color: AppColors.border, width: 0.5)),
        ),
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (idx) => _onItemTapped(idx, context),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textMuted,
          selectedFontSize: 11,
          unselectedFontSize: 11,
          elevation: 0,
          items: [
            _buildNavItem(LucideIcons.home, 'Home', 0, selectedIndex),
            _buildNavItem(LucideIcons.camera, 'Sell', 1, selectedIndex),
            _buildNavItem(LucideIcons.packageCheck, 'Orders', 2, selectedIndex),
            _buildNavItem(LucideIcons.user, 'Profile', 3, selectedIndex),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(IconData icon, String label, int index, int selectedIndex) {
    final isSelected = index == selectedIndex;
    return BottomNavigationBarItem(
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            height: 3,
            width: isSelected ? 20 : 0,
            margin: const EdgeInsets.only(bottom: 4),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Icon(icon, color: isSelected ? AppColors.primary : AppColors.textMuted),
        ],
      ),
      activeIcon: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 3,
            width: 20,
            margin: const EdgeInsets.only(bottom: 4),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Icon(icon, color: AppColors.primary),
        ],
      ),
      label: label,
    );
  }
}
