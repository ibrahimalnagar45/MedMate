import 'package:midmate/core/models/logs_model.dart';
import 'package:midmate/features/home/data/local_data_base/crud.dart';
import 'package:midmate/features/home/doman/repository/meds_repo.dart';
import 'package:midmate/utils/models/med_model.dart';

class MedsRepoImpl implements MedsRepository {
  final Crud crud;

  MedsRepoImpl({required this.crud});
  @override
  Future<void> deleteMed(int id) async {
    await crud.deleteMed(id);
  }

  @override
  Future<List<LogsModel>> getAllLogs(int userId) async {
    var logs = await crud.getUserLogs(userId: userId);
    return logs;
  }

  @override
  Future<List<MedModel>> getAllMeds(int userId) async {
    var meds = await crud.getUserAllMeds(userId: userId);

    return meds;
  }

  @override
  Future<List<MedModel>> getTodayMeds(int userId) async {
    var todayMeds = await crud.getUserTodayMeds(userId: userId);
    return todayMeds;
  }

  @override
  Future<void> insertLog(LogsModel log) async {
    await crud.insertLog(log);
  }

  @override
  Future<void> insertMed(MedModel med, int userId) async {
    await crud.insertMed(med, userId);
  }

  @override
  Future<void> updateMed(MedModel med) {
    // TODO: implement updateMed
    throw UnimplementedError();
  }
}
