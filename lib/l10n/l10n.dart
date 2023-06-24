import 'package:flutter/material.dart';

class L10n{
  static final all = [
    const Locale('en'),
    const Locale('pl'),
  ];

  static String getNativeLangName(String langCode){
    switch (langCode){
      case 'en': return 'English';
      case 'pl': return 'Polski';
      default: return 'English';
    }
  }
}