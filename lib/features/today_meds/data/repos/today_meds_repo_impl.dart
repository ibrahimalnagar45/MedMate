import 'package:midmate/utils/models/med_model.dart';

import '../../../home/data/local_data_base/crud.dart';
import '../../doman/today_meds_repo.dart';

class TodayMedsRepoImpl extends TodayMedRepo {
  final Crud crud;

  TodayMedsRepoImpl({required this.crud});
  @override
  Future<List<MedModel>> getTodayMeds(int userId) async {
    var todayMeds = await crud.getTodayMeds(userId: userId);
    return todayMeds;
  }

  @override
  Future<void> updateNextTime(MedModel med) async {
    await crud.updateMed(med);
  }
}
