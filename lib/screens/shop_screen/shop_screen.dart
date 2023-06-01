import 'package:flutter/material.dart';

import './widgets/priest_items_list.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFEEEFDF),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 19.0),
              child: PriestItemList(),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.2), //New
                    blurRadius: 10.0,
                    offset: Offset(0, -1))
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 19, vertical: 22),
                    child: ElevatedButton(
                        onPressed: () {}, child: Icon(Icons.crop_square_sharp)),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {}, child: Icon(Icons.crop_square_sharp)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
