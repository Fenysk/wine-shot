import 'package:go_router/go_router.dart';

import '../../_core/app_router.dart';
import 'pages/producers_page.dart';

List<GoRoute> producerRoutes() {
  return [
    GoRoute(
      path: ProducerRoutePaths.producers,
      pageBuilder: (context, state) => FadeTransitionPage(
        child: ProducersPage(),
      ),
      routes: [],
    ),
  ];
}

class ProducerRoutePaths {
  static const String producers = "/producers";
}
