import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../_core/di.dart';
import '../../../../../_shared/widgets/custom_dialog.dart';
import '../../../../../_shared/widgets/custom_drawer.dart';
import '../../../../producer/bloc/producer_bloc.dart';
import '../../../../region/features/region_list/bloc/region_bloc.dart';
import '../../wine_list/bloc/wine-list/wine_list_bloc.dart';
import '../../wine_list/bloc/wine-types-list/wine_types_list_bloc.dart';
import '../bloc/new_wine_bloc.dart';
import 'new_wine_dialog.dart';

class NewWineButton extends StatelessWidget {
  final WineListBloc wineListBloc;

  const NewWineButton({
    super.key,
    required this.wineListBloc,
  });

  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return isMobile
        ? FloatingActionButton(
            onPressed: () => showNewWineDialog(context, isMobile),
            child: const Icon(Icons.add),
          )
        : TextButton.icon(
            onPressed: () => showNewWineDialog(context, isMobile),
            icon: const Icon(Icons.add),
            label: Text(context.tr("winesPage.newWineDialog.title")),
          );
  }

  void showNewWineDialog(BuildContext context, bool isMobile) {
    final dialogContent = MultiBlocProvider(
      providers: [
        BlocProvider<NewWineBloc>(create: (_) => di<NewWineBloc>()),
        BlocProvider<RegionBloc>(create: (_) => di<RegionBloc>()..add(LoadRegionsEvent())),
        BlocProvider<ProducerBloc>(create: (_) => di<ProducerBloc>()..add(LoadProducersEvent())),
        BlocProvider<WineTypesListBloc>(create: (_) => di<WineTypesListBloc>()..add(LoadWineTypesEvent())),
        BlocProvider<WineListBloc>.value(value: wineListBloc),
      ],
      child: NewWineDialog(
        builder: (context, content, actions) {
          return isMobile
              ? CustomDrawer(
                  title: context.tr('winesPage.newWineDialog.title'),
                  content: content,
                  actions: actions,
                )
              : CustomDialog(
                  title: context.tr('winesPage.newWineDialog.title'),
                  minWidth: MediaQuery.of(context).size.width * 0.3,
                  maxWidth: MediaQuery.of(context).size.width * 0.6,
                  content: content,
                  actions: actions,
                );
        },
      ),
    );

    if (isMobile) {
      showModalBottomSheet(
        context: context,
        builder: (_) => dialogContent,
        isScrollControlled: true,
      );
    } else {
      showDialog(
        context: context,
        builder: (_) => dialogContent,
      );
    }
  }
}
