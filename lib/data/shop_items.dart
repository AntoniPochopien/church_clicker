import '../models/upgrade_model.dart';

class ShopItems {
  static final List<UpgradeModel> priestItems = [
    UpgradeModel(
      id: 1,
      name: 'Na tace',
      churchInitialBonus: 0,
      currentLvl: 0,
      hitInitialBonus: 1,
      initialPrice: 10,
      maxLvl: 100,
      hitMultiplier: 0.1,
      priceMultiplier: 0.2,
    ),
    UpgradeModel(
      id: 2,
      name: 'Mównica',
      churchInitialBonus: 0,
      currentLvl: 0,
      hitInitialBonus: 2,
      initialPrice: 150,
      maxLvl: 50,
      hitMultiplier: 0.5,
      priceMultiplier: 0.3,
    ),
  ];
}
