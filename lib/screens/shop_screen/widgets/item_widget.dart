import 'package:church_clicker/cubits/abilities_cubit/abilities_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemWidget extends StatelessWidget {
  final int id;
  final int price;
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
    return GestureDetector(
      onTap: () => BlocProvider.of<AbilitiesCubit>(context)
          .buyUpgrade(upgradeId: id, price: price),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Container(
          color: Colors.white,
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
                Text(price.toString())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
