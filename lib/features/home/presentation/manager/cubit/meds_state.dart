part of 'meds_cubit.dart';

sealed class MedsState {}

final class MedsInitial extends MedsState {}

final class InsertMedLoading extends MedsState {}

final class InsertMedsSuccess extends MedsState {
  final MedModel med;
  InsertMedsSuccess({required this.med});
}

final class InsertMedsFaluire extends MedsState {
  final String erMessage;
  InsertMedsFaluire({required this.erMessage});
}

final class GetMedsLoading extends MedsState {}

final class GetMedsSuccess extends MedsState {
  final List<MedModel> meds;
  GetMedsSuccess({required this.meds});
}

final class GetMedsFaluire extends MedsState {
  final String erMessage;

  GetMedsFaluire({required this.erMessage});
}


final class DeletMedLoading extends MedsState {}

final class DeleteMedSuccess extends MedsState {}

final class DeleteMedFaluire extends MedsState {
  final String erMessage;
  DeleteMedFaluire({required this.erMessage});
}
