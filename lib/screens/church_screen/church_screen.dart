import 'package:church_clicker/cubits/church/church_cubit.dart';
import 'package:church_clicker/cubits/level_cubit/level_cubit.dart';
import 'package:church_clicker/extensions/int_extension.dart';
import 'package:church_clicker/screens/church_screen/widgets/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rive/rive.dart';

class ChurchScreen extends StatefulWidget {
  const ChurchScreen({super.key});

  @override
  State<ChurchScreen> createState() => _ChurchScreenState();
}

class _ChurchScreenState extends State<ChurchScreen>
    with SingleTickerProviderStateMixin {
  final Tween<double> _tween = Tween<double>(
    begin: 1,
    end: 0,
  );
  late AnimationController _textController;
  late Animation<double> _textAnimation;

  @override
  void initState() {
    super.initState();
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _textAnimation = _tween.animate(_textController);
    _textController.repeat();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LevelCubit, LevelState>(
      builder: (context, levelState) {
        return BlocBuilder<ChurchCubit, ChurchState>(
          builder: (context, churchState) {
            int churchLvl =
                churchState.ownedUpgradesChurch.map((e) => e.id).contains(11)
                    ? churchState.ownedUpgradesChurch
                        .firstWhere((element) => element.id == 11)
                        .currentLvl
                    : 0;
            return Stack(children: [
              const RiveAnimation.asset(
                'assets/rive/passive/passive_bg_1.riv',
                fit: BoxFit.cover,
              ),
              if (churchLvl != 0)
                Positioned(
                  top: (_textAnimation.value * 100) + 100,
                  left: 0,
                  right: 0,
                  child: FadeTransition(
                    opacity: _textAnimation,
                    child: Text(
                      '+ ${churchState.churchEarnings.toInt().toShortenedString()}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.amber, fontSize: 45, height: 0),
                    ),
                  ),
                ),
              churchLvl != 0
                  ? Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: RiveAnimation.asset(
                          'assets/rive/passive/passive_lvl_$churchLvl.riv'),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: SvgPicture.asset(
                          'assets/images/svg/passive/passive_lvl_0.svg'),
                    ),
              SafeArea(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    '+ ${churchState.churchEarnings.toInt().toShortenedString()} / s',
                    style: const TextStyle(
                        color: Colors.white, fontSize: 33, height: 0),
                  ),
                ),
              ),
              if (churchLvl == 0)
                const Align(alignment: Alignment.center, child: OnBoarding())
            ]);
          },
        );
      },
    );
  }
}
