part of 'level_cubit.dart';

class LevelState {
  int lvl;

  LevelState({required this.lvl});

  LevelState copyWith({int? lvl}) {
    return LevelState(lvl: lvl ?? this.lvl);
  }
}
