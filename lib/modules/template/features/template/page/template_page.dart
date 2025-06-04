import 'package:clean_starter/modules/template/features/template/widgets/new_template_button.dart';
import 'package:clean_starter/modules/template/features/template/widgets/template_list.dart';
import 'package:clean_starter/modules/template/features/template/widgets/new_template_name_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../../_core/di.dart';
import '../../../../../_core/layout/page_layout.dart';
import '../../../../auth/auth_routes.dart';
import '../bloc/template_bloc.dart';

class TemplatePage extends StatefulWidget {
  const TemplatePage({super.key});

  @override
  State<TemplatePage> createState() => _TemplatePageState();
}

class _TemplatePageState extends State<TemplatePage> {
  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return PageLayout(
      title: context.tr('templatesPage.title'),
      navTab: AuthNavTab.templates,
      page: Align(
        alignment: Alignment.topCenter,
        child: BlocProvider<TemplateBloc>(
          create: (context) => di(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                TemplateList(),
                if (isMobile)
                  Positioned(
                    bottom: 16,
                    right: 16,
                    child: NewTemplateButton(),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
