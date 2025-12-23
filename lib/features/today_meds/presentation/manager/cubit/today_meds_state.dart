part of 'today_meds_cubit.dart';

sealed class TodayMedsState {}

final class TodayMedsInitial extends TodayMedsState {}

final class GetTodayMedsLoading extends TodayMedsState {}

final class GetTodayMedsSuccess extends TodayMedsState {
  final List<MedModel> meds;
  GetTodayMedsSuccess({required this.meds});
}

final class GetTodayMedsFaluire extends TodayMedsState {
  final String erMessage;
  GetTodayMedsFaluire({required this.erMessage});
}

final class MarkMedAsTakenSuccess extends TodayMedsState {
  final List<MedModel> todayMeds, takenMeds;

  MarkMedAsTakenSuccess({required this.todayMeds, required this.takenMeds});
}

final class MarkMedAsTakenFailure extends TodayMedsState {
  final String erMessage;
  MarkMedAsTakenFailure({required this.erMessage});
}

final class UndoMedTakenSuccess extends TodayMedsState {
  final List<MedModel> todayMeds, takenMeds;

  UndoMedTakenSuccess({required this.todayMeds, required this.takenMeds});
}

final class UndoMedTakenFailure extends TodayMedsState {
  final String erMessage;
  UndoMedTakenFailure({required this.erMessage});
}
