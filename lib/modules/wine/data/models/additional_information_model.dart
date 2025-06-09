// ignore_for_file: overridden_fields

import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/additional_information_entity.dart';

part 'additional_information_model.g.dart';

@HiveType(typeId: 6)
@JsonSerializable(createToJson: false)
class AdditionalInformationModel extends AdditionalInformationEntity {
  @override
  @HiveField(0)
  @JsonKey(name: 'id')
  final String id;

  @override
  @HiveField(1)
  @JsonKey(name: 'label')
  final String label;

  const AdditionalInformationModel({
    required this.id,
    required this.label,
  }) : super(id: id, label: label);

  factory AdditionalInformationModel.fromJson(Map<String, dynamic> json) => _$AdditionalInformationModelFromJson(json);
}
