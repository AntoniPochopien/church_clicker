import 'package:flutter/material.dart';

class ItemWidget extends StatelessWidget {
  final int id;
  final double price;
  final String name;
  final int ownedLvl;
  final int maxLvl;
  final bool isPriestUpgrade;
  final Function onTap;
  final bool isAvaliable;
  const ItemWidget({
    super.key,
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
    return GestureDetector(
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
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('zdjecie'),
                Column(
                  children: [
                    Text(name),
                    Text('${ownedLvl}/${maxLvl}'),
                  ],
                ),
                Text(price.toInt().toString())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
