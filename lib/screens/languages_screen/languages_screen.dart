import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguagesScreen extends StatelessWidget {
  const LanguagesScreen({super.key});

  static const String route = '/LanguagesScreen';

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const  Color(0xFF292241),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(AppLocalizations.of(context)!.language),
            ],
          ),
        ),
      ),
    );
  }
}
