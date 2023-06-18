import 'package:church_clicker/data/shop_items.dart';
import 'package:church_clicker/models/upgrade_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../hive_cubit/hive_cubit.dart';

part 'abilities_state.dart';

class AbilitiesCubit extends Cubit<AbilitiesState> {
  AbilitiesCubit()
      : super(
          AbilitiesState(
            earnedMoney: 0,
            ownedUpgradesPriest: [],
          ),
        );

  late final HiveCubit hiveCubit;
  double tapValue = 1;

  void start(BuildContext ctx) {
    hiveCubit = ctx.read<HiveCubit>();
  }

  void buyUpgrade({required int upgradeId, required int price}) {
    final result = state.ownedUpgradesPriest
        .indexWhere((element) => element.id == upgradeId);
    if (result < 0) {
      final item = ShopItems.priestItems
          .firstWhere((element) => element.id == upgradeId);
      item.currentLvl += 1;
      state.ownedUpgradesPriest.add(item);
    } else {
      state.ownedUpgradesPriest[result].currentLvl += 1;
    }

    calculateTapPower();

    emit(
      state.copyWith(
        ownedUpgradesPriest: state.ownedUpgradesPriest,
        earnedMoney: state.earnedMoney - price,
      ),
    );

    hiveCubit.save(
      earnedMoney: state.earnedMoney,
      ownedUpgrades: state.ownedUpgradesPriest,
    );
  }

  void addEarningsFromChurch({required double v}) {
    emit(
      state.copyWith(
        earnedMoney: state.earnedMoney + v,
      ),
    );
    hiveCubit.save(earnedMoney: state.earnedMoney);
  }

  void setFromDb(
      {required double earnedMoneyDb,
      required List<UpgradeModel> ownedUpgradesDb}) {
    emit(
      state.copyWith(
        earnedMoney: earnedMoneyDb,
        ownedUpgradesPriest: ownedUpgradesDb,
      ),
    );
    calculateTapPower();
  }

  void tap() {
    emit(
      state.copyWith(earnedMoney: state.earnedMoney += tapValue),
    );
    hiveCubit.save(earnedMoney: state.earnedMoney);
    hiveCubit.saveAllEarings(priestEarings: tapValue);
  }

  void calculateTapPower() {
    double x = 1;
    state.ownedUpgradesPriest.forEach(
      (element) {
        x += element.updateValue * element.currentLvl;
      },
    );
    tapValue = x;
  }
}
