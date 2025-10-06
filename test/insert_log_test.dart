import 'package:midmate/features/home/data/local_data_base/crud.dart';
import 'package:test/test.dart';
import 'package:midmate/core/models/logs_model.dart';
import 'package:midmate/features/home/data/local_data_base/sq_helper.dart';
import 'package:midmate/features/home/data/local_data_base/db_constants.dart';
import 'dart:developer';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  // initialize sqflite for Dart

  setUpAll(() {
    // await serviceLocatorSetup();/
    // delelteEverthing();

    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    SqHelper();
  });

  test('Insert log test', () async {
    // 1️⃣ Get db instance
    final db = await SqHelper().getLogsDbInstance();

    // 2️⃣ Create a log model
    final logModel = LogModel(
      medicationId: 1,
      date: '2025-10-05',
      takenTime: '10:30',
      status: StatusValues.taken,
    );

    // 3️⃣ Call your insertLog function
    await Crud.instance.insertLog(logModel, 1);
    // await insertLog(logModel);

    // 4️⃣ Query the DB to verify it’s inserted
    final result = await db.query(LogsTable.tableName);
    print('Logs: $result');

    expect(result.isNotEmpty, true);
    expect(result.first[LogsTable.logStatus], equals(StatusValues.taken));
  });
}
