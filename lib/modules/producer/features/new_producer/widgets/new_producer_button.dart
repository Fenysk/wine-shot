import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../_core/di.dart';
import '../bloc/new_producer_bloc.dart';
import 'new_producer_dialog.dart';
import '../../../../region/features/region_list/bloc/region_bloc.dart';

class NewProducerButton extends StatelessWidget {
  const NewProducerButton({super.key});

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
            label: const Text("Nouveau producteur"),
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
          ],
          child: const NewProducerDialog(),
        );
      },
    );
  }
}
