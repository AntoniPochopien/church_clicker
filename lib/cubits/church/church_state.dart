part of 'church_cubit.dart';

class ChurchState {
  int exp;
  double churchEarnings;
  List<UpgradeModel> ownedUpgradesChurch;

  ChurchState({
    required this.exp,
    required this.churchEarnings,
    required this.ownedUpgradesChurch,
  });

  ChurchState copyWith(
      {double? churchEarnings,
      List<UpgradeModel>? ownedUpgradesChurch,
      int? exp}) {
    return ChurchState(
      exp: exp ?? this.exp,
      churchEarnings: churchEarnings ?? this.churchEarnings,
      ownedUpgradesChurch: ownedUpgradesChurch ?? this.ownedUpgradesChurch,
    );
  }
}
