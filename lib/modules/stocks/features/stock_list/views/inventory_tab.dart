import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../../_core/di.dart';
import '../bloc/stocks_list_bloc.dart';
import '../widgets/inventory_list.dart';
import '../widgets/new_stock_button.dart';

class InventoryTab extends StatefulWidget {
  const InventoryTab({super.key});

  @override
  State<InventoryTab> createState() => _InventoryTabState();
}

class _InventoryTabState extends State<InventoryTab> {
  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return BlocProvider<StocksListBloc>(
      create: (context) => di<StocksListBloc>()..add(const LoadStocksEvent()),
      child: BlocBuilder<StocksListBloc, StocksListState>(
        builder: (context, state) {
          if (state is StockListLoading) {
            return _buildLoadingContent();
          } else if (state is StockListLoaded) {
            return _buildMainContent(context, isMobile, state);
          } else if (state is StockListError) {
            return _buildErrorContent(state.errorMessage);
          } else {
            return _buildInitialContent();
          }
        },
      ),
    );
  }

  Widget _buildMainContent(BuildContext context, bool isMobile, StockListLoaded state) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          InventoryList(
            stocks: state.stocks,
            onRefresh: () async => context.read<StocksListBloc>().add(const LoadStocksEvent()),
          ),
          if (isMobile)
            Positioned(
              bottom: 16,
              right: 16,
              child: NewStockButton(),
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
