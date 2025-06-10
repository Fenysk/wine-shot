import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../bloc/producer_bloc.dart';
import '../domain/entities/producer_entity.dart';
import '../features/new_producer/widgets/new_producer_button.dart';
import 'producer_tile.dart';

enum ProducerTileDisplayType {
  card,
  tile
}

class ProducerList extends StatefulWidget {
  final List<ProducerEntity> producers;
  final Future<void> Function() onRefresh;

  const ProducerList({
    super.key,
    required this.producers,
    required this.onRefresh,
  });

  @override
  State<ProducerList> createState() => _ProducerListState();
}

class _ProducerListState extends State<ProducerList> {
  ProducerTileDisplayType _displayType = ProducerTileDisplayType.card;

  void _toggleDisplayType() {
    setState(() {
      _displayType = _displayType == ProducerTileDisplayType.card ? ProducerTileDisplayType.tile : ProducerTileDisplayType.card;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return Stack(
      children: [
        RefreshIndicator(
          onRefresh: widget.onRefresh,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    spacing: 16,
                    children: [
                      TextButton.icon(
                        icon: Icon(_displayType == ProducerTileDisplayType.card ? Icons.view_list : Icons.grid_view),
                        label: Text(context.tr(_displayType == ProducerTileDisplayType.card ? 'producerList.showInList' : 'producerList.showInGrid')),
                        onPressed: _toggleDisplayType,
                      ),
                      if (!isMobile)
                        NewProducerButton(
                          producerBloc: context.read<ProducerBloc>(),
                        ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 64),
                sliver: _displayType == ProducerTileDisplayType.card
                    ? SliverGrid(
                        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 300,
                          childAspectRatio: 3 / 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final producer = widget.producers[index];
                            return ProducerTile(producer: producer, displayType: ProducerTileDisplayType.card);
                          },
                          childCount: widget.producers.length,
                        ),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final producer = widget.producers[index];
                            return ProducerTile(producer: producer, displayType: ProducerTileDisplayType.tile);
                          },
                          childCount: widget.producers.length,
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
