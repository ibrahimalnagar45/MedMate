part of 'language_cubit.dart';

sealed class LanguageState {}

final class LanguageInitial extends LanguageState {}

final class LanguageChanged extends LanguageState {
  final String languageCode;
  LanguageChanged({required this.languageCode});
}

final class LanguageChangeFailure extends LanguageState {
  final String erMessage;
  LanguageChangeFailure({required this.erMessage});
}
