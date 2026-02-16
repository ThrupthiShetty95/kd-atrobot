import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/routing/routes.dart';

/// Main shell with 3 tabs; uses [StatefulNavigationShell] (router outlets).
class MainScreen extends StatelessWidget {
  const MainScreen({
    super.key,
    required this.navigationShell,
    required this.currentLocation,
  });

  final StatefulNavigationShell navigationShell;
  final String currentLocation;

  static const List<String> _tabRoutes = [
    Routes.homeHome,
    Routes.homeNotification,
    Routes.homeSettings,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          context.go(_tabRoutes[index]);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.notifications_outlined),
            selectedIcon: Icon(Icons.notifications),
            label: 'Notification',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  int get _selectedIndex {
    if (currentLocation.startsWith('/home/home')) return 0;
    if (currentLocation.startsWith('/home/notification')) return 1;
    if (currentLocation.startsWith('/home/settings')) return 2;
    return 0;
  }
}
