import '../../../../core/models/logs_model.dart';
import '../../../../utils/models/med_model.dart';

abstract class LogsRepo {
  // Logs related methods
  Future<void> insertLog(LogModel log);
  Future<List<LogModel>> getAllLogs(int userId);
  Future<List<LogModel>> getTodayLogs(int userId);
  Future<LogModel?> getLog({required int logId});
  Future<LogModel?> getlogByMed({required MedModel med});
  Future<int> updateLog({required int logId, required String newStatus});
  Future<void> deleteLog(int medId);
  Future<void> deleteAllLogs();
}
