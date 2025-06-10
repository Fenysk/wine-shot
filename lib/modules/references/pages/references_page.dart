import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../_core/layout/page_layout.dart';
import '../../auth/auth_routes.dart';
import '../widgets/references_tab_view.dart';

class ReferencesPage extends StatefulWidget {
  const ReferencesPage({super.key});

  @override
  State<ReferencesPage> createState() => _ReferencesPageState();
}

class _ReferencesPageState extends State<ReferencesPage> {
  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return PageLayout(
      title: context.tr('referencesPage.title'),
      navTab: AuthNavTab.references,
      page: Align(
        alignment: Alignment.topCenter,
        child: _buildMainContent(context, isMobile),
      ),
    );
  }

  Widget _buildMainContent(BuildContext context, bool isMobile) {
    return const ReferencesTabView();
  }
}
