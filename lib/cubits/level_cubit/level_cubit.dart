import 'package:flutter_bloc/flutter_bloc.dart';
part 'level_state.dart';

class LevelCubit extends Cubit<LevelState> {
  LevelCubit()
      : super(LevelState(
          lvl: 1,
        ));

  void setLvl({required int lvl}) {
    emit(state.copyWith(lvl: lvl));
  }
}
