part of 'hive_cubit.dart';

class HiveState {
  bool isLoaded;
  double earnedMoney;
  double allEarings;
  List<UpgradeModel> ownedUpgradesPriestDb;
  List<UpgradeModel> ownedUpgradesChurchDb;
  HiveState({
    required this.isLoaded,
    required this.allEarings,
    required this.earnedMoney,
    required this.ownedUpgradesPriestDb,
    required this.ownedUpgradesChurchDb,
  });

  HiveState copyWith({
    bool? isLoaded,
    double? earnedMoney,
    List<UpgradeModel>? ownedUpgradesPriestDb,
    List<UpgradeModel>? ownedUpgradesChurchDb,
    double? allEarings,
  }) {
    return HiveState(
      isLoaded: isLoaded ?? this.isLoaded,
      allEarings: allEarings ?? this.allEarings,
      ownedUpgradesChurchDb:
          ownedUpgradesChurchDb ?? this.ownedUpgradesChurchDb,
      earnedMoney: earnedMoney ?? this.earnedMoney,
      ownedUpgradesPriestDb:
          ownedUpgradesPriestDb ?? this.ownedUpgradesPriestDb,
    );
  }
}
