import 'package:clean_starter/modules/template/domain/entities/workout_entity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../bloc/workout_bloc.dart';
import 'new_workout_button.dart';
import 'workout_item.dart';

class WorkoutList extends StatelessWidget {
  const WorkoutList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16,
      ),
      child: SizedBox(
        width: 700,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 32,
          ),
          child: BlocBuilder<WorkoutBloc, WorkoutState>(
            builder: (context, state) {
              final bool isEmpty = state is WorkoutInitial || (state is WorkoutFetched && state.workouts.isEmpty);
              final bool isLoading = state is WorkoutLoading || state is WorkoutSaving;
              final bool hasError = state is WorkoutError || state is WorkoutSavingError;
              final bool isFetched = state is WorkoutFetched;

              if (isEmpty) return _buildEmptyContent(context, isMobile);
              if (isLoading) return _buildLoadingContent();
              if (hasError) return _buildErrorContent(state);
              if (isFetched) return _buildMainContent(context, isMobile, state.workouts);

              return _buildDefaultContent(state);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDefaultContent(WorkoutState state) {
    return Center(
      child: Text('État BLoC non géré: ${state.runtimeType}'),
    );
  }

  Widget _buildMainContent(BuildContext context, bool isMobile, List<WorkoutEntity> workouts) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 15,
      children: [
        if (!isMobile) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              NewWorkoutButton(),
            ],
          ),
        ],
        Expanded(
          child: ListView.builder(
            itemCount: workouts.length,
            itemBuilder: (context, index) {
              final workout = workouts[index];
              return WorkoutItem(workout: workout);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildErrorContent(WorkoutState state) {
    return Center(
      child: Text('Error: ${state is WorkoutError ? state.message : (state as WorkoutSavingError).message}'),
    );
  }

  Widget _buildLoadingContent() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildEmptyContent(BuildContext context, bool isMobile) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Spacer(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Spacer(),
            Text(
              context.tr('templatesPage.emptyWorkoutList'),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const Spacer(),
            if (!isMobile) const NewWorkoutButton()
          ],
        ),
        const SizedBox(height: 15),
        const Spacer(),
      ],
    );
  }
}
