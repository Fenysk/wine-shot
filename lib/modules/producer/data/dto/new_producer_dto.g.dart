// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_producer_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewProducerDto _$NewProducerDtoFromJson(Map<String, dynamic> json) =>
    NewProducerDto(
      name: json['name'] as String,
      regionId: json['region_id'] as String,
    );

Map<String, dynamic> _$NewProducerDtoToJson(NewProducerDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'region_id': instance.regionId,
    };
