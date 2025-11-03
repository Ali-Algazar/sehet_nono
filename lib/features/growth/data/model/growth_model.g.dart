// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'growth_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GrowthModelAdapter extends TypeAdapter<GrowthModel> {
  @override
  final int typeId = 4;

  @override
  GrowthModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GrowthModel(
      id: fields[0] as String,
      childId: fields[1] as String,
      height: fields[2] as String,
      weight: fields[3] as String,
      headCircumference: fields[4] as String?,
      dateMeasured: fields[5] as String,
      note: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, GrowthModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.childId)
      ..writeByte(2)
      ..write(obj.height)
      ..writeByte(3)
      ..write(obj.weight)
      ..writeByte(4)
      ..write(obj.headCircumference)
      ..writeByte(5)
      ..write(obj.dateMeasured)
      ..writeByte(6)
      ..write(obj.note);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GrowthModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
