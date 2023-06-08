import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChurchScreen extends StatelessWidget {
  const ChurchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SvgPicture.asset(
        'assets/images/svg/passive/passive_bg_1.svg',
        fit: BoxFit.cover,
      ),
      SvgPicture.asset('assets/images/svg/passive/passive_lvl_1.svg')
    ]);
  }
}
