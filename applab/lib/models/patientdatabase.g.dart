// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patientdatabase.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PatientdatabaseAdapter extends TypeAdapter<Patientdatabase> {
  @override
  final int typeId = 1;

  @override
  Patientdatabase read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Patientdatabase(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      fields[5] as String,
     ); // ..sex = fields[4] as bool;
  }

  @override
  void write(BinaryWriter writer, Patientdatabase obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.patients)
      ..writeByte(1)
      ..write(obj.age)
      ..writeByte(2)
      ..write(obj.weight)
      ..writeByte(3)
      ..write(obj.height)
      ..writeByte(4)
      ..write(obj.sex)
      ..writeByte(5)
      ..write(obj.doctorname);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PatientdatabaseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}