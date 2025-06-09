import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../_core/app_router.dart';
import '../../_core/layout/adaptive_layout/adaptive_destination.dart';
import 'features/wine_list/page/wine_list_page.dart';

enum WineNavTab implements NavTab {
  wines,
}

List<AdaptiveDestination> getWineNavTabs(BuildContext context) {
  return <AdaptiveDestination>[
    AdaptiveDestination(
      title: context.tr('layoutPage.wines'),
      icon: Icons.wine_bar,
      route: '/wines',
      navTab: WineNavTab.wines,
      order: 15,
    ),
  ];
}

final wineRoutes = [
  GoRoute(
    path: '/wines',
    redirect: authRouteGuard,
    pageBuilder: (context, state) => FadeTransitionPage(
      child: const WineListPage(),
    ),
  ),
];
