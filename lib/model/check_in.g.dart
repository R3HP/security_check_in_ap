// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_in.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CheckInAdapter extends TypeAdapter<CheckIn> {
  @override
  final int typeId = 2;

  @override
  CheckIn read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CheckIn(
      driverName: fields[0] as String,
      checkInDate: fields[1] as DateTime,
      checkoutDate: fields[3] as DateTime?,
      numberOfPrepackBaskets: fields[5] as int?,
      numberOfFarahmandBaskets: fields[6] as int?,
      shipmentIdList: (fields[7] as List?)?.cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, CheckIn obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.driverName)
      ..writeByte(1)
      ..write(obj.checkInDate)
      ..writeByte(3)
      ..write(obj.checkoutDate)
      ..writeByte(5)
      ..write(obj.numberOfPrepackBaskets)
      ..writeByte(6)
      ..write(obj.numberOfFarahmandBaskets)
      ..writeByte(7)
      ..write(obj.shipmentIdList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CheckInAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
