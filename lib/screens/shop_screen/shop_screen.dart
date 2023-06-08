import 'package:church_clicker/screens/shop_screen/widgets/church_items_list.dart';
import 'package:flutter/material.dart';

import './widgets/priest_items_list.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final PageController _pageController = PageController(initialPage: 0);

  int _pageIndex = 0;

  void changeIndex(int i) {
    setState(() {
      _pageIndex = i;
    });
    _pageController.animateToPage(i,
        duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFEEEFDF),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: PageView(
              onPageChanged: (v) => setState(() => _pageIndex = v),
              controller: _pageController,
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 19.0),
                  child: PriestItemList(),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 19.0),
                  child: ChurchItemsList(),
                ),
              ],
            ),
          ),
          SafeArea(
            top: false,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 19,
                    ),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                _pageIndex == 0 ? Colors.red : Colors.pink),
                        onPressed: () => changeIndex(0),
                        child: const Icon(Icons.crop_square_sharp)),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 19),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                _pageIndex == 1 ? Colors.red : Colors.pink),
                        onPressed: () => changeIndex(1),
                        child: const Icon(Icons.crop_square_sharp)),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
