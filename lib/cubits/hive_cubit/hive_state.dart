part of 'hive_cubit.dart';

class HiveState {
  bool isLoaded;
  double earnedMoney;
  double highestEarnings;
  List<UpgradeModel> ownedUpgradesPriestDb;
  List<UpgradeModel> ownedUpgradesChurchDb;
  HiveState({
    required this.isLoaded,
    required this.highestEarnings,
    required this.earnedMoney,
    required this.ownedUpgradesPriestDb,
    required this.ownedUpgradesChurchDb,
  });

  HiveState copyWith({
    bool? isLoaded,
    double? earnedMoney,
    List<UpgradeModel>? ownedUpgradesPriestDb,
    List<UpgradeModel>? ownedUpgradesChurchDb,
    double? highestEarnings,
  }) {
    return HiveState(
      isLoaded: isLoaded ?? this.isLoaded,
      highestEarnings: highestEarnings ?? this.highestEarnings,
      ownedUpgradesChurchDb:
          ownedUpgradesChurchDb ?? this.ownedUpgradesChurchDb,
      earnedMoney: earnedMoney ?? this.earnedMoney,
      ownedUpgradesPriestDb:
          ownedUpgradesPriestDb ?? this.ownedUpgradesPriestDb,
    );
  }
}
