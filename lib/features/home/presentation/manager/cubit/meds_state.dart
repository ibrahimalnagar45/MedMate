part of 'meds_cubit.dart';

sealed class GetMedsState {}

final class MedsInitial extends GetMedsState {}

final class MedsLoading extends GetMedsState {}

final class GetMedsFaluire extends GetMedsState {
  final String erMessage;

  GetMedsFaluire({required this.erMessage});
}

final class GetMedsSuccess extends GetMedsState {
  final List<MedModel> meds;
  GetMedsSuccess({required this.meds});
}

final class InsertMedsFaluire extends GetMedsState {
  final String erMessage;
  InsertMedsFaluire({required this.erMessage});
}

final class InsertMedsSuccess extends GetMedsState {
  final MedModel med;
  InsertMedsSuccess({required this.med});
}
