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
        abilitiesCubit.addEarningsFromChurch(v: state.churchEarnings);
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
    if (result < 0) {
      final item = ShopItems.churchItems
          .firstWhere((element) => element.id == upgradeId);
      item.currentLvl += 1;
      state.ownedUpgradesChurch.add(item);
    } else {
      state.ownedUpgradesChurch[result].currentLvl += 1;
    }

    abilitiesCubit.addEarningsFromChurch(v: -price.toDouble());
    emit(
      state.copyWith(
        ownedUpgradesChurch: state.ownedUpgradesChurch,
      ),
    );
    calculateChurchPower();

    hiveCubit.save(
      ownedUpgradesChurchDb: state.ownedUpgradesChurch,
    );
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
