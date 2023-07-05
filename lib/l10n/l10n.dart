import 'package:flutter/material.dart';

class L10n {
  static final all = [
    const Locale('de'),
    const Locale('en'),
    const Locale('es'),
    const Locale('fr'),
    const Locale('it'),
    const Locale('ja'),
    const Locale('ko'),
    const Locale('pl'),
    const Locale('pt'),
    const Locale('ru'),
    const Locale('zh'),
  ];

  static String getNativeLangName(String langCode) {
    switch (langCode) {
      case 'en':
        return 'English';
      case 'pl':
        return 'Polski';
      case 'de':
        return 'Deutsch';
      case 'es':
        return 'Español';
      case 'fr':
        return 'Français';
      case 'it':
        return 'Italiano';
      case 'pt':
        return 'Português';
      case 'ru':
        return 'Русский';
      case 'ja':
        return '日本語';
      case 'ko':
        return '한국어';
      case 'zh':
        return '中文';
      default:
        return 'English';
    }
  }
}
