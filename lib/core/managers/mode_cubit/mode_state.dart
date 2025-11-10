part of 'mode_cubit.dart';

 
sealed class ModeState {}

final class ModeInitial extends ModeState {}

final class Modechanged extends ModeState {
  final String mode;

  Modechanged({required this.mode});
}
