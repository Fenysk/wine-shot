import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../../_core/layout/page_layout.dart';
import '../../../../auth/auth_routes.dart';
import '../../../../region/region_module.dart';
import '../../../domain/entities/wine_entity.dart';
import '../bloc/wine_list_bloc.dart';
import '../bloc/wine_list_event.dart';
import '../bloc/wine_list_state.dart';
import '../widgets/wine_list.dart';

class WineListPage extends StatefulWidget {
  const WineListPage({super.key});

  @override
  State<WineListPage> createState() => _WineListPageState();
}

class _WineListPageState extends State<WineListPage> {
  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return PageLayout(
      title: context.tr('wineListPage.title'),
      navTab: AuthNavTab.wines,
      page: Align(
        alignment: Alignment.topCenter,
        child: BlocProvider<WineListBloc>(
          create: (context) => di<WineListBloc>()..add(const LoadWinesEvent()),
          child: BlocBuilder<WineListBloc, WineListState>(
            builder: (context, state) {
              if (state is WineListLoading) {
                return _buildLoadingContent();
              } else if (state is WineListLoaded) {
                return _buildMainContent(context, isMobile, state.wines);
              } else if (state is WineListError) {
                return _buildErrorContent(state.message);
              } else {
                return _buildInitialContent();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent(BuildContext context, bool isMobile, List<WineEntity> wines) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          WineList(
            wines: wines,
            onRefresh: () async => context.read<WineListBloc>().add(const LoadWinesEvent()),
          ),
          if (isMobile)
            Positioned(
              bottom: 16,
              right: 16,
              child: FloatingActionButton(
                onPressed: () {
                  // Add new wine functionality
                },
                child: const Icon(Icons.add),
              ),
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
