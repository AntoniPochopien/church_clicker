import 'dart:async';

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
    return Container(
      color: const Color(0xFF292241),
      child: SafeArea(
        child: Center(
          child: Stack(
            children: [
              Column(
                children: [
                  const Text(
                    'Obejrzyj reklamę i zakręć kołem',
                    style: TextStyle(fontSize: 28, color: Colors.amber),
                  ),
                  const Text(
                    'Pomnóż swój majątek!',
                    style: TextStyle(color: Colors.white, fontSize: 33),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
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
                    SizedBox(
                      width: 50,
                      height: 100,
                      child: SvgPicture.asset(
                        'assets/images/svg/general/wheel_indicator.svg',
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
                                final randomPosition = Fortune.randomInt(0, 5);
                                controller.add(randomPosition);
                                wonPrize = listaNagrod[randomPosition];
                              },
                            );
                          },
                          child: SizedBox(
                            width: double.infinity,
                            child: Text(
                              'Zakręć kołem'.toUpperCase(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 33, color: Colors.white),
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
  }
}
