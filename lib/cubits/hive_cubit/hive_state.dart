part of 'hive_cubit.dart';

class HiveState {
  double earnedMoney;
  List<UpgradeModel> ownedUpgradesPriestDb;
  List<UpgradeModel> ownedUpgradesChurchDb;
  HiveState({
    required this.earnedMoney,
    required this.ownedUpgradesPriestDb,
    required this.ownedUpgradesChurchDb,
  });

  HiveState copyWith(
      {double? earnedMoney,
      List<UpgradeModel>? ownedUpgradesPriestDb,
      List<UpgradeModel>? ownedUpgradesChurchDb}) {
    return HiveState(
      ownedUpgradesChurchDb:
          ownedUpgradesChurchDb ?? this.ownedUpgradesChurchDb,
      earnedMoney: earnedMoney ?? this.earnedMoney,
      ownedUpgradesPriestDb:
          ownedUpgradesPriestDb ?? this.ownedUpgradesPriestDb,
    );
  }
}
