import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageState(locale: null));

  void setLocale({required Locale locale}){
    emit(state.copyWith(locale: locale));
  }
}
