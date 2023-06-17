import 'package:church_clicker/cubits/abilities_cubit/abilities_cubit.dart';
import 'package:church_clicker/cubits/church/church_cubit.dart';
import 'package:church_clicker/models/upgrade_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return BlocBuilder<ChurchCubit, ChurchState>(
      builder: (context, churchState) {
        return SafeArea(
          bottom: false,
          child: Column(
            children: [
              const Text(
                'Ulepsz kościół',
                style: TextStyle(color: Colors.white),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: ShopItems.churchItems.length,
                    itemBuilder: (context, index) {
                      final item = ShopItems.churchItems[index];
                      final ownedLvl = _calcualteOwnedLvl(
                          upgradeId: item.id,
                          ownedUpgradeIdList: churchState.ownedUpgradesChurch);
                      final price = item.price * item.priceMultiplier;

                      return BlocBuilder<AbilitiesCubit, AbilitiesState>(
                        builder: (context, abilitiesState) {
                          return ItemWidget(
                            upgradeValue: item.updateValue,
                            imgPath: item.imgPath,
                            isAvaliable: abilitiesState.earnedMoney >=
                                    (price != 0 ? price : item.price) &&
                                item.maxLvl > ownedLvl,
                            isPriestUpgrade: false,
                            onTap: BlocProvider.of<ChurchCubit>(context)
                                .buyUpgrade,
                            id: item.id,
                            maxLvl: item.maxLvl,
                            name: item.name,
                            ownedLvl: ownedLvl,
                            price: price != 0 ? price.toInt() : item.price,
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
  }
}
