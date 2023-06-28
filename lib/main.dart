import 'package:church_clicker/cubits/church/church_cubit.dart';
import 'package:church_clicker/cubits/language_cubit/language_cubit.dart';
import 'package:church_clicker/cubits/level_cubit/level_cubit.dart';
import 'package:church_clicker/cubits/payment_cubit/payments_cubit.dart';
import 'package:church_clicker/l10n/l10n.dart';
import 'package:church_clicker/screens/fake_splashscreen/fake_splashscreen.dart';
import 'package:church_clicker/screens/languages_screen/languages_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import './cubits/hive_cubit/hive_cubit.dart';
import './screens/main_navigation_screen/cubit/navigation_cubit.dart';
import './screens/main_navigation_screen/main_navigation_screen.dart';
import './cubits/abilities_cubit/abilities_cubit.dart';
import './models/upgrade_model.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Hive.initFlutter();
  MobileAds.instance.initialize();
  Hive.registerAdapter(UpgradeModelAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LevelCubit()),
        BlocProvider(create: (context) => NavigationCubit()),
        BlocProvider(create: (context) => HiveCubit()),
        BlocProvider(create: (context) => AbilitiesCubit()..start(context)),
        BlocProvider(create: (context) => ChurchCubit()..start(context)),
        BlocProvider(create: (context) => LanguageCubit()..start(context)),
        BlocProvider(create: (context) => PaymentsCubit()..start(context))
      ],
      child: BlocBuilder<LanguageCubit, LanguageState>(
        builder: (context, languageState) {
          return MaterialApp(
            title: 'Church clicker',
            theme: ThemeData(
              fontFamily: 'PirataOne',
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            locale: languageState.locale,
            supportedLocales: L10n.all,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate
            ],
            initialRoute: FakeSplashscreen.route,
            routes: {
              FakeSplashscreen.route: (context) => const FakeSplashscreen(),
              MainNavigationScreen.route: (context) =>
                  const MainNavigationScreen(),
              LanguagesScreen.route: (context) => const LanguagesScreen(),
            },
          );
        },
      ),
    );
  }
}
