import 'package:church_clicker/cubits/aureola_cubit/aureola_cubit.dart';
import 'package:church_clicker/cubits/level_cubit/level_cubit.dart';
import 'package:church_clicker/extensions/int_extension.dart';
import 'package:church_clicker/models/animated_tap.dart';
import 'package:church_clicker/widgets/level_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';

import '../../cubits/abilities_cubit/abilities_cubit.dart';

class PriestScreen extends StatefulWidget {
  const PriestScreen({super.key});

  @override
  State<PriestScreen> createState() => _PriestScreenState();
}

class _PriestScreenState extends State<PriestScreen>
    with TickerProviderStateMixin {
  List<AnimatedTap> tapObjects = [];

  void addObject(Offset position) {
    final AnimationController controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );

    controller.forward().then(
        (_) => controller.reverse().then((value) => removeObjects(controller)));

    setState(() {
      tapObjects.add(AnimatedTap(position: position, controller: controller));
    });
  }

  void removeObjects(AnimationController controller) {
    setState(() {
      tapObjects.removeWhere((object) => object.controller == controller);
      controller.dispose();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LevelCubit, LevelState>(
      builder: (context, levelState) {
        return BlocBuilder<AbilitiesCubit, AbilitiesState>(
          builder: (context, abilitiesState) {
            return BlocBuilder<AureolaCubit, AureolaState>(
              builder: (context, aureolaState) {
                return GestureDetector(
                  onTapDown: (details) {
                    addObject(Offset(
                        details.globalPosition.dx, details.globalPosition.dy));
                    BlocProvider.of<AureolaCubit>(context).tap();
                    BlocProvider.of<AbilitiesCubit>(context)
                        .tap(isBonus: aureolaState is AureolaFull);
                  },
                  child: Stack(
                    children: [
                      const RiveAnimation.asset(
                        'assets/rive/active/active_bg_1.riv',
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: RiveAnimation.asset(
                            'assets/rive/active/active_lvl_${levelState.lvl < 1 ? 1 : levelState.lvl}.riv'),
                      ),
                      aureolaState is AureolaHiden
                          ? const SizedBox()
                          : Align(
                              alignment: Alignment.center,
                              child: SizedBox(
                                height: 20,
                                width: 50,
                                child: CircularProgressIndicator(
                                  value: aureolaState is AureolaLoading
                                      ? aureolaState.value / 100
                                      : null,
                                  backgroundColor:
                                      Colors.white.withOpacity(0.5),
                                  color: Colors.white,
                                ),
                              ),
                            ),
                      const LevelIndicator(),
                      ...tapObjects.map(
                        (e) => AnimatedBuilder(
                          animation: e.controller,
                          builder: (BuildContext context, Widget? child) {
                            return Positioned(
                              top: (e.position.dy - 50) -
                                  (e.controller.value * 80),
                              left: e.position.dx,
                              child: Opacity(
                                opacity: e.controller.value,
                                child: Text(
                                  '+ ${abilitiesState.onTapPower.toInt().toShortenedString()} ${aureolaState is AureolaFull ? 'x2' : ''}',
                                  style: const TextStyle(
                                      color: Colors.amber, fontSize: 25),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
