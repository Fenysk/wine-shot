import 'package:json_annotation/json_annotation.dart';

part 'new_wine_dto.g.dart';

@JsonSerializable()
class NewWineDto {
  @JsonKey(name: 'name')
  final String name;

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

  const NewWineDto({
    required this.name,
    this.alcoholPercentage,
    this.volume,
    this.description,
    this.producerId,
    this.regionId,
    this.wineTypeId,
  });

  factory NewWineDto.fromJson(Map<String, dynamic> json) => _$NewWineDtoFromJson(json);

  Map<String, dynamic> toJson() => _$NewWineDtoToJson(this);
}
