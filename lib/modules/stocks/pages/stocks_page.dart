import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../_core/layout/page_layout.dart';
import '../../auth/auth_routes.dart';
import '../widgets/stocks_tab_view.dart';

class StocksPage extends StatefulWidget {
  const StocksPage({super.key});

  @override
  State<StocksPage> createState() => _StocksPageState();
}

class _StocksPageState extends State<StocksPage> {
  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return PageLayout(
      title: context.tr('stocksPage.title'),
      navTab: AuthNavTab.stocks,
      page: Align(
        alignment: Alignment.topCenter,
        child: _buildMainContent(context, isMobile),
      ),
    );
  }

  Widget _buildMainContent(BuildContext context, bool isMobile) {
    return const StocksTabView();
  }
}
