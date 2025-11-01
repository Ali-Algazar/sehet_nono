// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vaccine_record_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VaccineRecordModelAdapter extends TypeAdapter<VaccineRecordModel> {
  @override
  final int typeId = 3;

  @override
  VaccineRecordModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VaccineRecordModel(
      id: fields[0] as String,
      childId: fields[1] as String,
      vaccine: fields[2] as VaccineModel,
      dueDate: fields[3] as DateTime,
      status: fields[4] as String,
      notes: fields[5] as String?,
      dateAdministered: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, VaccineRecordModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.childId)
      ..writeByte(2)
      ..write(obj.vaccine)
      ..writeByte(3)
      ..write(obj.dueDate)
      ..writeByte(4)
      ..write(obj.status)
      ..writeByte(5)
      ..write(obj.notes)
      ..writeByte(6)
      ..write(obj.dateAdministered);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VaccineRecordModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
