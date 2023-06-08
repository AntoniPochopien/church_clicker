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
    return Center(
      child: Column(
        children: [
          Expanded(
            child: FortuneWheel(
              animateFirst: false,
              physics: NoPanPhysics(),
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
          SafeArea(
            child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    final randomPosition = Fortune.randomInt(0, 3);
                    controller.add(randomPosition);
                    wonPrize = listaNagrod[randomPosition];
                  });
                },
                child: Text('spin')),
          )
        ],
      ),
    );
  }
}
