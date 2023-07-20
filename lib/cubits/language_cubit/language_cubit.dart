import 'package:church_clicker/cubits/hive_cubit/hive_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageState(locale: null));

  late HiveCubit hiveCubit;

  void start(BuildContext ctx) {
    hiveCubit = ctx.read<HiveCubit>();
  }

  void setLocale({required Locale locale}) {
    emit(state.copyWith(locale: locale));
    hiveCubit.setLocale(locale: locale.languageCode);
  }
}
