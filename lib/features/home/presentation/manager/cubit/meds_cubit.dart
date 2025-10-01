import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midmate/core/managers/user_cubit/user_cubit.dart';
import 'package:midmate/core/models/logs_model.dart';
import 'package:midmate/features/home/doman/repository/meds_repo.dart';
import 'package:midmate/features/home/doman/repository/user_repo.dart';
import 'package:midmate/utils/models/med_model.dart';
import 'package:midmate/utils/models/user_model.dart';
import 'package:midmate/utils/service_locator.dart';
part 'meds_state.dart';

class MedsCubit extends Cubit<MedsState> {
  final MedsRepository repo;
  final UserRepo userRepo;
  MedsCubit({required this.repo, required this.userRepo})
    : super(MedsInitial());

  List<MedModel> meds = [];
  List<MedModel> todayMeds = [];
  List<LogsModel> logs = [];
  
  Future<void> insertMed(MedModel med, int userId) async {
    emit(InsertMedLoading());

    try {
      await repo.insertMed(med, userId);
      emit(InsertMedsSuccess(med: med));
    } catch (e) {
      emit(InsertMedsFaluire(erMessage: e.toString()));
    }
  }

  getUserAllMeds() async {
    final Person? currentUser = await userRepo.getCurrentUser();

    emit(GetMedsLoading());
    try {
      meds = await repo.getAllMeds(currentUser!.id!);

      emit(GetMedsSuccess(meds: meds));
      log('the meds are ${meds.toString()}');
      log('the user is ${currentUser.toString()}');
    } catch (e) {
      emit(GetMedsFaluire(erMessage: e.toString()));
    }
  }

  Future<void> getTodayMeds() async {
    emit(GetTodayMedsLoading());
    final Person? currentUser = await userRepo.getCurrentUser();
    try {
      todayMeds = await repo.getTodayMeds(currentUser!.id!);
      log(' today meds are: ${todayMeds.toString()}');
      emit(GetTodayMedsSuccess(meds: todayMeds));
    } catch (e) {
      log('the error when getting today meds is: ${e.toString()}');
      emit(GetTodayMedsFaluire(erMessage: e.toString()));
    }
  }

  Future<void> insertLog(LogsModel log) async {
    try {
      emit(InserLogLoading());
      await repo.insertLog(log);

      emit(InsertLogSuccess(log: log));
    } catch (e) {
      emit(InsertLogFaluire(erMessage: e.toString()));
    }
  }

  Future<List<LogsModel>> getUserLogs() async {
    emit(GetUserLogsLoading());
    final Person? currentUser = await userRepo.getCurrentUser();

    try {
      logs = await repo.getAllLogs(currentUser!.id!);
      log(logs.toString());
      emit(GetUserLogsSuccess(logs: logs));
    } catch (e) {
      emit(GetUserLogsFaluire(erMessage: e.toString()));
    }
    return logs;
  }

  deleteAMed(int id) async {
    emit(DeletMedLoading());
    try {
      await repo.deleteMed(id);
      meds.removeWhere((med) => med.id == id);
      emit(DeleteMedSuccess());
      // emit(DeleteMedSuccess());
    } catch (e) {
      emit(DeleteMedFaluire(erMessage: e.toString()));
    }
  }
}
