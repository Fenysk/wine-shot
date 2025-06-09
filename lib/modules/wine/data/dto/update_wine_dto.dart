import 'package:json_annotation/json_annotation.dart';

part 'update_wine_dto.g.dart';

@JsonSerializable()
class UpdateWineDto {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'alcohol_percentage')
  final double? alcoholPercentage;

  @JsonKey(name: 'volume')
  final int? volume;

  @JsonKey(name: 'description')
  final String? description;

  @JsonKey(name: 'producer_id')
  final String? producerId;

  @JsonKey(name: 'region_id')
  final String? regionId;

  @JsonKey(name: 'wine_type_id')
  final String? wineTypeId;

  const UpdateWineDto({
    required this.id,
    this.name,
    this.alcoholPercentage,
    this.volume,
    this.description,
    this.producerId,
    this.regionId,
    this.wineTypeId,
  });

  factory UpdateWineDto.fromJson(Map<String, dynamic> json) => _$UpdateWineDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateWineDtoToJson(this);
}
