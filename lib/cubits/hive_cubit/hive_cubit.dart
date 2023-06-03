import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../models/upgrade_model.dart';

part 'hive_state.dart';

class HiveCubit extends Cubit<HiveState> {
  HiveCubit()
      : super(
          HiveState(
            earnedMoney: 0,
            ownedUpgradesPriestDb: [],
            ownedUpgradesChurchDb: [],
          ),
        );

  late Box box;

  void start() async {
    box = await Hive.openBox('MyBox');
    emit(
      state.copyWith(
        earnedMoney: box.get('earnedMoney') ?? 0,
        ownedUpgradesPriestDb:
            box.get('ownedUpgradesPriestDb')?.cast<UpgradeModel>().toList() ??
                [],
        ownedUpgradesChurchDb:
            box.get('ownedUpgradesChurchDb')?.cast<UpgradeModel>().toList() ??
                [],
      ),
    );
  }

  void save({
    double? earnedMoney,
    List<UpgradeModel>? ownedUpgrades,
    List<UpgradeModel>? ownedUpgradesChurchDb,
  }) {
    box.put('earnedMoney', earnedMoney ?? state.earnedMoney);
    box.put(
        'ownedUpgradesPriestDb', ownedUpgrades ?? state.ownedUpgradesPriestDb);
    box.put('ownedUpgradesChurchDb',
        ownedUpgradesChurchDb ?? state.ownedUpgradesChurchDb);
  }
}
