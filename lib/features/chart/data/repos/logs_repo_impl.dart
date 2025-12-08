import 'package:midmate/core/models/logs_model.dart';
import 'package:midmate/features/chart/doman/repository/logs_repo.dart';
import 'package:midmate/features/home/data/local_data_base/crud.dart';
import 'package:midmate/utils/models/med_model.dart';

class LogsRepoImpl extends LogsRepo {
  final Crud crud;

  LogsRepoImpl({required this.crud});
  @override
  Future<List<LogModel>> getAllLogs(int userId) async {
    var logs = await crud.getUserLogs(userId: userId);
    return logs;
  }

  @override
  Future<void> insertLog(LogModel log) async {
    var currentUser = await crud.getCurrentUser();
    await crud.insertLog(log, currentUser!.id!);
  }

  @override
  Future<void> deleteLog(int medId) async {
    await crud.deleteLog(medId);
  }

  @override
  Future<void> deleteAllLogs() async {
    await crud.deleteAllLogs();
  }

  @override
  Future<List<LogModel>> getTodayLogs(int userId) async {
    List<LogModel> logs = await crud.getUserLogs(userId: userId);
    List<LogModel> todayLogs =
        logs
            .where(
              (log) => DateTime.parse(log.date).day == (DateTime.now().day),
            )
            .toList();
    return todayLogs;
  }

  @override
  Future<int> updateLog({
    required LogModel logModel,
    required String newStatus,
  }) async {
    int flag = await crud.updateLog(logModel: logModel, newStatus: newStatus);
    return flag;
  }

  @override
  Future<LogModel?> getLog({required int logId}) async {
    LogModel? log = await crud.getLog(logId: logId);
    return log;
  }

  @override
  Future<LogModel?> getlogByMed({required MedModel med}) async {
    LogModel? log = await crud.getLogByMed(med: med);
    return log;
  }
}
