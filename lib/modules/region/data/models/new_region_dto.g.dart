// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_region_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewRegionDto _$NewRegionDtoFromJson(Map<String, dynamic> json) => NewRegionDto(
      name: json['name'] as String,
      parentId: json['parent_id'] as String?,
      countryId: json['country_id'] as String?,
    );

Map<String, dynamic> _$NewRegionDtoToJson(NewRegionDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'parent_id': instance.parentId,
      'country_id': instance.countryId,
    };
