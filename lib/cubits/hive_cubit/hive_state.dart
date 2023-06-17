part of 'hive_cubit.dart';

class HiveState {
  double earnedMoney;
  double highestEarnings;
  List<UpgradeModel> ownedUpgradesPriestDb;
  List<UpgradeModel> ownedUpgradesChurchDb;
  HiveState({
    required this.highestEarnings,
    required this.earnedMoney,
    required this.ownedUpgradesPriestDb,
    required this.ownedUpgradesChurchDb,
  });

  HiveState copyWith({
    double? earnedMoney,
    List<UpgradeModel>? ownedUpgradesPriestDb,
    List<UpgradeModel>? ownedUpgradesChurchDb,
    double? highestEarnings,
  }) {
    return HiveState(
      highestEarnings: highestEarnings ?? this.highestEarnings,
      ownedUpgradesChurchDb:
          ownedUpgradesChurchDb ?? this.ownedUpgradesChurchDb,
      earnedMoney: earnedMoney ?? this.earnedMoney,
      ownedUpgradesPriestDb:
          ownedUpgradesPriestDb ?? this.ownedUpgradesPriestDb,
    );
  }
}
