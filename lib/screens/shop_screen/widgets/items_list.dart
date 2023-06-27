import 'package:church_clicker/cubits/abilities_cubit/abilities_cubit.dart';
import 'package:church_clicker/cubits/church/church_cubit.dart';
import 'package:church_clicker/models/upgrade_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' as math;

import '../../../data/shop_items.dart';
import './item_widget.dart';

class ItemsList extends StatelessWidget {
  final bool isChurch;
  final String title;
  const ItemsList({super.key, required this.isChurch, required this.title});

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
              imgPath: '',
            ),
          )
          .currentLvl;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChurchCubit, ChurchState>(
      builder: (context, churchState) {
        return BlocBuilder<AbilitiesCubit, AbilitiesState>(
          builder: (context, abilitiesState) {
            return SafeArea(
              bottom: false,
              child: Column(
                children: [
                  Text(
                    title,
                    style: const TextStyle(color: Colors.white, fontSize: 33),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: isChurch
                            ? ShopItems.churchItems.length
                            : ShopItems.priestItems.length,
                        itemBuilder: (context, index) {
                          final item = isChurch
                              ? ShopItems.churchItems[index]
                              : ShopItems.priestItems[index];
                          final ownedLvl = _calcualteOwnedLvl(
                              upgradeId: item.id,
                              ownedUpgradeIdList: isChurch
                                  ? churchState.ownedUpgradesChurch
                                  : abilitiesState.ownedUpgradesPriest);
                          final price = item.price *
                              math.pow(item.priceMultiplier, ownedLvl);

                          return BlocBuilder<AbilitiesCubit, AbilitiesState>(
                            builder: (context, abilitiesState) {
                              return ItemWidget(
                                upgradeValue: item.updateValue,
                                imgPath: item.imgPath,
                                isAvaliable: abilitiesState.earnedMoney >=
                                        (price != 0 ? price : item.price) &&
                                    item.maxLvl > ownedLvl,
                                isPriestUpgrade: !isChurch,
                                onTap: isChurch
                                    ? BlocProvider.of<ChurchCubit>(context)
                                        .buyUpgrade
                                    : BlocProvider.of<AbilitiesCubit>(context)
                                        .buyUpgrade,
                                id: item.id,
                                maxLvl: item.maxLvl,
                                name: ShopItems.itemNames(context)[item.id]!,
                                ownedLvl: ownedLvl,
                                price:
                                    ownedLvl != 0 ? price.toInt() : item.price,
                              );
                            },
                          );
                        }),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
