import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../models/upgrade_model.dart';

part 'hive_state.dart';

class HiveCubit extends Cubit<HiveState> {
  HiveCubit()
      : super(
          HiveState(
            lastPlayedTime: 0,
            locale: null,
            avaliableSpins: 0,
            isLoaded: false,
            allEarings: 0,
            earnedMoney: 0,
            ownedUpgradesPriestDb: [],
            ownedUpgradesChurchDb: [],
          ),
        ) {
    init();
  }

  late Box box;

  void init() async {
    box = await Hive.openBox('MyBox');
    emit(
      state.copyWith(
        lastPlayedTime: box.get('lastPlayedTime',
            defaultValue: DateTime.now().millisecondsSinceEpoch),
        locale: box.get('locale'),
        avaliableSpins: box.get('avaliableSpins', defaultValue: 0),
        allEarings: box.get('allEarings', defaultValue: 0.0),
        earnedMoney: box.get('earnedMoney', defaultValue: 0.0),
        ownedUpgradesPriestDb:
            box.get('ownedUpgradesPriestDb')?.cast<UpgradeModel>().toList() ??
                [],
        ownedUpgradesChurchDb:
            box.get('ownedUpgradesChurchDb')?.cast<UpgradeModel>().toList() ??
                [],
        isLoaded: true,
      ),
    );
  }

  void save({
    String? locale,
    double? earnedMoney,
    double? allEarings,
    int? avaliableSpins,
    List<UpgradeModel>? ownedUpgrades,
    List<UpgradeModel>? ownedUpgradesChurchDb,
  }) {
    box.put('lastPlayedTime', DateTime.now().millisecondsSinceEpoch);
    box.put('locale', locale ?? state.locale);
    box.put('avaliableSpins', avaliableSpins ?? state.avaliableSpins);
    box.put('earnedMoney', earnedMoney ?? state.earnedMoney);
    box.put(
        'ownedUpgradesPriestDb', ownedUpgrades ?? state.ownedUpgradesPriestDb);
    box.put('ownedUpgradesChurchDb',
        ownedUpgradesChurchDb ?? state.ownedUpgradesChurchDb);
  }

  void addSpin({required int amount}) {
    emit(state.copyWith(avaliableSpins: state.avaliableSpins + amount));
  }

  void deleteSpin() {
    emit(state.copyWith(avaliableSpins: state.avaliableSpins - 1));
  }

  void saveAllEarings({required double priestEarings}) {
    box.put('allEarings', state.allEarings + priestEarings);
    emit(
      state.copyWith(allEarings: state.allEarings + priestEarings),
    );
  }
}
