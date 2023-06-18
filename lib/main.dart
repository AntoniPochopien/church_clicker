import 'package:church_clicker/cubits/church/church_cubit.dart';
import 'package:church_clicker/screens/fake_splashscreen/fake_splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import './cubits/hive_cubit/hive_cubit.dart';
import './screens/main_navigation_screen/cubit/navigation_cubit.dart';
import './screens/main_navigation_screen/main_navigation_screen.dart';
import './cubits/abilities_cubit/abilities_cubit.dart';
import './models/upgrade_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UpgradeModelAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NavigationCubit()),
        BlocProvider(create: (context) => HiveCubit()..start()),
        BlocProvider(create: (context) => AbilitiesCubit()..start(context)),
        BlocProvider(create: (context) => ChurchCubit()..start(context)),
      ],
      child: MaterialApp(
        title: 'Church clicker',
        theme: ThemeData(
          fontFamily: 'PirataOne',
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/FakeSplashscreen',
        routes: {
          '/FakeSplashscreen': (context) => const FakeSplashscreen(),
          '/MainNavigationScreen': (context) => const MainNavigationScreen()
        },
      ),
    );
  }
}
