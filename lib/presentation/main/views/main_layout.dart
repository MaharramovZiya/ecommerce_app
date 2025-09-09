import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../uikit/components/custom_bottom_navigation_bar.dart';
import '../../../uikit/constants/icons.dart';

class MainLayout extends StatefulWidget {
  final Widget child;
  final String currentRoute;

  const MainLayout({
    super.key,
    required this.child,
    required this.currentRoute,
  });

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _updateCurrentIndex();
  }

  @override
  void didUpdateWidget(MainLayout oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentRoute != widget.currentRoute) {
      _updateCurrentIndex();
    }
  }

  void _updateCurrentIndex() {
    switch (widget.currentRoute) {
      case '/home':
        _currentIndex = 0;
        break;
      case '/cart':
        _currentIndex = 1;
        break;
      case '/favorites':
        _currentIndex = 2;
        break;
      case '/profile':
        _currentIndex = 3;
        break;
      default:
        _currentIndex = 0;
    }
  }

  void _onTabTapped(int index) {
    if (index == _currentIndex) return;

    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/cart');
        break;
      case 2:
        context.go('/favorites');
        break;
      case 3:
        context.go('/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: widget.child,
      ),
      bottomNavigationBar: _shouldShowBottomBar()
          ? CustomBottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: _onTabTapped,
              items: BottomNavItems.defaultItems,
            )
          : null,
    );
  }

  bool _shouldShowBottomBar() {
    // Bottom bar-ı göstərməyəcəyimiz route-lar
    final hideBottomBarRoutes = [
      '/login',
      '/register',
      '/forgot-password',
      '/product-detail',
      '/checkout',
      '/orders',
    ];

    return !hideBottomBarRoutes.contains(widget.currentRoute);
  }
}
