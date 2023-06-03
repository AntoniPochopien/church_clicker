import 'package:church_clicker/cubits/church/church_cubit.dart';
import 'package:church_clicker/cubits/hive_cubit/hive_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './cubit/navigation_cubit.dart';
import '../../cubits/abilities_cubit/abilities_cubit.dart';
import '../tap_screen/tap_screen.dart';
import '../church_screen/church_screen.dart';
import '../fortune_wheel_screen/fortune_wheel_screen.dart';
import '../shop_screen/shop_screen.dart';

class MainNavigationScreen extends StatelessWidget {
  MainNavigationScreen({super.key});
  final List<Widget> bodyContentList = [
    TapScreen(),
    ChurchScreen(),
    ShopScreen(),
    FortuneWheelScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, navState) {
        return BlocBuilder<AbilitiesCubit, AbilitiesState>(
          builder: (context, abilitiesState) {
            return BlocListener<HiveCubit, HiveState>(
              listener: (context, hiveState) {
                BlocProvider.of<AbilitiesCubit>(context).setFromDb(
                    earnedMoneyDb: hiveState.earnedMoney,
                    ownedUpgradesDb: hiveState.ownedUpgradesPriestDb);
                BlocProvider.of<ChurchCubit>(context).setOwnedUpgradesFromDb(
                  ownedUpgradesChurch: hiveState.ownedUpgradesChurchDb,
                );
              },
              child: Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: Column(
                    children: [
                      Text('złoto'),
                      Text(abilitiesState.earnedMoney.toStringAsFixed(1)),
                    ],
                  ),
                ),
                body: IndexedStack(
                  index: navState.currentIndex,
                  children: bodyContentList,
                ),
                bottomNavigationBar: BottomNavigationBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    currentIndex: navState.currentIndex,
                    fixedColor: Colors.black,
                    unselectedItemColor: Colors.black,
                    onTap: (i) => BlocProvider.of<NavigationCubit>(context)
                        .changeIndex(i),
                    items: const [
                      BottomNavigationBarItem(icon: Icon(Icons.abc), label: ''),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.church), label: ''),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.book), label: ''),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.percent), label: ''),
                    ]),
              ),
            );
          },
        );
      },
    );
  }
}
