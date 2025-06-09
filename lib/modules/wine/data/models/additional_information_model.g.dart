// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'additional_information_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AdditionalInformationModelAdapter
    extends TypeAdapter<AdditionalInformationModel> {
  @override
  final int typeId = 6;

  @override
  AdditionalInformationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AdditionalInformationModel(
      id: fields[0] as String,
      label: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AdditionalInformationModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.label);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdditionalInformationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdditionalInformationModel _$AdditionalInformationModelFromJson(
        Map<String, dynamic> json) =>
    AdditionalInformationModel(
      id: json['id'] as String,
      label: json['label'] as String,
    );
