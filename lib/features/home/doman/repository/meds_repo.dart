import '../../../../core/models/logs_model.dart';
import '../../../../utils/models/med_model.dart';

abstract class MedsRepository {
  Future<List<MedModel>> getAllMeds(int userdId);
  Future<List<MedModel>> getTodayMeds(int userId);
  Future<void > insertMed(MedModel med, int userId);
  Future<void> updateMed(MedModel med);
  Future<void > deleteMed(int id);
  
  // Logs related methods
  Future<void> insertLog(LogsModel log);
  Future<List<LogsModel>> getAllLogs(int userId);
}