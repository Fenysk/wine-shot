import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../_shared/widgets/custom_card.dart';
import '../domain/entities/producer_entity.dart';
import '../features/new_producer/widgets/new_producer_button.dart';
import '../bloc/producer_bloc.dart';

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
                      child: NewProducerButton(
                        producerBloc: context.read<ProducerBloc>(),
                      ),
                    ),
                  ],
                ),
              Expanded(
                child: CustomCard(
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: producers.length,
                    itemBuilder: (context, index) {
                      final producer = producers[index];
                      if (producer.region == null) {
                        return const SizedBox.shrink();
                      }

                      return ListTile(
                        title: Text(
                          producer.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        subtitle: Text(
                          producer.region!.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _showDeleteConfirmationDialog(context, producer.id),
                        ),
                      );
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

  Future<void> _showDeleteConfirmationDialog(BuildContext context, String producerId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Supprimer le producteur'),
        content: const Text('Êtes-vous sûr de vouloir supprimer ce producteur ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Annuler'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      if (context.mounted) {
        context.read<ProducerBloc>().add(DeleteProducerEvent(producerId));
      }
    }
  }
}
