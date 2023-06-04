import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

class FortuneWheelScreen extends StatefulWidget {
  FortuneWheelScreen({super.key});

  @override
  State<FortuneWheelScreen> createState() => _FortuneWheelScreenState();
}

class _FortuneWheelScreenState extends State<FortuneWheelScreen> {
  final StreamController<int> controller = StreamController<int>();
  String wonPrize = '';

  List<String> listaNagrod = ['cos', 'cos innego', 'jeszcze inne', 'cos super'];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: FortuneWheel(
          onFling: () {
            setState(
              () {
                final randomPosition = Fortune.randomInt(0, 3);
                controller.add(randomPosition);
                wonPrize = listaNagrod[randomPosition];
                print(wonPrize);
              },
            );
          },
          selected: controller.stream,
          items: [
            ...listaNagrod.map(
              (e) => FortuneItem(
                child: Text(e),
              ),
            ),
          ],
          onAnimationEnd: () => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(wonPrize),
            ),
          ),
        ),
      ),
    );
  }
}
