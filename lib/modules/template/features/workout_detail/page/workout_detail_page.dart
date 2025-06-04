import 'package:clean_starter/modules/auth/auth_routes.dart';
import 'package:flutter/material.dart';
import '../../../../../_core/layout/page_layout.dart';

class WorkoutDetailPage extends StatelessWidget {
  final String workoutId;

  const WorkoutDetailPage({super.key, required this.workoutId});

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      title: 'Workout Detail',
      navTab: AuthNavTab.templates,
      page: Center(
        child: Text('Detail for Workout ID: $workoutId'),
      ),
    );
  }
}
