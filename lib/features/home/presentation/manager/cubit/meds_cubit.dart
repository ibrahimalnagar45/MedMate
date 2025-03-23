import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midmate/features/home/data/local_data_base/crud.dart';
import 'package:midmate/utils/models/med_model.dart';

part 'meds_state.dart';

class MedsCubit extends Cubit<GetMedsState> {
  MedsCubit() : super(MedsInitial());

  final Crud db = Crud.instance;
  List<MedModel> meds = [];
  getAllMed() async {
    emit(MedsLoading());
    try {
      meds = await db.getAllMeds();
      emit(GetMedsSuccess(meds: meds));
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
}
