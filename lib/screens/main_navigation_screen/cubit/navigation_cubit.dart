import 'package:flutter_bloc/flutter_bloc.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationState(currentIndex: 0));

  void changeIndex(int i) {
    emit(state.copyWith(currentIndex: i));
  }
}
