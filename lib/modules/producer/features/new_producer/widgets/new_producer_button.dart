import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../_core/di.dart';
import '../bloc/new_producer_bloc.dart';
import 'new_producer_dialog.dart';
import '../../../../region/features/region_list/bloc/region_bloc.dart';
import '../../../bloc/producer_bloc.dart';

class NewProducerButton extends StatelessWidget {
  final ProducerBloc producerBloc;

  const NewProducerButton({
    super.key,
    required this.producerBloc,
  });

  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return isMobile
        ? FloatingActionButton(
            onPressed: () => showNewProducerDialog(context),
            child: const Icon(Icons.add),
          )
        : TextButton.icon(
            onPressed: () => showNewProducerDialog(context),
            icon: const Icon(Icons.add),
            label: Text(context.tr("producersPage.newProducerDialog.title")),
          );
  }

  void showNewProducerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<NewProducerBloc>(create: (_) => di<NewProducerBloc>()),
            BlocProvider<RegionBloc>(create: (_) => di<RegionBloc>()..add(LoadRegionsEvent())),
            BlocProvider<ProducerBloc>.value(value: producerBloc),
          ],
          child: const NewProducerDialog(),
        );
      },
    );
  }
}
