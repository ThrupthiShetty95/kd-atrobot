import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/screens/login_screen.dart';
import '../../features/main/screens/main_screen.dart';
import '../../features/main/screens/tab_screens.dart';
import '../../providers/auth_provider.dart';
import 'routes.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final auth = ref.read(authNotifierProvider);
  return GoRouter(
    initialLocation: Routes.login,
    redirect: (BuildContext context, GoRouterState state) {
      final isLoggedIn = ref.read(authNotifierProvider).isLoggedIn;
      final isLoggingIn = state.matchedLocation == Routes.login;

      if (!isLoggedIn && !isLoggingIn) return Routes.login;
      if (isLoggedIn && isLoggingIn) return Routes.homeHome;
      return null;
    },
    refreshListenable: auth,
    routes: <RouteBase>[
      GoRoute(
        path: Routes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => MainScreen(
          navigationShell: navigationShell,
          currentLocation: state.matchedLocation,
        ),
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: '/home/home',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: HomeScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: '/home/notification',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: NotificationScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: '/home/settings',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: SettingsScreen(),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});

/// One-off helper to build router with [ref] (e.g. for tests).
GoRouter createAppRouter(WidgetRef ref) {
  return ref.read(goRouterProvider);
}
