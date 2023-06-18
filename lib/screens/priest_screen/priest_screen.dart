import 'package:church_clicker/cubits/level_cubit/level_cubit.dart';
import 'package:church_clicker/widgets/level_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../cubits/abilities_cubit/abilities_cubit.dart';

class PriestScreen extends StatelessWidget {
  const PriestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LevelCubit, LevelState>(
      builder: (context, levelState) {
        return BlocBuilder<AbilitiesCubit, AbilitiesState>(
          builder: (context, abilitiesState) {
            return GestureDetector(
              onTap: () => BlocProvider.of<AbilitiesCubit>(context).tap(),
              child: Stack(
                children: [
                  SvgPicture.asset(
                    'assets/images/svg/active/active_bg_1.svg',
                    fit: BoxFit.cover,
                  ),
                  SvgPicture.asset(
                      'assets/images/svg/active/active_lvl_${levelState.lvl < 1 ? 1 : levelState.lvl}.svg'),
                  const LevelIndicator()
                ],
              ),
            );
          },
        );
      },
    );
  }
}
