import 'package:midmate/core/models/logs_model.dart';
import 'package:midmate/features/chart/data/repos/logs_repo_impl.dart';
import 'package:midmate/features/chart/presentaion/manager/cubit/logs_cubit.dart';
import 'package:midmate/utils/models/med_model.dart';

import '../../../home/data/local_data_base/crud.dart';
import '../../doman/today_meds_repo.dart';

class TodayMedsRepoImpl extends TodayMedRepo {
  final Crud crud;

  TodayMedsRepoImpl({required this.crud});
  @override
  Future<List<MedModel>> getTodayMeds(int userId) async {
    var todayMeds = await crud.getTodayMeds(userId: userId);
    for (MedModel med in todayMeds) {
      LogsRepoImpl(crud: crud).insertLog(
        LogModel(
          medicationId: med.id!,
          date: DateTime.now().toString(),
          status: StatusValues.pending,
        ),
      );
    }
    return todayMeds;
  }

  @override
  Future<void> updateNextTime(MedModel med) async {
    await crud.updateMed(med);
  }
}
