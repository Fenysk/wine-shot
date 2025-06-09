import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../_core/di.dart';
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
    return FloatingActionButton(
      onPressed: () => showNewWineDialog(context),
      child: const Icon(Icons.add),
    );
  }

  void showNewWineDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<NewWineBloc>(create: (_) => di<NewWineBloc>()),
            BlocProvider<RegionBloc>(create: (_) => di<RegionBloc>()..add(LoadRegionsEvent())),
            BlocProvider<ProducerBloc>(create: (_) => di<ProducerBloc>()..add(LoadProducersEvent())),
            BlocProvider<WineTypesListBloc>(create: (_) => di<WineTypesListBloc>()..add(LoadWineTypesEvent())),
            BlocProvider<WineListBloc>.value(value: wineListBloc),
          ],
          child: const NewWineDialog(),
        );
      },
    );
  }
}
