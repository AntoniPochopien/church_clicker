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
    streamSubscription = Stream.periodic(
      const Duration(seconds: 1),
    ).listen(
      (event) {
        print(state.churchEarnings);
        abilitiesCubit.addEarningsFromChurch(state.churchEarnings);
      },
    );
  }

  void setOwnedUpgradesFromDb({
    required List<UpgradeModel> ownedUpgradesChurch,
  }) {
    emit(
      state.copyWith(
        ownedUpgradesChurch: ownedUpgradesChurch,
      ),
    );
    calculateChurchPower();
  }

  void buyUpgrade({required int upgradeId, required int price}) {
    final result = state.ownedUpgradesChurch
        .indexWhere((element) => element.id == upgradeId);
    print(upgradeId);
    if (result < 0) {
      final item = ShopItems.churchItems
          .firstWhere((element) => element.id == upgradeId);
      item.currentLvl += 1;
      state.ownedUpgradesChurch.add(item);
    } else {
      state.ownedUpgradesChurch[result].currentLvl += 1;
    }
    state.ownedUpgradesChurch.forEach(
      (element) => print(element.currentLvl),
    );

    abilitiesCubit.addEarningsFromChurch(-price.toDouble());
    emit(
      state.copyWith(
        ownedUpgradesChurch: state.ownedUpgradesChurch,
      ),
    );
    hiveCubit.save(
      ownedUpgradesChurchDb: state.ownedUpgradesChurch,
    );
    calculateChurchPower();
  }

  void calculateChurchPower() {
    state.churchEarnings = 0;
    print('calculate');
    state.ownedUpgradesChurch.forEach(
      (element) {
        final x = (element.hitInitialBonus * element.currentLvl) *
            element.hitMultiplier;
        print('x : ${state.churchEarnings + x}');
        if ((state.churchEarnings + x).floor() <= state.churchEarnings) {
          state.churchEarnings += element.currentLvl;
          print('floor ${state.churchEarnings}');
        } else {
          state.churchEarnings += x;
          print('no floor ${state.churchEarnings}');
        }
      },
    );
    print('final wynik ${state.churchEarnings}');
    emit(
      state.copyWith(
        churchEarnings: state.churchEarnings,
      ),
    );
  }
}
