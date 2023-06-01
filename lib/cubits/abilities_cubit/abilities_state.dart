part of 'abilities_cubit.dart';

class AbilitiesState {
  double earnedMoney;
  List<UpgradeModel> ownedUpgradesPriest;
  AbilitiesState(
      {required this.earnedMoney, required this.ownedUpgradesPriest});

  AbilitiesState copyWith(
      {double? earnedMoney, List<UpgradeModel>? ownedUpgradesPriest}) {
    return AbilitiesState(
      earnedMoney: earnedMoney ?? this.earnedMoney,
      ownedUpgradesPriest: ownedUpgradesPriest ?? this.ownedUpgradesPriest,
    );
  }
}
