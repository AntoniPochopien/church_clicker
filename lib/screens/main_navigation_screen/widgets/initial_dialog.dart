import 'package:church_clicker/cubits/abilities_cubit/abilities_cubit.dart';
import 'package:church_clicker/extensions/int_extension.dart';
import 'package:church_clicker/services/google_ads_service.dart';
import 'package:church_clicker/widgets/pentagon_custom_clipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lottie/lottie.dart';

class InitialDialog extends StatefulWidget {
  final int lastTimePLayed;
  final int churchEarnings;
  const InitialDialog(
      {super.key, required this.lastTimePLayed, required this.churchEarnings});

  @override
  State<InitialDialog> createState() => _InitialDialogState();
}

class _InitialDialogState extends State<InitialDialog> {
  bool alreadyWatched = false;
  late int earnedMoney;

  @override
  void initState() {
    super.initState();
    earnedMoney = (widget.churchEarnings * 0.01).toInt() *
        (widget.lastTimePLayed ~/ 1000);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<AbilitiesCubit>(context)
            .addOutsideEarnings(v: earnedMoney.toDouble());
        return true;
      },
      child: Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () {
                          BlocProvider.of<AbilitiesCubit>(context)
                              .addOutsideEarnings(v: earnedMoney.toDouble());
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.close_rounded,
                          size: 50,
                          color: Color(0xFFE10032),
                        ),
                      ),
                    ],
                  ),
                  ClipPath(
                    clipper: PentagonCustomClipper(),
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(
                              height: 18,
                            ),
                            Text(
                              AppLocalizations.of(context)!.popup_title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 23,
                                color: Color(0xFF152937),
                              ),
                            ),
                            Text(
                              earnedMoney.toShortenedString(),
                              style: const TextStyle(
                                fontSize: 66,
                                color: Color(0xFFA00022),
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFE10032),
                                foregroundColor: Colors.white,
                                shape: BeveledRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              onPressed: () {
                                if (alreadyWatched) {
                                  BlocProvider.of<AbilitiesCubit>(context)
                                      .addOutsideEarnings(
                                          v: earnedMoney.toDouble());
                                  Navigator.pop(context);
                                } else {
                                  GoogleAdsService().showRewardedAd(
                                      onEarnRewardCallback: () {
                                    setState(() {
                                      alreadyWatched = true;
                                      earnedMoney = earnedMoney * 2;
                                    });
                                  });
                                }
                              },
                              child: Text(
                                alreadyWatched
                                    ? 'OK!'
                                    : AppLocalizations.of(context)!
                                        .popup_button,
                                style: const TextStyle(fontSize: 24),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: -145,
              child: IgnorePointer(
                child: SizedBox(
                    width: 250,
                    child: LottieBuilder.asset(
                      'assets/lottie/money.json',
                      repeat: false,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
