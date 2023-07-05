import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/upgrade_model.dart';

class ShopItems {
  static final List<UpgradeModel> priestItems = [
    UpgradeModel(
      id: 1,
      updateValue: 1,
      priceMultiplier: 1.1,
      currentLvl: 0,
      price: 100,
      maxLvl: 100,
      imgPath: 'assets/images/svg/shop_active/active_item_1.svg',
    ),
    UpgradeModel(
      id: 2,
      updateValue: 2,
      priceMultiplier: 1.16,
      currentLvl: 0,
      price: 190,
      maxLvl: 100,
      imgPath: 'assets/images/svg/shop_active/active_item_2.svg',
    ),
    UpgradeModel(
      id: 3,
      updateValue: 3,
      priceMultiplier: 1.21,
      currentLvl: 0,
      price: 280,
      maxLvl: 100,
      imgPath: 'assets/images/svg/shop_active/active_item_3.svg',
    ),
    UpgradeModel(
      id: 4,
      updateValue: 4,
      priceMultiplier: 1.27,
      currentLvl: 0,
      price: 370,
      maxLvl: 100,
      imgPath: 'assets/images/svg/shop_active/active_item_4.svg',
    ),
    UpgradeModel(
      id: 5,
      updateValue: 5,
      priceMultiplier: 1.34,
      currentLvl: 0,
      price: 460,
      maxLvl: 100,
      imgPath: 'assets/images/svg/shop_active/active_item_5.svg',
    ),
    UpgradeModel(
      id: 6,
      updateValue: 6,
      priceMultiplier: 1.40,
      currentLvl: 0,
      price: 550,
      maxLvl: 100,
      imgPath: 'assets/images/svg/shop_active/active_item_6.svg',
    ),
    UpgradeModel(
      id: 7,
      updateValue: 7,
      priceMultiplier: 1.47,
      currentLvl: 0,
      price: 640,
      maxLvl: 100,
      imgPath: 'assets/images/svg/shop_active/active_item_7.svg',
    ),
    UpgradeModel(
      id: 8,
      updateValue: 8,
      priceMultiplier: 1.55,
      currentLvl: 0,
      price: 730,
      maxLvl: 100,
      imgPath: 'assets/images/svg/shop_active/active_item_8.svg',
    ),
    UpgradeModel(
      id: 9,
      updateValue: 9,
      priceMultiplier: 1.63,
      currentLvl: 0,
      price: 820,
      maxLvl: 100,
      imgPath: 'assets/images/svg/shop_active/active_item_9.svg',
    ),
    UpgradeModel(
      id: 10,
      updateValue: 10,
      priceMultiplier: 1.71,
      currentLvl: 0,
      price: 910,
      maxLvl: 100,
      imgPath: 'assets/images/svg/shop_active/active_item_10.svg',
    ),
  ];

  static final List<UpgradeModel> churchItems = [
    UpgradeModel(
      id: 11,
      currentLvl: 0,
      updateValue: 10,
      priceMultiplier: 20,
      price: 1000,
      maxLvl: 6,
      imgPath: 'assets/images/svg/shop_passive/passive_item_1.svg',
    ),
    UpgradeModel(
      id: 12,
      currentLvl: 0,
      updateValue: 1,
      priceMultiplier: 1.1,
      price: 1000,
      maxLvl: 100,
      imgPath: 'assets/images/svg/shop_passive/passive_item_2.svg',
    ),
    UpgradeModel(
      id: 13,
      currentLvl: 0,
      updateValue: 2,
      priceMultiplier: 1.16,
      price: 2100,
      maxLvl: 100,
      imgPath: 'assets/images/svg/shop_passive/passive_item_3.svg',
    ),
    UpgradeModel(
      id: 14,
      currentLvl: 0,
      updateValue: 3,
      priceMultiplier: 1.21,
      price: 3200,
      maxLvl: 100,
      imgPath: 'assets/images/svg/shop_passive/passive_item_4.svg',
    ),
    UpgradeModel(
      id: 15,
      currentLvl: 0,
      updateValue: 4,
      priceMultiplier: 1.27,
      price: 4300,
      maxLvl: 100,
      imgPath: 'assets/images/svg/shop_passive/passive_item_5.svg',
    ),
    UpgradeModel(
      id: 16,
      currentLvl: 0,
      updateValue: 5,
      priceMultiplier: 1.34,
      price: 5400,
      maxLvl: 100,
      imgPath: 'assets/images/svg/shop_passive/passive_item_6.svg',
    ),
    UpgradeModel(
      id: 17,
      currentLvl: 0,
      updateValue: 6,
      priceMultiplier: 1.40,
      price: 6500,
      maxLvl: 100,
      imgPath: 'assets/images/svg/shop_passive/passive_item_7.svg',
    ),
    UpgradeModel(
      id: 18,
      currentLvl: 0,
      updateValue: 7,
      priceMultiplier: 1.47,
      price: 7600,
      maxLvl: 100,
      imgPath: 'assets/images/svg/shop_passive/passive_item_8.svg',
    ),
    UpgradeModel(
      id: 19,
      currentLvl: 0,
      updateValue: 8,
      priceMultiplier: 1.55,
      price: 8700,
      maxLvl: 100,
      imgPath: 'assets/images/svg/shop_passive/passive_item_9.svg',
    ),
    UpgradeModel(
      id: 20,
      currentLvl: 0,
      updateValue: 9,
      priceMultiplier: 1.63,
      price: 9800,
      maxLvl: 100,
      imgPath: 'assets/images/svg/shop_passive/passive_item_10.svg',
    ),
  ];

  //translations of item names
  static Map<int, String> itemNames(BuildContext context) => {
        1: AppLocalizations.of(context)!.priest_item_1,
        2: AppLocalizations.of(context)!.priest_item_2,
        3: AppLocalizations.of(context)!.priest_item_3,
        4: AppLocalizations.of(context)!.priest_item_4,
        5: AppLocalizations.of(context)!.priest_item_5,
        6: AppLocalizations.of(context)!.priest_item_6,
        7: AppLocalizations.of(context)!.priest_item_7,
        8: AppLocalizations.of(context)!.priest_item_8,
        9: AppLocalizations.of(context)!.priest_item_9,
        10: AppLocalizations.of(context)!.priest_item_10,
        11: AppLocalizations.of(context)!.church_item_1,
        12: AppLocalizations.of(context)!.church_item_2,
        13: AppLocalizations.of(context)!.church_item_3,
        14: AppLocalizations.of(context)!.church_item_4,
        15: AppLocalizations.of(context)!.church_item_5,
        16: AppLocalizations.of(context)!.church_item_6,
        17: AppLocalizations.of(context)!.church_item_7,
        18: AppLocalizations.of(context)!.church_item_8,
        19: AppLocalizations.of(context)!.church_item_9,
        20: AppLocalizations.of(context)!.church_item_10,
      };
}
