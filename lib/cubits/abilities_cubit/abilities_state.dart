part of 'abilities_cubit.dart';

class AbilitiesState {
  double earnedMoney;
  List<UpgradeModel> ownedUpgradesPriest;
  int exp;

  AbilitiesState({
    required this.exp,
    required this.earnedMoney,
    required this.ownedUpgradesPriest,
  });

  AbilitiesState copyWith({
    int? exp,
    double? earnedMoney,
    List<UpgradeModel>? ownedUpgradesPriest,
  }) {
    return AbilitiesState(
      exp: exp ?? this.exp,
      earnedMoney: earnedMoney ?? this.earnedMoney,
      ownedUpgradesPriest: ownedUpgradesPriest ?? this.ownedUpgradesPriest,
    );
  }
}
