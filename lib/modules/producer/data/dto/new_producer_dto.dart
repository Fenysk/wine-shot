import 'package:json_annotation/json_annotation.dart';

part 'new_producer_dto.g.dart';

@JsonSerializable()
class NewProducerDto {
  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'region_id')
  final String regionId;

  const NewProducerDto({
    required this.name,
    required this.regionId,
  });

  factory NewProducerDto.fromJson(Map<String, dynamic> json) => _$NewProducerDtoFromJson(json);

  Map<String, dynamic> toJson() => _$NewProducerDtoToJson(this);
}
