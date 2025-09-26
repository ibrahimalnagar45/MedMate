import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midmate/core/managers/user_cubit/user_cubit.dart';
import 'package:midmate/features/home/data/local_data_base/crud.dart';
import 'package:midmate/utils/models/med_model.dart';
import 'package:midmate/utils/models/user_model.dart';
import 'package:midmate/utils/service_locator.dart';
part 'meds_state.dart';

class MedsCubit extends Cubit<MedsState> {
  MedsCubit() : super(MedsInitial());

  final Crud db = Crud.instance;
  List<MedModel> meds = [];
  List<MedModel> todayMeds = [];

  getUserAllMeds() async {
    final Person? currentUser = await getIt<UserCubit>().getCurrentUser();

    emit(MedsLoading());
    try {
      meds = await db.getUserAllMeds(userId: currentUser!.id!);

      emit(GetMedsSuccess(meds: meds));
      log('the meds are ${meds.toString()}');
      log('the user is ${currentUser.toString()}');
    } catch (e) {
      emit(GetMedsFaluire(erMessage: e.toString()));
    }
  }

  getTodayMeds() async {
    emit(GetTodayMedsLoading());
    final Person? currentUser = await getIt<UserCubit>().getCurrentUser();
    try {
      todayMeds = await db.getUserTodayMeds(userId: currentUser!.id!);
      log('the today meds are ${todayMeds.toString()}');
      emit(GetTodayMedsSuccess(meds: meds));
    } catch (e) {
      log('the error when getting today meds ${e.toString()}');
      emit(GetTodayMedsFaluire(erMessage: e.toString()));
    }
  }

  Future<void> insertMed(MedModel med, int userId) async {
    emit(MedsLoading());

    try {
      await db.insertMed(med, userId);
      emit(InsertMedsSuccess(med: med));
    } catch (e) {
      emit(InsertMedsFaluire(erMessage: e.toString()));
    }
  }

  deleteAMed(int id) async {
    emit(MedsLoading());
    try {
      await db.deleteMed(id);
      meds.removeWhere((med) => med.id == id);
      emit(DeleteMedSuccess());
      // emit(DeleteMedSuccess());
    } catch (e) {
      emit(DeleteMedFaluire(erMessage: e.toString()));
    }
  }
}
