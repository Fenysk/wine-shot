import 'package:equatable/equatable.dart';

class PackagingEntity extends Equatable {
  final String id;
  final String label;
  final int unitVolumeMl;
  final int quantityPerUnit;
  final String? parentPackagingId;
  final PackagingEntity? parentPackaging;

  const PackagingEntity({
    required this.id,
    required this.label,
    required this.unitVolumeMl,
    required this.quantityPerUnit,
    this.parentPackagingId,
    this.parentPackaging,
  });

  static const empty = PackagingEntity(
    id: '-',
    label: '-',
    unitVolumeMl: 0,
    quantityPerUnit: 0,
  );

  @override
  List<Object?> get props => [
        id,
        label,
        unitVolumeMl,
        quantityPerUnit,
        parentPackagingId,
        parentPackaging,
      ];
}
