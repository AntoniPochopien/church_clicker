import 'package:church_clicker/cubits/level_cubit/level_cubit.dart';
import 'package:church_clicker/widgets/level_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../cubits/abilities_cubit/abilities_cubit.dart';

class PriestScreen extends StatefulWidget {
  const PriestScreen({super.key});

  @override
  State<PriestScreen> createState() => _PriestScreenState();
}

class _PriestScreenState extends State<PriestScreen> {
  List<Offset> onTapElements = [];

  void _onTapDown(TapDownDetails details) {
    setState(() {
      onTapElements
          .add(Offset(details.globalPosition.dx, details.globalPosition.dy));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LevelCubit, LevelState>(
      builder: (context, levelState) {
        return BlocBuilder<AbilitiesCubit, AbilitiesState>(
          builder: (context, abilitiesState) {
            return GestureDetector(
              onTapDown: (details) {
                _onTapDown(details);
                BlocProvider.of<AbilitiesCubit>(context).tap();
              },
              child: Stack(
                children: [
                  SvgPicture.asset(
                    'assets/images/svg/active/active_bg_1.svg',
                    fit: BoxFit.cover,
                  ),
                  SvgPicture.asset(
                      'assets/images/svg/active/active_lvl_${levelState.lvl < 1 ? 1 : levelState.lvl}.svg'),
                  const LevelIndicator(),
                  ...onTapElements.map(
                    (e) => Positioned(
                      top: e.dy,
                      left: e.dx,
                      child: Text(
                        abilitiesState.onTapPower.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
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
