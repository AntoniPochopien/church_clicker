import 'dart:async';
import 'dart:math';

import 'package:church_clicker/cubits/abilities_cubit/abilities_cubit.dart';
import 'package:church_clicker/screens/fortune_wheel_screen/widgets/wheel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:church_clicker/cubits/hive_cubit/hive_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_svg/flutter_svg.dart';

import '../../services/google_ads_service.dart';

class FortuneWheelScreen extends StatefulWidget {
  const FortuneWheelScreen({super.key});

  @override
  State<FortuneWheelScreen> createState() => _FortuneWheelScreenState();
}

class _FortuneWheelScreenState extends State<FortuneWheelScreen> {
  final StreamController<int> controller = StreamController<int>();
  bool isSpining = false;
  final List<double> rewardsList = [
    1.5,
    2,
    3,
    1.5,
    2,
    3,
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AbilitiesCubit, AbilitiesState>(
      builder: (context, abilitiesState) {
        return BlocBuilder<HiveCubit, HiveState>(
          builder: (context, hiveState) {
            return SafeArea(
                child: Center(
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 19.0),
                        child: Column(
                          children: [
                            const FittedBox(
                              child: Text(
                                'Pomnóż swój majątek kręcąc kołem',
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 28, color: Colors.amber),
                              ),
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
                                  child: Wheel(
                                    rewardsList: rewardsList,
                                    controller: controller,
                                  )),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 19.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                              color: Colors.black,
                                              fontSize: 22),
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
                                              color: Colors.black,
                                              fontSize: 22),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SafeArea(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 19),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFE10032),
                                    shape: BeveledRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () async {
                                    if (isSpining) return;
                                    if (hiveState.avaliableSpins > 0) {
                                      int randomPosition = 0;
                                      isSpining = true;
                                      setState(
                                        () {
                                          BlocProvider.of<HiveCubit>(context)
                                              .deleteSpin();
                                          randomPosition = Random().nextInt(6);
                                          controller.add(randomPosition);
                                        },
                                      );
                                      await Future.delayed(
                                          const Duration(seconds: 5), () {
                                        BlocProvider.of<AbilitiesCubit>(context)
                                            .addFortuneWheelReward(
                                                v: abilitiesState.earnedMoney *
                                                    rewardsList[
                                                        randomPosition]);
                                      });
                                      isSpining = false;
                                    } else {
                                      GoogleAdsService().showRewardedAd(
                                          onEarnRewardCallback: () {
                                        BlocProvider.of<HiveCubit>(context)
                                            .addSpin(amount: 1);
                                      });
                                    }
                                  },
                                  child: ConstrainedBox(
                                    constraints:
                                        const BoxConstraints(minHeight: 50),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Flexible(
                                            child: FittedBox(
                                              child: Text(
                                                hiveState.avaliableSpins == 0
                                                    ? AppLocalizations.of(context)!.fortune_wheel_button_watch_ad
                                                        
                                                    : AppLocalizations.of(context)!.fortune_wheel_spin
                                                       ,
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
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
         
            );
          },
        );
      },
    );
  }
}
