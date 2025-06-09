// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_wine_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateWineDto _$UpdateWineDtoFromJson(Map<String, dynamic> json) =>
    UpdateWineDto(
      id: json['id'] as String,
      name: json['name'] as String?,
      alcoholPercentage: (json['alcohol_percentage'] as num?)?.toDouble(),
      volume: (json['volume'] as num?)?.toInt(),
      description: json['description'] as String?,
      producerId: json['producer_id'] as String?,
      regionId: json['region_id'] as String?,
      wineTypeId: json['wine_type_id'] as String?,
    );

Map<String, dynamic> _$UpdateWineDtoToJson(UpdateWineDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'alcohol_percentage': instance.alcoholPercentage,
      'volume': instance.volume,
      'description': instance.description,
      'producer_id': instance.producerId,
      'region_id': instance.regionId,
      'wine_type_id': instance.wineTypeId,
    };
