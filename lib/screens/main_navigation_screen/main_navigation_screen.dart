import 'package:church_clicker/cubits/hive_cubit/hive_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import './cubit/navigation_cubit.dart';
import '../../cubits/abilities_cubit/abilities_cubit.dart';
import '../priest_screen/priest_screen.dart';
import '../church_screen/church_screen.dart';
import '../fortune_wheel_screen/fortune_wheel_screen.dart';
import '../shop_screen/shop_screen.dart';
import '../../widgets/pentagon_custom_clipper.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  static const String route = '/MainNavigationScreen';

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  final List<Widget> bodyContentList = [
    const PriestScreen(),
    const ChurchScreen(),
    const ShopScreen(),
    const FortuneWheelScreen(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<HiveCubit>(context, listen: false).save();
  }

  Widget buttonBuilder({required BuildContext context, required int index}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: AspectRatio(
          aspectRatio: 1 / 1,
          child: ClipPath(
            clipper: PentagonCustomClipper(),
            child: Stack(
              children: [
                Container(
                  color: Colors.white,
                  child: SvgPicture.asset(
                    'assets/images/svg/menu/menu_${index + 1}.svg',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => BlocProvider.of<NavigationCubit>(context)
                          .changeIndex(index),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, navState) {
        return BlocBuilder<AbilitiesCubit, AbilitiesState>(
          builder: (context, abilitiesState) {
            return Scaffold(
              extendBodyBehindAppBar: true,
              extendBody: true,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: true,
                title: Text(
                  abilitiesState.earnedMoney.toInt().toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 55),
                ),
              ),
              body: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: IndexedStack(
                  key: ValueKey<int>(navState.currentIndex),
                  index: navState.currentIndex,
                  children: bodyContentList,
                ),
              ),
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.all(16),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 100,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buttonBuilder(context: context, index: 0),
                      buttonBuilder(context: context, index: 1),
                      buttonBuilder(context: context, index: 2),
                      buttonBuilder(context: context, index: 3),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
