import 'package:flutter/material.dart';

import '../../../domain/entities/wine_entity.dart';

class WineTile extends StatelessWidget {
  const WineTile({
    super.key,
    required this.wine,
  });

  final WineEntity wine;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(wine.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (wine.producer != null) Text(wine.producer!.name),
          if (wine.region != null) Text(wine.region!.name),
        ],
      ),
      trailing: Text('${wine.alcoholPercentage ?? 0}%'),
    );
  }
}
