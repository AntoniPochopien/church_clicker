import 'package:church_clicker/cubits/abilities_cubit/abilities_cubit.dart';
import 'package:church_clicker/cubits/church/church_cubit.dart';
import 'package:church_clicker/models/upgrade_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math';

import '../../../data/shop_items.dart';
import './item_widget.dart';

class ChurchItemsList extends StatelessWidget {
  const ChurchItemsList({super.key});

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
    return BlocBuilder<ChurchCubit, ChurchState>(
      builder: (context, churchState) {
        return ListView.builder(
            itemCount: ShopItems.churchItems.length,
            itemBuilder: (context, index) {
              final ownedLvl = _calcualteOwnedLvl(
                  upgradeId: ShopItems.churchItems[index].id,
                  ownedUpgradeIdList: churchState.ownedUpgradesChurch);
              final price = ShopItems.churchItems[index].initialPrice *
                  pow(ShopItems.churchItems[index].priceMultiplier, ownedLvl)
                      .toDouble();

              return BlocBuilder<AbilitiesCubit, AbilitiesState>(
                builder: (context, abilitiesState) {
                  return ItemWidget(
                    isAvaliable: abilitiesState.earnedMoney >= price.toInt() &&
                        ShopItems.priestItems[index].maxLvl >= ownedLvl,
                    isPriestUpgrade: false,
                    onTap: BlocProvider.of<ChurchCubit>(context).buyUpgrade,
                    id: ShopItems.churchItems[index].id,
                    maxLvl: ShopItems.churchItems[index].maxLvl,
                    name: ShopItems.churchItems[index].name,
                    ownedLvl: ownedLvl,
                    price: ownedLvl != 0
                        ? price
                        : ShopItems.churchItems[index].initialPrice.toDouble(),
                  );
                },
              );
            });
      },
    );
  }
}
