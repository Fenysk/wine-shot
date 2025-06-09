import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../../_shared/widgets/custom_card.dart';
import '../../../domain/entities/wine_entity.dart';
import '../../new_wine/widgets/new_wine_button.dart';
import '../bloc/wine-list/wine_list_bloc.dart';
import 'wine_tile.dart';

class WineList extends StatelessWidget {
  final List<WineEntity> wines;
  final Future<void> Function() onRefresh;

  const WineList({
    super.key,
    required this.wines,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return Stack(
      children: [
        RefreshIndicator(
          onRefresh: onRefresh,
          child: Column(
            children: [
              if (!isMobile)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: NewWineButton(
                        wineListBloc: context.read<WineListBloc>(),
                      ),
                    ),
                  ],
                ),
              Expanded(
                child: CustomCard(
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: wines.length,
                    itemBuilder: (context, index) {
                      final wine = wines[index];
                      return WineTile(wine: wine);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
