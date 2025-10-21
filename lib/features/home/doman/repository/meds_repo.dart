import '../../../../core/models/logs_model.dart';
import '../../../../utils/models/med_model.dart';

abstract class MedsRepository {
  Future<List<MedModel>> getAllMeds(int userdId);
  // Future<List<MedModel>> getTodayMeds(int userId);
  Future<void> insertMed(MedModel med, int userId);
  Future<MedModel?> getMed(int id);
  Future<void> updateMed(MedModel med);
  Future<void> deleteMedFrom(int id, String tableName);
}
