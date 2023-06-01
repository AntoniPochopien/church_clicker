part of 'hive_cubit.dart';

class HiveState {
  double earnedMoney;
  List<UpgradeModel> ownedUpgradesDb;
  HiveState({required this.earnedMoney, required this.ownedUpgradesDb});

  HiveState copyWith(
      {double? earnedMoney, List<UpgradeModel>? ownedUpgradesDb}) {
    return HiveState(
      earnedMoney: earnedMoney ?? this.earnedMoney,
      ownedUpgradesDb: ownedUpgradesDb ?? this.ownedUpgradesDb,
    );
  }
}
