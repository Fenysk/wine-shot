import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../../_core/di.dart';
import '../../../../../_core/layout/page_layout.dart';
import '../../../../auth/auth_routes.dart';
import '../bloc/workout_bloc.dart';
import '../widgets/widgets.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({super.key});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return PageLayout(
      title: context.tr('templatesPage.title'),
      navTab: AuthNavTab.templates,
      page: Align(
        alignment: Alignment.topCenter,
        child: BlocProvider<WorkoutBloc>(
          create: (context) => di()..add(LoadWorkoutsEvent()),
          child: BlocBuilder<WorkoutBloc, WorkoutState>(
            builder: (context, state) {
              if (state is WorkoutLoading || state is WorkoutSaving) {
                return _buildLoadingContent();
              }

              return _buildMainContent(context, isMobile);
            },
          ),
        ),
      ),
    );
  }

  SizedBox _buildMainContent(BuildContext context, bool isMobile) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          WorkoutList(),
          if (isMobile)
            Positioned(
              bottom: 16,
              right: 16,
              child: NewWorkoutButton(),
            ),
        ],
      ),
    );
  }

  Center _buildLoadingContent() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
