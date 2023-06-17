import '../models/upgrade_model.dart';

class ShopItems {
  static final List<UpgradeModel> priestItems = [
    UpgradeModel(
      id: 1,
      name: 'Na tace',
      currentLvl: 0,
      updateValue: 1,
      priceMultiplier: 1,
      price: 10,
      maxLvl: 100,
      exp: 2,
      imgPath: 'assets/images/svg/shop_passive/passive_item_1.svg',
    ),
    UpgradeModel(
      id: 2,
      name: 'Mównica',
      currentLvl: 0,
      updateValue: 2,
      priceMultiplier: 1.2,
      price: 150,
      maxLvl: 50,
      exp: 1,
      imgPath: 'assets/images/svg/shop_passive/passive_item_2.svg',
    ),
    UpgradeModel(
      id: 3,
      name: 'Mównica',
      currentLvl: 0,
      updateValue: 2,
      priceMultiplier: 1.4,
      price: 150,
      maxLvl: 50,
      exp: 1,
      imgPath: 'assets/images/svg/shop_passive/passive_item_3.svg',
    ),
    UpgradeModel(
      id: 3,
      name: 'Mównica',
      currentLvl: 0,
      updateValue: 2,
      priceMultiplier: 1.6,
      price: 150,
      maxLvl: 50,
      exp: 3,
      imgPath: 'assets/images/svg/shop_passive/passive_item_4.svg',
    ),
  ];

  static final List<UpgradeModel> churchItems = [
    UpgradeModel(
      id: 4,
      name: 'Nowy ministrant',
      updateValue: 1,
      priceMultiplier: 1.0,
      currentLvl: 0,
      price: 10,
      maxLvl: 100,
      exp: 2,
      imgPath: 'assets/images/svg/shop_passive/passive_item_1.svg',
    ),
    UpgradeModel(
      id: 5,
      name: 'Nagłośnienie',
      updateValue: 2,
      priceMultiplier: 2,
      currentLvl: 0,
      price: 150,
      maxLvl: 50,
      exp: 3,
      imgPath: 'assets/images/svg/shop_passive/passive_item_2.svg',
    ),
  ];
}
