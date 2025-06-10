import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class InventoryTab extends StatefulWidget {
  const InventoryTab({super.key});

  @override
  State<InventoryTab> createState() => _InventoryTabState();
}

class _InventoryTabState extends State<InventoryTab> {
  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return _buildMainContent(context, isMobile);
  }

  Widget _buildMainContent(BuildContext context, bool isMobile) {
    return Center(
      child: Text(context.tr('stocksTabView.inventoryContent')),
    );
  }
}
