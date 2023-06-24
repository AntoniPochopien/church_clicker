part of 'language_cubit.dart';

class LanguageState {
  Locale? locale;

  LanguageState({required this.locale});

  LanguageState copyWith({required Locale? locale}){
    return LanguageState(locale: locale ?? this.locale);
  }
}
