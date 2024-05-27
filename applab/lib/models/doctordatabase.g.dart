// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctordatabase.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DoctordatabaseAdapter extends TypeAdapter<Doctordatabase> {
  @override
  final int typeId = 0;

  @override
  Doctordatabase read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Doctordatabase(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Doctordatabase obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.surname)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.password);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DoctordatabaseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
