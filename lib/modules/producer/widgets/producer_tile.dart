import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/producer_bloc.dart';
import '../domain/entities/producer_entity.dart';
import 'producer_list.dart';

class ProducerTile extends StatelessWidget {
  const ProducerTile({
    super.key,
    required this.producer,
    this.displayType = ProducerTileDisplayType.card,
  });

  final ProducerEntity producer;
  final ProducerTileDisplayType displayType;

  @override
  Widget build(BuildContext context) {
    switch (displayType) {
      case ProducerTileDisplayType.card:
        return _buildCard(context);
      case ProducerTileDisplayType.tile:
        return _buildTile(context);
    }
  }

  Widget _buildCard(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    producer.name,
                    style: Theme.of(context).textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  color: Theme.of(context).colorScheme.error,
                  onPressed: () {
                    _showDeleteConfirmationDialog(context, producer.id);
                  },
                ),
              ],
            ),
            const Spacer(),
            if (producer.region != null)
              Text(
                producer.region!.name,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: Theme.of(context).textTheme.bodySmall,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTile(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        title: Text(
          producer.name,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        subtitle: producer.region != null
            ? Text(
                producer.region!.name,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              )
            : null,
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Theme.of(context).colorScheme.error),
          onPressed: () {
            _showDeleteConfirmationDialog(context, producer.id);
          },
        ),
      ),
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
