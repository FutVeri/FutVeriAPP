import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:futveri/features/scout/presentation/pages/create_report_page.dart';
import 'package:futveri/features/scout/presentation/pages/report_detail_page.dart';
import 'package:futveri/features/social/presentation/pages/social_feed_page.dart';
import 'package:futveri/features/social/presentation/pages/post_detail_page.dart';
import 'package:futveri/features/auth/presentation/pages/login_page.dart';
import 'package:futveri/features/scout/presentation/pages/scout_dashboard_page.dart';
import 'package:futveri/features/simulation/presentation/pages/simulation_page.dart';
import 'package:futveri/features/profile/presentation/pages/profile_page.dart';
import 'package:futveri/features/profile/presentation/pages/personal_info_page.dart';
import 'package:futveri/features/profile/presentation/pages/notifications_page.dart';
import 'package:futveri/features/profile/presentation/pages/security_page.dart';
import 'package:futveri/features/profile/presentation/pages/premium_page.dart';
import 'package:futveri/features/profile/presentation/pages/terms_page.dart';
import 'package:futveri/features/profile/presentation/pages/feature_access_page.dart';
import 'package:futveri/core/widgets/scaffold_with_navbar.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorHomeKey = GlobalKey<NavigatorState>(debugLabel: 'shellHome');
final _shellNavigatorScoutKey = GlobalKey<NavigatorState>(debugLabel: 'shellScout');
final _shellNavigatorSimKey = GlobalKey<NavigatorState>(debugLabel: 'shellSim');
final _shellNavigatorProfileKey = GlobalKey<NavigatorState>(debugLabel: 'shellProfile');

final router = GoRouter(
  initialLocation: '/',
  navigatorKey: _rootNavigatorKey,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNavBar(navigationShell: navigationShell);
      },
      branches: [
        // Tab 1: Home (Social Feed)
        StatefulShellBranch(
          navigatorKey: _shellNavigatorHomeKey,
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const SocialFeedPage(),
            ),
          ],
        ),
        // Tab 2: Scout
        StatefulShellBranch(
          navigatorKey: _shellNavigatorScoutKey,
          routes: [
            GoRoute(
              path: '/scout',
              builder: (context, state) => const ScoutDashboardPage(),
            ),
          ],
        ),
        // Tab 3: Simulation
        StatefulShellBranch(
          navigatorKey: _shellNavigatorSimKey,
          routes: [
            GoRoute(
              path: '/simulation',
              builder: (context, state) => const SimulationPage(),
            ),
          ],
        ),
        // Tab 4: Profile
        StatefulShellBranch(
          navigatorKey: _shellNavigatorProfileKey,
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfilePage(),
            ),
          ],
        ),
      ],
    ),
    // Full Screen Routes (Outside Shell)
    GoRoute(
      path: '/create-report',
      parentNavigatorKey: _rootNavigatorKey, // Hides bottom bar
      builder: (context, state) => const CreateReportPage(),
    ),
    GoRoute(
      path: '/login',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/profile/info',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const PersonalInfoPage(),
    ),
    GoRoute(
      path: '/profile/notifications',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const NotificationsPage(),
    ),
    GoRoute(
      path: '/profile/security',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const SecurityPage(),
    ),
    GoRoute(
      path: '/profile/premium',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const PremiumPage(),
    ),
    GoRoute(
      path: '/profile/terms',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const TermsPage(),
    ),
    GoRoute(
      path: '/profile/features',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const FeatureAccessPage(),
    ),
    GoRoute(
      path: '/report-detail/:id',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return ReportDetailPage(reportId: id);
      },
    ),
    GoRoute(
      path: '/post-detail/:id',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return PostDetailPage(postId: id);
      },
    ),
  ],
);
