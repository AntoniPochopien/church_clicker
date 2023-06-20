import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

class Wheel extends StatelessWidget {
  final StreamController<int> controller;

  const Wheel({super.key, required this.controller});

  static const List<String> listaNagrod = [
    '2',
    '3',
    '1.5',
    '2',
    '3',
    '1.5',
  ];

  @override
  Widget build(BuildContext context) {
    return FortuneWheel(
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
              child: RotatedBox(quarterTurns: 3, child: Text('x $v')),
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
      onAnimationEnd: () {},
    );
  }
}
