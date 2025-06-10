import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../domain/entities/wine_entity.dart';
import '../../new_wine/widgets/new_wine_button.dart';
import '../bloc/wine-list/wine_list_bloc.dart';
import 'wine_tile.dart';

enum WineTileDisplayType {
  card,
  tile
}

class WineList extends StatefulWidget {
  final List<WineEntity> wines;
  final Future<void> Function() onRefresh;

  const WineList({
    super.key,
    required this.wines,
    required this.onRefresh,
  });

  @override
  State<WineList> createState() => _WineListState();
}

class _WineListState extends State<WineList> {
  WineTileDisplayType _displayType = WineTileDisplayType.card;

  void _toggleDisplayType([WineTileDisplayType? displayType]) {
    setState(() {
      _displayType = displayType ?? (_displayType == WineTileDisplayType.card ? WineTileDisplayType.tile : WineTileDisplayType.card);
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveBreakpoints.of(context).isMobile;

    if (isMobile) _toggleDisplayType(WineTileDisplayType.tile);

    return Stack(
      children: [
        RefreshIndicator(
          onRefresh: widget.onRefresh,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: !isMobile
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          spacing: 16,
                          children: [
                            TextButton.icon(
                              icon: Icon(_displayType == WineTileDisplayType.card ? Icons.view_list : Icons.grid_view),
                              label: Text(context.tr(_displayType == WineTileDisplayType.card ? 'wineList.showInList' : 'wineList.showInGrid')),
                              onPressed: _toggleDisplayType,
                            ),
                            NewWineButton(
                              wineListBloc: context.read<WineListBloc>(),
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, bottom: 64),
                  child: _displayType == WineTileDisplayType.card
                      ? GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: widget.wines.length,
                          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 300,
                            childAspectRatio: 3 / 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemBuilder: (context, index) {
                            final wine = widget.wines[index];
                            return WineTile(wine: wine, displayType: WineTileDisplayType.card);
                          },
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: widget.wines.length,
                          itemBuilder: (context, index) {
                            final wine = widget.wines[index];
                            return WineTile(wine: wine, displayType: WineTileDisplayType.tile);
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
