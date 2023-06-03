import 'package:church_clicker/cubits/abilities_cubit/abilities_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemWidget extends StatelessWidget {
  final int id;
  final double price;
  final String name;
  final int ownedLvl;
  final int maxLvl;
  const ItemWidget({
    super.key,
    required this.id,
    required this.maxLvl,
    required this.name,
    required this.ownedLvl,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AbilitiesCubit, AbilitiesState>(
      builder: (context, abilitiesState) {
        return GestureDetector(
          onTap: () {
            if (abilitiesState.earnedMoney >= price.toInt() &&
                maxLvl >= ownedLvl) {
              BlocProvider.of<AbilitiesCubit>(context)
                  .buyUpgrade(upgradeId: id, price: price.round());
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              color: (abilitiesState.earnedMoney >= price.toInt())
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
      },
    );
  }
}
