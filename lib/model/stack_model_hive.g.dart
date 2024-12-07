// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stack_model_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StackModelHiveAdapter extends TypeAdapter<StackModelHive> {
  @override
  final int typeId = 0;

  @override
  StackModelHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StackModelHive(
      fields[0] as String,
      fields[1] as int,
      merge: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, StackModelHive obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.address)
      ..writeByte(2)
      ..write(obj.merge);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StackModelHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
