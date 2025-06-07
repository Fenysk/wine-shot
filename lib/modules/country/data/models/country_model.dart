// ignore_for_file: overridden_fields

import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/country_entity.dart';

part 'country_model.g.dart';

@HiveType(typeId: 0)
@JsonSerializable(createToJson: false)
class CountryModel extends CountryEntity {
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
  @JsonKey(name: 'code')
  final String code;

  const CountryModel({
    required this.id,
    required this.name,
    required this.code,
  }) : super(id: id, name: name, code: code);

  factory CountryModel.fromJson(Map<String, dynamic> json) => _$CountryModelFromJson(json);
}
