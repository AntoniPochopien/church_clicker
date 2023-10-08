import 'package:church_clicker/cubits/aureola_cubit/aureola_cubit.dart';
import 'package:church_clicker/cubits/level_cubit/level_cubit.dart';
import 'package:church_clicker/extensions/int_extension.dart';
import 'package:church_clicker/models/animated_tap.dart';
import 'package:church_clicker/widgets/level_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

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
                    alignment: Alignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                Positioned.fill(
                                  child: Lottie.asset(
                                    'assets/lottie/active/active_bg_1.json',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    aureolaState is AureolaHiden
                                        ? const SizedBox()
                                        : SizedBox(
                                            height: 30,
                                            width: 75,
                                            child: CircularProgressIndicator(
                                              value:
                                                  aureolaState is AureolaLoading
                                                      ? aureolaState.value / 100
                                                      : 1,
                                              backgroundColor:
                                                  Colors.white.withOpacity(0.5),
                                              color: Colors.white,
                                            ),
                                          ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.45,
                                      child: Lottie.asset(
                                          'assets/lottie/active/active_lvl_${levelState.lvl < 1 ? 1 : levelState.lvl}.json'),
                                    ),
                                  ],
                                ),
                                if (aureolaState is AureolaFull)
                                  Positioned.fill(
                                    child: Lottie.asset(
                                      'assets/lottie/active/active_bg_light.json',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              color: const Color(0xFF292241),
                            ),
                          )
                        ],
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
