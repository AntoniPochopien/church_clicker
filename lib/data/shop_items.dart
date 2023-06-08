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
      priceMultiplier: 1.1,
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
      priceMultiplier: 1.3,
    ),
  ];

  static final List<UpgradeModel> churchItems = [
    UpgradeModel(
      id: 3,
      name: 'Nowy ministrant',
      churchInitialBonus: 0,
      currentLvl: 0,
      hitInitialBonus: 1,
      initialPrice: 10,
      maxLvl: 100,
      hitMultiplier: 0.1,
      priceMultiplier: 1.1,
    ),
    UpgradeModel(
      id: 4,
      name: 'Nagłośnienie',
      churchInitialBonus: 0,
      currentLvl: 0,
      hitInitialBonus: 2,
      initialPrice: 150,
      maxLvl: 50,
      hitMultiplier: 0.5,
      priceMultiplier: 1.3,
    ),
  ];
}