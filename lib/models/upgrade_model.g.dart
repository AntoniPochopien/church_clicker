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
      imgPath: fields[6] as String,
      id: fields[0] as int,
      name: fields[1] as String,
      currentLvl: fields[4] as int,
      updateValue: fields[5] as int,
      price: fields[2] as int,
      maxLvl: fields[3] as int,
      priceMultiplier: fields[7] as double,
    );
  }

  @override
  void write(BinaryWriter writer, UpgradeModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.maxLvl)
      ..writeByte(4)
      ..write(obj.currentLvl)
      ..writeByte(5)
      ..write(obj.updateValue)
      ..writeByte(6)
      ..write(obj.imgPath)
      ..writeByte(7)
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
