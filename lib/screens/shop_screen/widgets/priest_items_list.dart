import 'package:church_clicker/models/upgrade_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math';

import '../../../data/shop_items.dart';
import '../../../cubits/abilities_cubit/abilities_cubit.dart';
import './item_widget.dart';

class PriestItemList extends StatelessWidget {
  const PriestItemList({super.key});

  int _calcualteOwnedLvl({
    required int upgradeId,
    required List<UpgradeModel> ownedUpgradeIdList,
  }) =>
      ownedUpgradeIdList
          .firstWhere(
            (element) => element.id == upgradeId,
            orElse: () => UpgradeModel(
                id: 0,
                currentLvl: 0,
                maxLvl: 0,
                initialPrice: 0,
                churchInitialBonus: 0,
                hitInitialBonus: 0,
                hitMultiplier: 0,
                name: '',
                priceMultiplier: 0),
          )
          .currentLvl;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AbilitiesCubit, AbilitiesState>(
      builder: (context, abilitiesState) {
        return ListView.builder(
            itemCount: ShopItems.priestItems.length,
            itemBuilder: (context, index) {
              final ownedLvl = _calcualteOwnedLvl(
                  upgradeId: ShopItems.priestItems[index].id,
                  ownedUpgradeIdList: abilitiesState.ownedUpgradesPriest);
              final price = ShopItems.priestItems[index].initialPrice *
                  pow(ShopItems.priestItems[index].priceMultiplier, ownedLvl)
                      .toDouble();

              return ItemWidget(
                id: ShopItems.priestItems[index].id,
                maxLvl: ShopItems.priestItems[index].maxLvl,
                name: ShopItems.priestItems[index].name,
                ownedLvl: ownedLvl,
                price: ownedLvl != 0
                    ? price
                    : ShopItems.priestItems[index].initialPrice.toDouble(),
              );
            });
      },
    );
  }
}
