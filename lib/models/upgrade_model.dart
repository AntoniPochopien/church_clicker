import 'package:hive_flutter/hive_flutter.dart';

part 'upgrade_model.g.dart';

@HiveType(typeId: 0)
class UpgradeModel {
  @HiveField(0)
  int id;
  @HiveField(1)
  int price;
  @HiveField(2)
  int maxLvl;
  @HiveField(3)
  int currentLvl;
  @HiveField(4)
  int updateValue;
  @HiveField(5)
  String imgPath;
  @HiveField(6)
  double priceMultiplier;

  UpgradeModel({
    required this.imgPath,
    required this.id,
    required this.currentLvl,
    required this.updateValue,
    required this.price,
    required this.maxLvl,
    required this.priceMultiplier,
  });
}
