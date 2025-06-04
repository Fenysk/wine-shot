// ignore_for_file: overridden_fields

import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/workout_entity.dart';

part 'workout_model.g.dart';

@HiveType(typeId: 0)
@JsonSerializable(createToJson: false)
class WorkoutModel extends WorkoutEntity {
  @override
  @HiveField(0)
  @JsonKey(name: 'id')
  final String id;

  @override
  @HiveField(1)
  @JsonKey(name: 'name')
  final String name;

  const WorkoutModel({
    required this.id,
    required this.name,
  }) : super(id: id, name: name);

  factory WorkoutModel.fromJson(Map<String, dynamic> json) => _$WorkoutModelFromJson(json);
}
