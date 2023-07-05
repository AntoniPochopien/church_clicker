import 'package:church_clicker/cubits/hive_cubit/hive_cubit.dart';
import 'package:church_clicker/cubits/level_cubit/level_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:measure_size/measure_size.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LevelIndicator extends StatefulWidget {
  const LevelIndicator({super.key});

  @override
  State<LevelIndicator> createState() => _LevelIndicatorState();
}

class _LevelIndicatorState extends State<LevelIndicator> {
  Size size = const Size(20, 20);

  Tween<double> lvlInterval(double v) {
    final levelCubit = BlocProvider.of<LevelCubit>(context, listen: false);
    if (v >= 0 && v < 100) {
      levelCubit.setLvl(lvl: 1);
      return Tween(begin: 0, end: 100);
    } else if (v >= 100 && v < 10000) {
      levelCubit.setLvl(lvl: 2);
      return Tween(begin: 100, end: 10000);
    } else if (v >= 10000 && v < 100000) {
      levelCubit.setLvl(lvl: 3);
      return Tween(begin: 10000, end: 100000);
    } else if (v >= 100000 && v < 1000000) {
      levelCubit.setLvl(lvl: 4);
      return Tween(begin: 100000, end: 1000000);
    } else if (v >= 1000000 && v < 10000000) {
      levelCubit.setLvl(lvl: 5);
      return Tween(begin: 1000000, end: 10000000);
    } else {
      levelCubit.setLvl(lvl: 6);
      return Tween(begin: 10000000, end: double.infinity);
    }
  }

  double _calculateLevelWidth({required double highestEarnings}) {
    final interval = lvlInterval(highestEarnings);
    final x =
        (highestEarnings - interval.begin!) / (interval.end! - interval.begin!);
    final y = x * size.width;
    return y;
  }

  @override
  Widget build(BuildContext context) {
    final List<String> priestNames = [
      AppLocalizations.of(context)!.priest_lvl_1,
      AppLocalizations.of(context)!.priest_lvl_2,
      AppLocalizations.of(context)!.priest_lvl_3,
      AppLocalizations.of(context)!.priest_lvl_4,
      AppLocalizations.of(context)!.priest_lvl_5,
      AppLocalizations.of(context)!.priest_lvl_6,
    ];
    return BlocBuilder<LevelCubit, LevelState>(
      builder: (context, levelState) {
        return BlocBuilder<HiveCubit, HiveState>(
          builder: (context, hiveState) {
            return SafeArea(
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 10),
                      child: Stack(
                        children: [
                          Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18.0),
                              child: MeasureSize(
                                onChange: (s) => setState(() => size = s),
                                child: Container(
                                  width: double.infinity,
                                  height: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            child: SizedBox(
                              width: 40,
                              height: 40,
                              child: SvgPicture.asset(
                                'assets/images/svg/general/bar_left.svg',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            child: SizedBox(
                              width: 40,
                              height: 40,
                              child: SvgPicture.asset(
                                'assets/images/svg/general/bar_right.svg',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Positioned(
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 32.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: AnimatedContainer(
                                    height: 10,
                                    width: _calculateLevelWidth(
                                        highestEarnings: hiveState.allEarings),
                                    duration: const Duration(milliseconds: 300),
                                    color: Colors.amber,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Text(
                    priestNames[levelState.lvl - 1],
                    style: const TextStyle(
                        color: Colors.white, fontSize: 33, height: 0),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
