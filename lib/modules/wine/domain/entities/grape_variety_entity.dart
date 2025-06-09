import 'package:equatable/equatable.dart';

class GrapeVarietyEntity extends Equatable {
  final String id;
  final String name;

  const GrapeVarietyEntity({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [
        id,
        name
      ];
}
