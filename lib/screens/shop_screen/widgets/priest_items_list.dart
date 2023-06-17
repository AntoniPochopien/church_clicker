import 'package:church_clicker/models/upgrade_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' as math;

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
              priceMultiplier: 0,
              id: 0,
              currentLvl: 0,
              maxLvl: 0,
              price: 0,
              updateValue: 0,
              name: '',
              imgPath: '',
            ),
          )
          .currentLvl;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AbilitiesCubit, AbilitiesState>(
      builder: (context, abilitiesState) {
        return ListView.builder(
            itemCount: ShopItems.priestItems.length,
            itemBuilder: (context, index) {
              final item = ShopItems.priestItems[index];
              final ownedLvl = _calcualteOwnedLvl(
                  upgradeId: item.id,
                  ownedUpgradeIdList: abilitiesState.ownedUpgradesPriest);
              final price = item.price *
                  math.pow(item.priceMultiplier, item.currentLvl - 1);

              return BlocBuilder<AbilitiesCubit, AbilitiesState>(
                builder: (context, abilitiesState) {
                  return ItemWidget(
                    upgradeValue: item.updateValue,
                    imgPath: item.imgPath,
                    isPriestUpgrade: true,
                    isAvaliable: abilitiesState.earnedMoney >=
                            (price != 0 ? price : item.price) &&
                        item.maxLvl > ownedLvl,
                    onTap: BlocProvider.of<AbilitiesCubit>(context).buyUpgrade,
                    id: item.id,
                    maxLvl: item.maxLvl,
                    name: item.name,
                    ownedLvl: ownedLvl,
                    price: price != 0 ? price.toInt() : item.price,
                  );
                },
              );
            });
      },
    );
  }
}
