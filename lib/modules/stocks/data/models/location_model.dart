// ignore_for_file: overridden_fields

import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/location_entity.dart';

part 'location_model.g.dart';

@HiveType(typeId: 3)
@JsonSerializable(createToJson: false)
class LocationModel extends LocationEntity {
  @override
  @HiveField(0)
  @JsonKey(name: 'id')
  final String id;

  @override
  @HiveField(1)
  @JsonKey(name: 'name')
  final String name;

  @override
  @HiveField(2)
  @JsonKey(name: 'address')
  final String? address;

  factory LocationModel.fromJson(Map<String, dynamic> json) => _$LocationModelFromJson(json);

  const LocationModel({
    required this.id,
    required this.name,
    this.address,
  }) : super(id: id, name: name, address: address);
}
