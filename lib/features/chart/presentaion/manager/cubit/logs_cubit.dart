import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:midmate/features/chart/doman/repository/logs_repo.dart';
import 'package:midmate/features/home/doman/repository/user_repo.dart';

import '../../../../../core/models/logs_model.dart';
import '../../../../../utils/models/user_model.dart';

part 'logs_state.dart';

class LogsCubit extends Cubit<LogsState> {
  LogsCubit({required this.userRepo, required this.logsRepo})
    : super(LogsInitial());
  final UserRepository userRepo;
  final LogsRepo logsRepo;
  static List<LogModel> logs = [];

  Future<void> insertLog(LogModel log) async {
    try {
      emit(InserLogLoading());
      await logsRepo.insertLog(log);

      emit(InsertLogSuccess(log: log));
    } catch (e) {
      emit(InsertLogFaluire(erMessage: e.toString()));
    }
  }

  Future<List<LogModel>> getUserLogs() async {
    emit(GetUserLogsLoading());
    final Person? currentUser = await userRepo.getCurrentUser();

    try {
      logs = await logsRepo.getAllLogs(currentUser!.id!);
      log(logs.toString());
      emit(GetUserLogsSuccess(logs: logs));
    } catch (e) {
      emit(GetUserLogsFaluire(erMessage: e.toString()));
    }
    return logs;
  }

  // ToDo
  // create a fun to get today logs
  Future<void> updateLog({
    required LogModel logModel,
    required String newStatus,
  }) async {
    emit(UpdateLogLoading());

    try {
      int flag = await logsRepo.updateLog(
        logModel: logModel,
        newStatus: newStatus,
      );
      emit(UpdateLogSuccess(flag: flag));
    } catch (e) {
      emit(UpdateLogFaluire(errorMessage: e.toString()));
    }
  }

  Future<List<LogModel>> getTodayLogs() async {
    emit(GetTodayLogsLoading());
    final Person? currentUser = await userRepo.getCurrentUser();
    try {
      logs = await logsRepo.getTodayLogs(currentUser!.id!);
      log(logs.toString());
      emit(GetTodayLogsSuccess(logs: logs));
    } catch (e) {
      emit(GetTodayLogsFaluire(erMessage: e.toString()));
    }
    return logs;
  }
}
