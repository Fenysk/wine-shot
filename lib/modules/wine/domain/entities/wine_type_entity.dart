import 'package:equatable/equatable.dart';

class WineTypeEntity extends Equatable {
  final String id;
  final String label;

  const WineTypeEntity({
    required this.id,
    required this.label,
  });

  @override
  List<Object?> get props => [
        id,
        label
      ];
}
