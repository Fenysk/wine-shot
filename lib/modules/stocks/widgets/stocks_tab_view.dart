import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../features/stock_list/views/inventory_tab.dart';

class StocksTabView extends StatefulWidget {
  const StocksTabView({super.key});

  @override
  State<StocksTabView> createState() => _StocksTabViewState();
}

class _StocksTabViewState extends State<StocksTabView> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
            Tab(text: context.tr('stocksTabView.inventory')),
            Tab(text: context.tr('stocksTabView.movements')),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [
              InventoryTab(),
              Center(child: Text('Movements content')), // TODO: Implement MovementsTab
            ],
          ),
        ),
      ],
    );
  }
}
