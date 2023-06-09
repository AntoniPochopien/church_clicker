import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../shop_screen/widgets/items_list.dart';

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
    return  Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: PageView(
              onPageChanged: (v) => setState(() => _pageIndex = v),
              controller: _pageController,
              children:  [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 19.0),
                  child: ItemsList(isChurch: false, title: AppLocalizations.of(context)!.shop_upgrade_priest),
                ),
                Padding(
                  padding:const EdgeInsets.symmetric(horizontal: 19.0),
                  child: ItemsList(isChurch: true, title: AppLocalizations.of(context)!.shop_upgrade_church),
                ),
              ],
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 19.0, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: const BeveledRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                          ),
                        ),
                        backgroundColor: _pageIndex == 0
                            ? const Color(0xFFE10032)
                            : const Color(0xFFA80022),
                      ),
                      onPressed: () => changeIndex(0),
                      child:  Text(
                        AppLocalizations.of(context)!.shop_priest,
                        style:const TextStyle(color: Colors.white, fontSize: 22),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: const BeveledRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                        ),
                        backgroundColor: _pageIndex == 1
                            ? const Color(0xFFE10032)
                            : const Color(0xFFA80022),
                      ),
                      onPressed: () => changeIndex(1),
                      child:  Text(
                        AppLocalizations.of(context)!.shop_church,
                        style:const TextStyle(color: Colors.white, fontSize: 22),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
     
    );
  }
}
