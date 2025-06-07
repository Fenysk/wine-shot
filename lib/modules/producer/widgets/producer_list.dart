import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../domain/entities/producer_entity.dart';
import '../features/new_producer/widgets/new_producer_button.dart';

class ProducerList extends StatelessWidget {
  final List<ProducerEntity> producers;
  final Future<void> Function() onRefresh;

  const ProducerList({
    super.key,
    required this.producers,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: Stack(
        children: [
          ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            itemCount: producers.length,
            itemBuilder: (context, index) {
              final producer = producers[index];
              return ListTile(
                title: Text(producer.name),
                subtitle: Text(producer.region.name),
              );
            },
          ),
          if (!isMobile)
            const Positioned(
              top: 16,
              right: 16,
              child: NewProducerButton(),
            ),
        ],
      ),
    );
  }
}
