// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counter_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CounteAdapter extends TypeAdapter<Counte> {
  @override
  final int typeId = 1;

  @override
  Counte read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Counte(
      fields[0] as int,
      fields[1] as CheckValue,
    );
  }

  @override
  void write(BinaryWriter writer, Counte obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.counts)
      ..writeByte(1)
      ..write(obj.check);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CounteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
