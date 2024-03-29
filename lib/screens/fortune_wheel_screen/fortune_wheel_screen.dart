import 'dart:async';
import 'dart:math';

import 'package:church_clicker/cubits/abilities_cubit/abilities_cubit.dart';
import 'package:church_clicker/screens/fortune_wheel_screen/widgets/purchase_button.dart';
import 'package:church_clicker/screens/fortune_wheel_screen/widgets/wheel.dart';
import 'package:church_clicker/screens/fortune_wheel_screen/widgets/win_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:church_clicker/cubits/hive_cubit/hive_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../cubits/payment_cubit/payments_cubit.dart';
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
    return BlocBuilder<PaymentsCubit, PaymentsState>(
      builder: (context, paymentsState) {
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
                              FittedBox(
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .fortune_wheel_title,
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  style: const TextStyle(
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
                                    padding:
                                        const EdgeInsets.only(bottom: 45.0),
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 19.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    if (paymentsState.products.isNotEmpty)
                                      PurchaseButton(
                                          spinsAmount: 10,
                                          productDetails:
                                              paymentsState.products[0],
                                          productId:
                                              paymentsState.products[0].id),
                                    SizedBox(
                                      width: 50,
                                      height: 100,
                                      child: SvgPicture.asset(
                                        'assets/images/svg/general/wheel_indicator.svg',
                                      ),
                                    ),
                                    if (paymentsState.products.length > 1)
                                      PurchaseButton(
                                          spinsAmount: 3,
                                          productDetails:
                                              paymentsState.products[1],
                                          productId:
                                              paymentsState.products[1].id),
                                  ],
                                ),
                              ),
                              SafeArea(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 19),
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
                                            randomPosition =
                                                Random().nextInt(6);
                                            controller.add(randomPosition);
                                          },
                                        );
                                        await Future.delayed(
                                            const Duration(seconds: 5), () {
                                          showDialog(
                                            context: context,
                                            builder: (context) => WinDialog(
                                              v: abilitiesState.earnedMoney *
                                                      rewardsList[
                                                          randomPosition] -
                                                  abilitiesState.earnedMoney,
                                            ),
                                          );
                                          BlocProvider.of<AbilitiesCubit>(
                                                  context)
                                              .addFortuneWheelReward(
                                                  v: abilitiesState
                                                          .earnedMoney *
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
                                                      ? AppLocalizations.of(
                                                              context)!
                                                          .fortune_wheel_button_watch_ad
                                                      : AppLocalizations.of(
                                                              context)!
                                                          .fortune_wheel_spin,
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
      },
    );
  }
}
