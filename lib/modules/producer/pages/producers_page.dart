import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../_core/di.dart';
import '../../../_core/layout/page_layout.dart';
import '../../auth/auth_routes.dart';
import '../domain/entities/producer_entity.dart';
import '../bloc/producer_bloc.dart';
import '../features/new_producer/widgets/new_producer_button.dart';
import '../widgets/producer_list.dart';

class ProducersPage extends StatefulWidget {
  const ProducersPage({super.key});

  @override
  State<ProducersPage> createState() => _ProducersPageState();
}

class _ProducersPageState extends State<ProducersPage> {
  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return PageLayout(
      title: context.tr('producersPage.title'),
      navTab: AuthNavTab.producers,
      page: Align(
        alignment: Alignment.topCenter,
        child: BlocProvider<ProducerBloc>(
          create: (context) => di<ProducerBloc>()..add(LoadProducersEvent()),
          child: BlocBuilder<ProducerBloc, ProducerState>(
            builder: (context, state) {
              if (state is ProducerLoading) {
                return _buildLoadingContent();
              } else if (state is ProducerLoaded) {
                return _buildMainContent(context, isMobile, state.producers);
              } else if (state is ProducerError) {
                return _buildErrorContent(state.errorMessage);
              } else {
                return _buildInitialContent();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent(BuildContext context, bool isMobile, List<ProducerEntity> producers) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          ProducerList(
            producers: producers,
            onRefresh: () async => context.read<ProducerBloc>().add(LoadProducersEvent()),
          ),
          if (isMobile)
            Positioned(
              bottom: 16,
              right: 16,
              child: NewProducerButton(),
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
      child: Text('Initial content'.tr()),
    );
  }
}
