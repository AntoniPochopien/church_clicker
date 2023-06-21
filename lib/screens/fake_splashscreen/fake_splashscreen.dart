import 'package:church_clicker/cubits/abilities_cubit/abilities_cubit.dart';
import 'package:church_clicker/cubits/church/church_cubit.dart';
import 'package:church_clicker/cubits/hive_cubit/hive_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FakeSplashscreen extends StatefulWidget {
  const FakeSplashscreen({super.key});

  static const String route = '/FakeSplashscreen';

  @override
  State<FakeSplashscreen> createState() => _FakeSplashscreenState();
}

class _FakeSplashscreenState extends State<FakeSplashscreen> {
  bool isRouted = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<HiveCubit, HiveState>(
      listener: (context, hiveState) {
        if (isRouted == false && hiveState.isLoaded) {
          isRouted = true;
          BlocProvider.of<AbilitiesCubit>(context).setFromDb(
              earnedMoneyDb: hiveState.earnedMoney,
              ownedUpgradesDb: hiveState.ownedUpgradesPriestDb);
          BlocProvider.of<ChurchCubit>(context).setOwnedUpgradesFromDb(
            ownedUpgradesChurch: hiveState.ownedUpgradesChurchDb,
          );
          Navigator.of(context).pushReplacementNamed('/MainNavigationScreen');
        }
      },
      child: const Scaffold(
        backgroundColor: Color(0xFF292241),
        body: Center(),
      ),
    );
  }
}
