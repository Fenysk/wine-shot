import 'package:go_router/go_router.dart';

import '../../_core/app_router.dart';
import 'features/workout/page/workout_page.dart';
import 'features/workout_detail/page/workout_detail_page.dart';

List<GoRoute> templateRoutes() {
  return [
    GoRoute(
      path: "/templates",
      pageBuilder: (context, state) => FadeTransitionPage(
        child: WorkoutPage(),
      ),
      routes: [
        GoRoute(
          path: ':workoutId',
          pageBuilder: (context, state) {
            final workoutId = state.pathParameters['workoutId']!;
            return FadeTransitionPage(
              child: WorkoutDetailPage(workoutId: workoutId),
            );
          },
        ),
      ],
    ),
  ];
}
