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

  Tween<double> lvlInterval(double v) {
    final levelCubit = BlocProvider.of<LevelCubit>(context, listen: false);
    print('dupa interval $v');
    if (v >= 0 && v <= 100) {
      //10000
      levelCubit.setLvl(lvl: 1);
      return Tween(begin: 0, end: 100); //10000
    } else if (v > 100 && v <= 100000) {
      //100000
      levelCubit.setLvl(lvl: 2);
      return Tween(begin: 100, end: 100000); //100000
    } else if (v > 100000 && v <= 500000) {
      levelCubit.setLvl(lvl: 3);
      return Tween(begin: 100000, end: 500000);
    } else if (v > 500000 && v <= 2500000) {
      levelCubit.setLvl(lvl: 4);
      return Tween(begin: 500000, end: 2500000);
    } else if (v > 2500000 && v <= 7500000) {
      levelCubit.setLvl(lvl: 5);
      return Tween(begin: 2500000, end: 7500000);
    } else {
      levelCubit.setLvl(lvl: 6);
      return Tween(begin: 7500000, end: 99999999);
    }
  }

  double _calculateLevelWidth({required double highestEarnings}) {
    final interval = lvlInterval(highestEarnings);
    final x = (100 * highestEarnings) / interval.end!;
    final y = (x * size.width) / 100;
    print('dupa obliczona szerokosc $y');
    return y;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HiveCubit, HiveState>(
      builder: (context, hiveState) {
        return SafeArea(
          child: SizedBox(
            width: double.infinity,
            height: 60,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
              child: Stack(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
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
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: AnimatedContainer(
                            height: 10,
                            width: _calculateLevelWidth(
                                highestEarnings: hiveState.highestEarnings),
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
        );
      },
    );
  }
}
