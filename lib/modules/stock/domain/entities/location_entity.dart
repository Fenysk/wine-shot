import 'package:equatable/equatable.dart';

class LocationEntity extends Equatable {
  final String id;
  final String name;
  final String? address;

  const LocationEntity({
    required this.id,
    required this.name,
    this.address,
  });

  static const empty = LocationEntity(id: '-', name: '-');

  @override
  List<Object?> get props => [
        id,
        name,
        address
      ];
}
