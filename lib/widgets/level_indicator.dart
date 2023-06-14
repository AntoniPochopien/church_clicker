import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LevelIndicator extends StatelessWidget {
  final int currentExp;
  final int nextLvlExp;

  const LevelIndicator({
    super.key,
    required this.currentExp,
    required this.nextLvlExp,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          SvgPicture.asset(
            'assets/images/svg/general/level_indicator.svg',
            alignment: Alignment.topCenter,
          ),
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: currentExp.toDouble() /
                  nextLvlExp.toDouble() *
                  MediaQuery.of(context).size.width,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
