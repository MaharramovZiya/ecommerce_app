import 'package:flutter/material.dart';
import 'package:ecommerce_apps/uikit/components/svg_icon.dart';
import 'package:ecommerce_apps/uikit/constants/icons.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int>? onTap;
  final List<BottomNavItem> items;
  final Color? backgroundColor;
  final Color? activeColor;
  final Color? inactiveColor;
  final double iconSize;
  final double height;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    this.onTap,
    required this.items,
    this.backgroundColor,
    this.activeColor,
    this.inactiveColor,
    this.iconSize = 24,
    this.height = 80,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final isActive = index == currentIndex;
              
              return Expanded(
                child: GestureDetector(
                  onTap: () => onTap?.call(index),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Stack(
                          children: [
                            SvgIcon(
                              item.icon,
                              size: iconSize,
                              color: isActive
                                  ? (activeColor ?? theme.colorScheme.primary)
                                  : (inactiveColor ?? theme.colorScheme.onSurface.withOpacity(0.6)),
                            ),
                            if (item.badgeCount != null && item.badgeCount! > 0)
                              Positioned(
                                right: -2,
                                top: -2,
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  constraints: const BoxConstraints(
                                    minWidth: 16,
                                    minHeight: 16,
                                  ),
                                  child: Text(
                                    item.badgeCount! > 99 ? '99+' : item.badgeCount.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.label,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                            color: isActive
                                ? (activeColor ?? theme.colorScheme.primary)
                                : (inactiveColor ?? theme.colorScheme.onSurface.withOpacity(0.6)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
        ),
      ),
    );
  }
}

class BottomNavItem {
  final AppsIcons icon;
  final String label;
  final String? route;
  final int? badgeCount;

  const BottomNavItem({
    required this.icon,
    required this.label,
    this.route,
    this.badgeCount,
  });
}

// Predefined navigation items for e-commerce app
class BottomNavItems {
  static const home = BottomNavItem(
    icon: AppsIcons.shop,
    label: 'Home',
    route: '/home',
  );

  static const cart = BottomNavItem(
    icon: AppsIcons.basket,
    label: 'Cart',
    route: '/cart',
    badgeCount: 1,
  );

  static const favorites = BottomNavItem(
    icon: AppsIcons.heart,
    label: 'Favorites',
    route: '/favorites',
  );

  static const profile = BottomNavItem(
    icon: AppsIcons.user,
    label: 'Profile',
    route: '/profile',
  );

  static const List<BottomNavItem> defaultItems = [
    home,
    cart,
    favorites,
    profile,
  ];
}