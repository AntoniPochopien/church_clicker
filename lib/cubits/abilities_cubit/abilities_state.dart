part of 'abilities_cubit.dart';

class AbilitiesState {
  double earnedMoney;
  double onTapPower;
  List<UpgradeModel> ownedUpgradesPriest;

  AbilitiesState({
    required this.onTapPower,
    required this.earnedMoney,
    required this.ownedUpgradesPriest,
  });

  AbilitiesState copyWith({
    double? onTapPower,
    double? earnedMoney,
    List<UpgradeModel>? ownedUpgradesPriest,
  }) {
    return AbilitiesState(
      onTapPower: onTapPower ?? this.onTapPower,
      earnedMoney: earnedMoney ?? this.earnedMoney,
      ownedUpgradesPriest: ownedUpgradesPriest ?? this.ownedUpgradesPriest,
    );
  }
}
