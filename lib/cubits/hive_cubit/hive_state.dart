part of 'hive_cubit.dart';

class HiveState {
  bool isLoaded;
  double earnedMoney;
  double allEarings;
  int avaliableSpins;
  List<UpgradeModel> ownedUpgradesPriestDb;
  List<UpgradeModel> ownedUpgradesChurchDb;
  HiveState({
    required this.avaliableSpins,
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
    int? avaliableSpins,
  }) {
    return HiveState(
      avaliableSpins: avaliableSpins ?? this.avaliableSpins,
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
