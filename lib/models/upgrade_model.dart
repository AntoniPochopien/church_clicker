import 'package:hive_flutter/hive_flutter.dart';

part 'upgrade_model.g.dart';

@HiveType(typeId: 0)
class UpgradeModel {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  int initialPrice;
  @HiveField(3)
  int maxLvl;
  @HiveField(4)
  int currentLvl;
  @HiveField(5)
  double hitInitialBonus;
  @HiveField(6)
  double churchInitialBonus;
  @HiveField(7)
  double hitMultiplier;
  @HiveField(8)
  double priceMultiplier;

  UpgradeModel({
    required this.id,
    required this.name,
    required this.churchInitialBonus,
    required this.currentLvl,
    required this.hitInitialBonus,
    required this.initialPrice,
    required this.maxLvl,
    required this.hitMultiplier,
    required this.priceMultiplier,
  });
}
