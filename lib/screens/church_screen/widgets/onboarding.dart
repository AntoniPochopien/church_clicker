import 'package:church_clicker/cubits/abilities_cubit/abilities_cubit.dart';
import 'package:church_clicker/cubits/church/church_cubit.dart';
import 'package:church_clicker/data/shop_items.dart';
import 'package:church_clicker/widgets/pentagon_custom_clipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AbilitiesCubit, AbilitiesState>(
      builder: (context, abilitiesState) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ClipPath(
            clipper: PentagonCustomClipper(),
            child: Material(
              elevation: 4,
              color: Colors.transparent,
              child: ClipPath(
                clipper: PentagonCustomClipper(),
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 150,
                          height: 150,
                          child: SvgPicture.asset(
                              'assets/images/svg/passive/passive_lvl_1.svg'),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        const Text(
                          'Kup i ulepszaj kościoły!\n+ 10 na sekundę',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 23,
                            color: Color(0xFF152937),
                          ),
                        ),
                        Text(
                          ShopItems.churchItems[0].price.toString(),
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
                            if (abilitiesState.earnedMoney >=
                                ShopItems.churchItems[0].price) {
                              BlocProvider.of<ChurchCubit>(context).buyUpgrade(
                                  upgradeId: ShopItems.churchItems[0].id,
                                  price: ShopItems.churchItems[0].price);
                            }
                          },
                          child: const SizedBox(
                            width: double.infinity,
                            child: Text(
                              'Kup!',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
