import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:church_clicker/cubits/hive_cubit/hive_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FortuneWheelScreen extends StatefulWidget {
  const FortuneWheelScreen({super.key});

  @override
  State<FortuneWheelScreen> createState() => _FortuneWheelScreenState();
}

class _FortuneWheelScreenState extends State<FortuneWheelScreen> {
  final StreamController<int> controller = StreamController<int>();
  String wonPrize = '';

  List<String> listaNagrod = [
    '2',
    '3',
    '1.5',
    '2',
    '3',
    '1.5',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HiveCubit, HiveState>(
      builder: (context, hiveState) {
        return Container(
          color: const Color(0xFF292241),
          child: SafeArea(
            child: Center(
              child: Stack(
                children: [
                  Column(
                    children: [
                      const Text(
                        'Pomnóż swój majątek kręcąc kołem',
                        style: TextStyle(fontSize: 28, color: Colors.amber),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            hiveState.avaliableSpins.toString(),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 55),
                          ),
                          SizedBox(
                            height: 45,
                            width: 55,
                            child: SvgPicture.asset(
                              'assets/images/svg/general/gold.svg',
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 45.0),
                          child: FortuneWheel(
                            indicators: const [],
                            alignment: Alignment.bottomCenter,
                            animateFirst: false,
                            physics: NoPanPhysics(),
                            selected: controller.stream,
                            items: [
                              ...listaNagrod.asMap().entries.map(
                                (e) {
                                  int i = e.key;
                                  String v = e.value;
                                  return FortuneItem(
                                    child: RotatedBox(
                                        quarterTurns: 3, child: Text('x $v')),
                                    style: FortuneItemStyle(
                                      borderWidth: 3,
                                      borderColor: Colors.black,
                                      color: i % 2 == 0
                                          ? const Color(0xFFA80022)
                                          : const Color(0xFFE10032),
                                      textStyle: const TextStyle(
                                        fontFamily: 'PirataOne',
                                        fontSize: 32,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                            onAnimationEnd: () =>
                                ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(wonPrize),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 19.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: BeveledRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () {},
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          '10',
                                          style: TextStyle(
                                              color: Color(0xFFE10032),
                                              fontSize: 30),
                                        ),
                                        SizedBox(
                                          height: 22,
                                          width: 28,
                                          child: SvgPicture.asset(
                                            'assets/images/svg/general/gold.svg',
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Text(
                                      '9,99 zł',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 22),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 50,
                                height: 100,
                                child: SvgPicture.asset(
                                  'assets/images/svg/general/wheel_indicator.svg',
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: BeveledRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () {},
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          '3',
                                          style: TextStyle(
                                              color: Color(0xFFE10032),
                                              fontSize: 30),
                                        ),
                                        SizedBox(
                                          height: 22,
                                          width: 28,
                                          child: SvgPicture.asset(
                                            'assets/images/svg/general/gold.svg',
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Text(
                                      '4,99 zł',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 22),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 19),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFE10032),
                                shape: BeveledRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                setState(
                                  () {
                                    final randomPosition =
                                        Fortune.randomInt(0, 5);
                                    controller.add(randomPosition);
                                    wonPrize = listaNagrod[randomPosition];
                                  },
                                );
                              },
                              child: SizedBox(
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: FittedBox(
                                        child: Text(
                                          hiveState.avaliableSpins == 0
                                              ? 'Obejrzyj reklamę aby zdobyć 1'
                                                  .toUpperCase()
                                              : 'Zakręć kołem za 1'
                                                  .toUpperCase(),
                                          style: const TextStyle(
                                              fontSize: 33,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 33,
                                      width: 40,
                                      child: SvgPicture.asset(
                                        'assets/images/svg/general/gold.svg',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
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
