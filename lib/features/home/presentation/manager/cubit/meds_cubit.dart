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

  final Person? currentUser = getIt<UserCubit>().getCurrentUser();
  final Crud db = Crud.instance;
  List<MedModel> meds = [];
  getUserAllMeds() async {
    emit(MedsLoading());
    try {
      meds = await db.getUserAllMeds(
        userId: currentUser != null ? currentUser!.id! : 0,
      );
      emit(GetMedsSuccess(meds: meds));
      for (var med in meds) {
        log(med.toString());
      }
    } catch (e) {
      emit(GetMedsFaluire(erMessage: e.toString()));
    }
  }

  insert(MedModel med, int userId) {
    emit(MedsLoading());

    try {
      db.insertMed(med, userId);
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
