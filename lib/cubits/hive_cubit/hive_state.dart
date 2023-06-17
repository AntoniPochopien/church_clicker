part of 'hive_cubit.dart';

class HiveState {
  double earnedMoney;
  int churchExp;
  int priestExp;
  List<UpgradeModel> ownedUpgradesPriestDb;
  List<UpgradeModel> ownedUpgradesChurchDb;
  HiveState({
    required this.churchExp,
    required this.priestExp,
    required this.earnedMoney,
    required this.ownedUpgradesPriestDb,
    required this.ownedUpgradesChurchDb,
  });

  HiveState copyWith({
    double? earnedMoney,
    List<UpgradeModel>? ownedUpgradesPriestDb,
    List<UpgradeModel>? ownedUpgradesChurchDb,
    int? churchExp,
    int? priestExp,
  }) {
    return HiveState(
      churchExp: churchExp ?? this.churchExp,
      priestExp: priestExp ?? this.priestExp,
      ownedUpgradesChurchDb:
          ownedUpgradesChurchDb ?? this.ownedUpgradesChurchDb,
      earnedMoney: earnedMoney ?? this.earnedMoney,
      ownedUpgradesPriestDb:
          ownedUpgradesPriestDb ?? this.ownedUpgradesPriestDb,
    );
  }
}
