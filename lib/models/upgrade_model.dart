import 'package:hive_flutter/hive_flutter.dart';

part 'upgrade_model.g.dart';

@HiveType(typeId: 0)
class UpgradeModel {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  int price;
  @HiveField(3)
  int maxLvl;
  @HiveField(4)
  int currentLvl;
  @HiveField(5)
  int updateValue;
  @HiveField(6)
  String imgPath;
  @HiveField(7)
  double priceMultiplier;

  UpgradeModel({
    required this.imgPath,
    required this.id,
    required this.name,
    required this.currentLvl,
    required this.updateValue,
    required this.price,
    required this.maxLvl,
    required this.priceMultiplier,
  });
}
