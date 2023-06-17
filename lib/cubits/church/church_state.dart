part of 'church_cubit.dart';

class ChurchState {
  double churchEarnings;
  List<UpgradeModel> ownedUpgradesChurch;

  ChurchState({
    required this.churchEarnings,
    required this.ownedUpgradesChurch,
  });

  ChurchState copyWith({
    double? churchEarnings,
    List<UpgradeModel>? ownedUpgradesChurch,
  }) {
    return ChurchState(
      churchEarnings: churchEarnings ?? this.churchEarnings,
      ownedUpgradesChurch: ownedUpgradesChurch ?? this.ownedUpgradesChurch,
    );
  }
}
