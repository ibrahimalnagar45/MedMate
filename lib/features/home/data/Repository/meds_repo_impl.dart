import 'package:midmate/core/models/logs_model.dart';
import 'package:midmate/features/home/data/local_data_base/crud.dart';
import 'package:midmate/features/home/doman/repository/meds_repo.dart';
import 'package:midmate/utils/models/med_model.dart';

class MedsRepoImpl implements MedsRepository {
  final Crud crud;

  MedsRepoImpl({required this.crud});
  @override
  Future<void> deleteMedFrom(int id, String tableName) async {
    await crud.deleteMedFrom(id: id, tableName: tableName);
  }

  
  @override
  Future<List<MedModel>> getAllMeds(int userId) async {
    var meds = await crud.getUserAllMeds(userId: userId);

    return meds;
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
