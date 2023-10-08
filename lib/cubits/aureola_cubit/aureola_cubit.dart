import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'aureola_state.dart';

class AureolaCubit extends Cubit<AureolaState> {
  AureolaCubit() : super(AureolaHiden());

  late StreamSubscription aureolaTimer;
  int taps = 0;
  int lastTapTime = 0;
  int gainedBonusTime = 0;
  int initialClicksForBonus = 100;

  void startAureolaTimer() {
    aureolaTimer = Stream.periodic(const Duration(seconds: 1), (i) {
      final now = DateTime.now().millisecondsSinceEpoch;
      if (gainedBonusTime >= now - 30000) {
        return;
      }
      if (lastTapTime <= now - 5000) {
        taps = 0;
      }
      if (lastTapTime <= now - 600 && taps > 0) {
        taps -= 1;
        emit(AureolaLoading(value: taps));
      }
      if (taps <= 1) {
        emit(AureolaHiden());
      }
    }).listen((event) {});
  }

  void tap() {
    final now = DateTime.now().millisecondsSinceEpoch;
    if (taps < initialClicksForBonus && gainedBonusTime <= now - 40000) {
      taps += 1;
      lastTapTime = now;
    }
    if (taps >= 5 &&
        taps < initialClicksForBonus &&
        gainedBonusTime <= now - 40000) {
      emit(AureolaLoading(value: taps));
    }
    if (taps >= initialClicksForBonus && gainedBonusTime <= now - 40000) {
      gainedBonusTime = now;
      initialClicksForBonus = (initialClicksForBonus * 1.5).round();
      emit(AureolaFull());
    }
  }
}
