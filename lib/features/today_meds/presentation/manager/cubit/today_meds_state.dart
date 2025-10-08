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
