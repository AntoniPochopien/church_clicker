import 'package:church_clicker/cubits/language_cubit/language_cubit.dart';
import 'package:church_clicker/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguagesScreen extends StatelessWidget {
  const LanguagesScreen({super.key});

  static const String route = '/LanguagesScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF292241),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                AppLocalizations.of(context)!.language,
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              ...L10n.all.map(
                (e) => ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<LanguageCubit>(context)
                        .setLocale(locale: Locale(e.languageCode));
                  },
                  child: Text(L10n.getNativeLangName(e.languageCode)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
