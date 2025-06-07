import 'package:equatable/equatable.dart';

class RegionEntity extends Equatable {
  final String id;
  final String name;
  final String? countryId;
  final String? parentId;

  const RegionEntity({
    required this.id,
    required this.name,
    this.countryId,
    this.parentId,
  });

  static const empty = RegionEntity(id: '', name: '', countryId: null, parentId: null);

  @override
  List<Object?> get props => [
        id,
        name,
        countryId,
        parentId
      ];
}
