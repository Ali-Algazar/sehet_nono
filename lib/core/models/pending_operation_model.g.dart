// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pending_operation_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PendingOperationModelAdapter extends TypeAdapter<PendingOperationModel> {
  @override
  final int typeId = 10;

  @override
  PendingOperationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PendingOperationModel(
      id: fields[0] as String,
      type: fields[1] as String,
      target: fields[2] as String,
      data: (fields[3] as Map).cast<String, dynamic>(),
      createdAt: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, PendingOperationModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.target)
      ..writeByte(3)
      ..write(obj.data)
      ..writeByte(4)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PendingOperationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
