import 'package:church_clicker/cubits/church/church_cubit.dart';
import 'package:church_clicker/cubits/level_cubit/level_cubit.dart';
import 'package:church_clicker/widgets/level_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChurchScreen extends StatelessWidget {
  const ChurchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LevelCubit, LevelState>(
      builder: (context, levelState) {
        return BlocBuilder<ChurchCubit, ChurchState>(
          builder: (context, churchState) {
            return Stack(children: [
              SvgPicture.asset(
                'assets/images/svg/passive/passive_bg_1.svg',
                fit: BoxFit.cover,
              ),
              if (churchState.ownedUpgradesChurch.map((e) => e.id).contains(11))
                SvgPicture.asset(
                    'assets/images/svg/passive/passive_lvl_${levelState.lvl}.svg'),
              const LevelIndicator()
            ]);
          },
        );
      },
    );
  }
}
