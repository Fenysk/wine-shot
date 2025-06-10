import 'package:json_annotation/json_annotation.dart';

part 'new_region_dto.g.dart';

@JsonSerializable()
class NewRegionDto {
  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'parent_id')
  final String? parentId;

  @JsonKey(name: 'country_id')
  final String? countryId;

  const NewRegionDto({
    required this.name,
    this.parentId,
    this.countryId,
  });

  factory NewRegionDto.fromJson(Map<String, dynamic> json) => _$NewRegionDtoFromJson(json);

  Map<String, dynamic> toJson() => _$NewRegionDtoToJson(this);
}
