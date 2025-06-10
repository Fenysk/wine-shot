import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../producer/widgets/producers_tab.dart';
import 'wines_tab.dart';

class ReferencesTabView extends StatefulWidget {
  const ReferencesTabView({super.key});

  @override
  State<ReferencesTabView> createState() => _ReferencesTabViewState();
}

class _ReferencesTabViewState extends State<ReferencesTabView> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: [
            Tab(text: context.tr('referencesTabView.wines')),
            Tab(text: context.tr('referencesTabView.producers')),
            Tab(text: context.tr('referencesTabView.regions')),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              WinesTab(),
              ProducersTab(),
              Center(child: Text(context.tr('referencesTabView.regionsContent'))),
            ],
          ),
        ),
      ],
    );
  }
}
