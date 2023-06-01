// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upgrade_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UpgradeModelAdapter extends TypeAdapter<UpgradeModel> {
  @override
  final int typeId = 0;

  @override
  UpgradeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UpgradeModel(
      id: fields[0] as int,
      name: fields[1] as String,
      churchInitialBonus: fields[6] as double,
      currentLvl: fields[4] as int,
      hitInitialBonus: fields[5] as double,
      initialPrice: fields[2] as int,
      maxLvl: fields[3] as int,
      hitMultiplier: fields[7] as double,
      priceMultiplier: fields[8] as double,
    );
  }

  @override
  void write(BinaryWriter writer, UpgradeModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.initialPrice)
      ..writeByte(3)
      ..write(obj.maxLvl)
      ..writeByte(4)
      ..write(obj.currentLvl)
      ..writeByte(5)
      ..write(obj.hitInitialBonus)
      ..writeByte(6)
      ..write(obj.churchInitialBonus)
      ..writeByte(7)
      ..write(obj.hitMultiplier)
      ..writeByte(8)
      ..write(obj.priceMultiplier);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UpgradeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
