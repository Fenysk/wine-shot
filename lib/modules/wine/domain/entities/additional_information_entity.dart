import 'package:equatable/equatable.dart';

class AdditionalInformationEntity extends Equatable {
  final String id;
  final String label;

  const AdditionalInformationEntity({
    required this.id,
    required this.label,
  });

  @override
  List<Object?> get props => [
        id,
        label
      ];
}
