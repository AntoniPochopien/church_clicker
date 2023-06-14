import 'package:church_clicker/widgets/pentagon_custom_clipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemWidget extends StatelessWidget {
  final int id;
  final double price;
  final String name;
  final int ownedLvl;
  final int maxLvl;
  final bool isPriestUpgrade;
  final Function onTap;
  final bool isAvaliable;
  final String imgPath;
  const ItemWidget({
    super.key,
    required this.imgPath,
    required this.onTap,
    required this.isAvaliable,
    required this.isPriestUpgrade,
    required this.id,
    required this.maxLvl,
    required this.name,
    required this.ownedLvl,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: PentagonCustomClipper(),
      child: GestureDetector(
        onTap: () {
          if (isAvaliable) {
            //abilitiesState.earnedMoney >= price.toInt() && maxLvl >= ownedLvl
            onTap(upgradeId: id, price: price.round());
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            color: (isAvaliable) //abilitiesState.earnedMoney >= price.toInt()
                ? Colors.white
                : (maxLvl >= ownedLvl)
                    ? Colors.grey
                    : Colors.amber,
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Container(
                constraints: const BoxConstraints(maxHeight: 80),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: SvgPicture.asset(
                        imgPath,
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.bottomCenter,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Text(name),
                          Text('${ownedLvl}/${maxLvl}'),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        price.toInt().toString(),
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
  }
}
