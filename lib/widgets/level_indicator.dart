import 'package:church_clicker/cubits/hive_cubit/hive_cubit.dart';
import 'package:church_clicker/cubits/level_cubit/level_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:measure_size/measure_size.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LevelIndicator extends StatefulWidget {
  const LevelIndicator({super.key});

  @override
  State<LevelIndicator> createState() => _LevelIndicatorState();
}

class _LevelIndicatorState extends State<LevelIndicator> {
  Size size = const Size(20, 20);
  final List<String> priestNames = [
    'dziad xd',
    'cos',
    'Ministrant',
    'Diakon',
    'Kapłan',
    'Arcybiskup',
    'Papież'
  ];

  Tween<double> lvlInterval(double v) {
    final levelCubit = BlocProvider.of<LevelCubit>(context, listen: false);
    if (v >= 0 && v <= 20) {
      levelCubit.setLvl(lvl: 1);
      return Tween(begin: 0, end: 20);
    } else if (v > 20 && v <= 40) {
      levelCubit.setLvl(lvl: 2);
      return Tween(begin: 20, end: 40);
    } else if (v > 40 && v <= 60) {
      levelCubit.setLvl(lvl: 3);
      return Tween(begin: 40, end: 60);
    } else if (v > 60 && v <= 80) {
      levelCubit.setLvl(lvl: 4);
      return Tween(begin: 60, end: 80);
    } else if (v > 80 && v <= 100) {
      levelCubit.setLvl(lvl: 5);
      return Tween(begin: 80, end: 100);
    } else {
      levelCubit.setLvl(lvl: 6);
      return Tween(begin: 100, end: 99999999);
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
                    priestNames[levelState.lvl],
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
