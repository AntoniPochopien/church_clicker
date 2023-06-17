import 'dart:async';

import 'package:church_clicker/cubits/abilities_cubit/abilities_cubit.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../hive_cubit/hive_cubit.dart';
import '../../models/upgrade_model.dart';
import '../../data/shop_items.dart';

part 'church_state.dart';

class ChurchCubit extends Cubit<ChurchState> {
  ChurchCubit()
      : super(
          ChurchState(
            exp: 0,
            churchEarnings: 0,
            ownedUpgradesChurch: [],
          ),
        );

  late StreamSubscription streamSubscription;
  late final HiveCubit hiveCubit;
  late final AbilitiesCubit abilitiesCubit;

  void start(BuildContext ctx) {
    hiveCubit = ctx.read<HiveCubit>();
    abilitiesCubit = ctx.read<AbilitiesCubit>();
    calculateChurchPower();
    calculateExp();
    streamSubscription = Stream.periodic(
      const Duration(seconds: 1),
    ).listen(
      (event) {
        abilitiesCubit.addEarningsFromChurch(state.churchEarnings);
      },
    );
  }

  void setOwnedUpgradesFromDb({
    required int exp,
    required List<UpgradeModel> ownedUpgradesChurch,
  }) {
    emit(
      state.copyWith(
        exp: exp,
        ownedUpgradesChurch: ownedUpgradesChurch,
      ),
    );
    calculateChurchPower();
    calculateExp();
  }

  void buyUpgrade({required int upgradeId, required int price}) {
    final result = state.ownedUpgradesChurch
        .indexWhere((element) => element.id == upgradeId);
    if (result < 0) {
      final item = ShopItems.churchItems
          .firstWhere((element) => element.id == upgradeId);
      item.currentLvl += 1;
      state.ownedUpgradesChurch.add(item);
    } else {
      state.ownedUpgradesChurch[result].currentLvl += 1;
    }

    abilitiesCubit.addEarningsFromChurch(-price.toDouble());
    emit(
      state.copyWith(
        ownedUpgradesChurch: state.ownedUpgradesChurch,
      ),
    );
    calculateChurchPower();
    calculateExp();
    hiveCubit.save(
      churchExp: state.exp,
      ownedUpgradesChurchDb: state.ownedUpgradesChurch,
    );
  }

  void calculateExp() {
    int x = 0;
    state.ownedUpgradesChurch.forEach((element) {
      x += element.exp * element.currentLvl;
    });
    emit(state.copyWith(exp: x));
  }

  void calculateChurchPower() {
    double x = 0;
    state.ownedUpgradesChurch.forEach(
      (element) {
        final v = element.updateValue * element.currentLvl;
        x += v;
      },
    );
    emit(
      state.copyWith(
        churchEarnings: x,
      ),
    );
  }
}
