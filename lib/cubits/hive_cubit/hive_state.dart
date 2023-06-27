part of 'hive_cubit.dart';

class HiveState {
  bool isLoaded;
  double earnedMoney;
  double allEarings;
  int avaliableSpins;
  String? locale;
  List<UpgradeModel> ownedUpgradesPriestDb;
  List<UpgradeModel> ownedUpgradesChurchDb;
  HiveState({
    required this.locale,
    required this.avaliableSpins,
    required this.isLoaded,
    required this.allEarings,
    required this.earnedMoney,
    required this.ownedUpgradesPriestDb,
    required this.ownedUpgradesChurchDb,
  });

  HiveState copyWith({
    String? locale,
    bool? isLoaded,
    double? earnedMoney,
    List<UpgradeModel>? ownedUpgradesPriestDb,
    List<UpgradeModel>? ownedUpgradesChurchDb,
    double? allEarings,
    int? avaliableSpins,
  }) {
    return HiveState(
      locale: locale ?? this.locale,
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
