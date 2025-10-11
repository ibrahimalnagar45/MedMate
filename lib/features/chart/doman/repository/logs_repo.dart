import '../../../../core/models/logs_model.dart';

abstract class LogsRepo {
  // Logs related methods
  Future<void> insertLog(LogModel log);
  Future<List<LogModel>> getAllLogs(int userId);
  Future<List<LogModel>> getTodayLogs(int userId);
  Future<void> deleteLog(int medId);
  Future<void> deleteAllLogs();
}
