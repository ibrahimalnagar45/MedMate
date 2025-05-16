import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midmate/features/home/data/local_data_base/crud.dart';
import 'package:midmate/utils/models/med_model.dart';

part 'meds_state.dart';

class MedsCubit extends Cubit<MedsState> {
  MedsCubit() : super(MedsInitial());

  final Crud db = Crud.instance;
  List<MedModel> meds = [];
  getAllMed() async {
    emit(MedsLoading());
    try {

      meds = await db.getAllMeds();
      emit(GetMedsSuccess(meds: meds));
      for (var med in meds) {
        log(med.toString());
      }
    } catch (e) {
      emit(GetMedsFaluire(erMessage: e.toString()));
    }
  }

  insert(MedModel med) {
    emit(MedsLoading());

    try {
      db.insert(med);
      emit(InsertMedsSuccess(med: med));
    } catch (e) {
      emit(InsertMedsFaluire(erMessage: e.toString()));
    }
  }

  deleteAMed(int id) async {
    emit(MedsLoading());
    try {
      await db.delete(id);
      meds.removeWhere((med) => med.id == id);
      emit(DeleteMedSuccess());
      // emit(DeleteMedSuccess());
    } catch (e) {
      emit(DeleteMedFaluire(erMessage: e.toString()));
    }
  }
}
