import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midmate/core/models/logs_model.dart';
import 'package:midmate/features/home/doman/repository/meds_repo.dart';
import 'package:midmate/features/home/doman/repository/user_repo.dart';
import 'package:midmate/utils/models/med_model.dart';
import 'package:midmate/utils/models/user_model.dart';
part 'meds_state.dart';

class MedsCubit extends Cubit<MedsState> {
  final MedsRepository medsRepo;
  final UserRepository userRepo;
  MedsCubit({required this.medsRepo, required this.userRepo})
    : super(MedsInitial());

  List<MedModel> meds = [];

  Future<void> insertMed(MedModel med, int userId) async {
    emit(InsertMedLoading());

    try {
      await medsRepo.insertMed(med, userId);
      log('the inserted med is : ${med.toString()}');
      emit(InsertMedsSuccess(med: med));
    } catch (e) {
      log('the error when inserting med is: ${e.toString()}');
      emit(InsertMedsFaluire(erMessage: e.toString()));
    }
  }

  Future<void> getUserAllMeds() async {
    final Person? currentUser = await userRepo.getCurrentUser();

    emit(GetMedsLoading());
    try {
      meds = await medsRepo.getAllMeds(currentUser!.id!);

      emit(GetMedsSuccess(meds: meds));
      log('the meds are ${meds.toString()}');
      log('the user is ${currentUser.toString()}');
    } catch (e) {
      emit(GetMedsFaluire(erMessage: e.toString()));
    }
  }

   
//  
  Future<void> deleteAMed(int id, String tableName) async {
    emit(DeletMedLoading());
    try {
      await medsRepo.deleteMedFrom(id, tableName);
      meds.removeWhere((med) => med.id == id);
      emit(DeleteMedSuccess());
      // emit(DeleteMedSuccess());
    } catch (e) {
      emit(DeleteMedFaluire(erMessage: e.toString()));
    }
  }
}
