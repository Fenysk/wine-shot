import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../../_core/di.dart';
import '../bloc/movements_bloc.dart';
import '../widgets/movements_list.dart';
import '../widgets/new_movement_button.dart';

class MovementsTab extends StatefulWidget {
  const MovementsTab({super.key});

  @override
  State<MovementsTab> createState() => _MovementsTabState();
}

class _MovementsTabState extends State<MovementsTab> {
  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return BlocProvider<MovementsBloc>(
      create: (context) => di<MovementsBloc>()..add(const LoadMovementsEvent()),
      child: BlocBuilder<MovementsBloc, MovementsState>(
        builder: (context, state) {
          if (state is MovementsLoading) {
            return _buildLoadingContent();
          } else if (state is MovementsLoaded) {
            return _buildMainContent(context, isMobile, state);
          } else if (state is MovementsError) {
            return _buildErrorContent(state.errorMessage);
          } else {
            return _buildInitialContent();
          }
        },
      ),
    );
  }

  Widget _buildMainContent(BuildContext context, bool isMobile, MovementsLoaded state) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          MovementsList(
            movements: state.movements,
            onRefresh: () async => context.read<MovementsBloc>().add(const LoadMovementsEvent()),
          ),
          if (isMobile)
            Positioned(
              bottom: 16,
              right: 16,
              child: NewMovementButton(),
            ),
        ],
      ),
    );
  }

  Widget _buildLoadingContent() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildErrorContent(String message) {
    return Center(
      child: Text(message),
    );
  }

  Widget _buildInitialContent() {
    return Center(
      child: Text(context.tr('movement.empty')),
    );
  }
}
