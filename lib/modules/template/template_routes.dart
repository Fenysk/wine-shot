import 'package:go_router/go_router.dart';

import '../../_core/app_router.dart';
import 'features/workout/page/workout_page.dart';

List<GoRoute> templateRoutes() {
  return [
    GoRoute(
      path: "/templates",
      pageBuilder: (context, state) => FadeTransitionPage(
        child: WorkoutPage(),
      ),
    ),
  ];
}
