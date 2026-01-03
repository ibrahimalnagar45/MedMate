import 'package:midmate/features/home/data/local_data_base/crud.dart';
import 'package:midmate/utils/models/med_model.dart';
import 'package:test/test.dart';
import 'package:midmate/core/models/logs_model.dart';
import 'package:midmate/features/home/data/local_data_base/sq_helper.dart';
import 'package:midmate/features/home/data/local_data_base/db_constants.dart';
import 'dart:developer';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  // initialize sqflite for Dart

  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    SqHelper();
  });

  test('get log by id test', () async {
    // 1️⃣ Get db instance
    final db = await SqHelper().getLogsDbInstance();
    await Crud.instance.insertLog(
      LogModel(
        id: 1,
        medicationId: 1,
        date: '2025-10-05',
        takenTime: '10:30',
        status: StatusValues.taken,
      ),
      8,
    );

    // 3️⃣ Call your insertLog function
    final result = await Crud.instance.getLog(logId: 1);
    // await insertLog(logModel);

    expect(result?.id, 1);
    expect(result?.medicationId, 1);
  });

  test('get log by med test', () async {
    // 1️⃣ Get db instance
    final db = await SqHelper().getLogsDbInstance();
    MedModel med = MedModel(
      name: 'name',
      description: 'description',
      type: MedType.cream,
      dose: 1,
      createdAt: DateTime.now(),
      frequency: 6,
      startDate: DateTime.now(),
    );
    await Crud.instance.insertLog(
      LogModel(
        id: 2,
        medicationId: 1,
        date: '2025-10-05',
        takenTime: '10:30',
        status: StatusValues.taken,
        nextTime: DateTime.now().toString(),
      ),
      8,
    );

    final result = await Crud.instance.getLogByMed(medId: med.id!, med: med);

    expect(result?.id, 2);
    expect(result?.medicationId, 1);
  });
}
