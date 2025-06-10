import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../_core/app_router.dart';
import '../../_core/layout/adaptive_layout/adaptive_destination.dart';
import 'features/login/page/login_page.dart';
import 'features/profile/page/profile_page.dart';
import 'features/register/page/register_page.dart';

enum AuthNavTab implements NavTab {
  stocks,
  references,
  profile,
}

List<AdaptiveDestination> getAuthNavTabs(BuildContext context) {
  return <AdaptiveDestination>[
    AdaptiveDestination(
      title: context.tr('layoutPage.stocks'),
      icon: Icons.shopping_cart,
      route: '/stocks',
      navTab: AuthNavTab.stocks,
      order: 10,
    ),
    AdaptiveDestination(
      title: context.tr('layoutPage.references'),
      icon: Icons.library_books,
      route: '/references',
      navTab: AuthNavTab.references,
      order: 20,
    ),
    AdaptiveDestination(
      title: context.tr('layoutPage.profile'),
      icon: Icons.person,
      route: '/profile',
      navTab: AuthNavTab.profile,
      order: 50,
    ),
  ];
}

List<GoRoute> authRoutes() {
  return [
    GoRoute(
      path: "/login",
      redirect: unAuthRouteGuard,
      pageBuilder: (context, state) => FadeTransitionPage(
        child: const LoginPage(),
      ),
    ),
    GoRoute(
      path: "/register",
      redirect: unAuthRouteGuard,
      pageBuilder: (context, state) => FadeTransitionPage(
        child: const RegisterPage(),
      ),
    ),
    GoRoute(
      path: "/profile",
      redirect: authRouteGuard,
      pageBuilder: (context, state) => FadeTransitionPage(
        child: const ProfilePage(),
      ),
    ),
  ];
}
