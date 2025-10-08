import '../../../utils/models/med_model.dart';

abstract class TodayMedRepo {
  Future<List<MedModel>> getTodayMeds(int userId);
}
