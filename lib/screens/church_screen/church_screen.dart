import 'package:church_clicker/cubits/church/church_cubit.dart';
import 'package:church_clicker/cubits/level_cubit/level_cubit.dart';
import 'package:church_clicker/extensions/int_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';

class ChurchScreen extends StatelessWidget {
  const ChurchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LevelCubit, LevelState>(
      builder: (context, levelState) {
        return BlocBuilder<ChurchCubit, ChurchState>(
          builder: (context, churchState) {
            int churchLvl =
                churchState.ownedUpgradesChurch.map((e) => e.id).contains(11)
                    ? churchState.ownedUpgradesChurch
                        .firstWhere((element) => element.id == 11)
                        .currentLvl
                    : 0;
            return Stack(children: [
              const RiveAnimation.asset(
                'assets/rive/passive/passive_bg_1.riv',
                fit: BoxFit.fill,
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Text(
                  '+ ${churchState.churchEarnings.toInt().toShortenedString()}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.amber, fontSize: 33, height: 0),
                ),
              ),
              RiveAnimation.asset(
                  'assets/rive/passive/passive_lvl_${churchLvl + 1}.riv'),
              SafeArea(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    '+ ${churchState.churchEarnings.toInt().toShortenedString()} / s',
                    style: const TextStyle(
                        color: Colors.white, fontSize: 33, height: 0),
                  ),
                ),
              )
            ]);
          },
        );
      },
    );
  }
}
