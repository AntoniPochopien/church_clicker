part of 'aureola_cubit.dart';

@immutable
sealed class AureolaState {}

final class AureolaHiden extends AureolaState {}

final class AureolaLoading extends AureolaState {
  final int value;

  AureolaLoading({required this.value});
}

final class AureolaFull extends AureolaState {}
