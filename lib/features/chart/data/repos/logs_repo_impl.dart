import 'package:midmate/core/models/logs_model.dart';
import 'package:midmate/features/chart/doman/repository/logs_repo.dart';
import 'package:midmate/features/home/data/local_data_base/crud.dart';

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
}
