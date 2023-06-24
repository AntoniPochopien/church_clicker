import 'package:church_clicker/cubits/hive_cubit/hive_cubit.dart';
import 'package:church_clicker/screens/languages_screen/languages_screen.dart';
import 'package:church_clicker/services/google_ads_service.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import './cubit/navigation_cubit.dart';
import '../../cubits/abilities_cubit/abilities_cubit.dart';
import '../priest_screen/priest_screen.dart';
import '../church_screen/church_screen.dart';
import '../fortune_wheel_screen/fortune_wheel_screen.dart';
import '../shop_screen/shop_screen.dart';
import '../../widgets/pentagon_custom_clipper.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  static const String route = '/MainNavigationScreen';

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  final bool afterInit = false;
  final List<Widget> bodyContentList = [
    const PriestScreen(),
    const ChurchScreen(),
    const ShopScreen(),
    const FortuneWheelScreen(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<HiveCubit>(context, listen: false).save();
    GoogleAdsService().createRewardedAd();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      FlutterNativeSplash.remove();
    });
  }

  Widget buttonBuilder(
      {required BuildContext context, required int i, required int pageIndex}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: AspectRatio(
          aspectRatio: 1 / 1,
          child: ClipPath(
            clipper: PentagonCustomClipper(),
            child: Stack(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  color:
                      pageIndex == i ? Colors.white : const Color(0xFFd2d2d9),
                  child: SvgPicture.asset(
                    'assets/images/svg/menu/menu_${i + 1}.svg',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => BlocProvider.of<NavigationCubit>(context)
                          .changeIndex(i),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, navState) {
        return BlocBuilder<AbilitiesCubit, AbilitiesState>(
          builder: (context, abilitiesState) {
            return Scaffold(
              extendBodyBehindAppBar: true,
              extendBody: true,
              backgroundColor: const Color(0xFF292241),
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: true,
                title: Text(
                  abilitiesState.earnedMoney.toInt().toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 55),
                ),
                actions: [
                if(navState.currentIndex == 3 || navState.currentIndex == 2)  IconButton(
                    onPressed: () => Navigator.of(context).pushNamed(LanguagesScreen.route),
                    icon: const Icon(
                      Icons.settings,
                      color: Color(0xFFE10032),
                    ),
                  ),
                ],
              ),
              body: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: IndexedStack(
                  key: ValueKey<int>(navState.currentIndex),
                  index: navState.currentIndex,
                  children: bodyContentList,
                ),
              ),
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.all(16),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 100,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buttonBuilder(
                          context: context,
                          i: 0,
                          pageIndex: navState.currentIndex),
                      buttonBuilder(
                          context: context,
                          i: 1,
                          pageIndex: navState.currentIndex),
                      buttonBuilder(
                          context: context,
                          i: 2,
                          pageIndex: navState.currentIndex),
                      buttonBuilder(
                          context: context,
                          i: 3,
                          pageIndex: navState.currentIndex),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
