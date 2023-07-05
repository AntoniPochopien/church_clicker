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
    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, languageState) {
        return Scaffold(
          backgroundColor: const Color(0xFF292241),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(
                  Icons.close,
                  color: Color(0xFFE10032),
                ),
              ),
            ],
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    AppLocalizations.of(context)!.language_select_language,
                    style: const TextStyle(color: Colors.white, fontSize: 30),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ...L10n.all.map(
                            (e) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: languageState.locale == e
                                      ? const Color(0xFFE10032)
                                      : Colors.white,
                                  shape: BeveledRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () {
                                  BlocProvider.of<LanguageCubit>(context)
                                      .setLocale(
                                          locale: Locale(e.languageCode));
                                },
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      L10n.getNativeLangName(e.languageCode),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: languageState.locale == e
                                              ? Colors.white
                                              : const Color(0xFF292241),
                                          fontSize: 25),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
