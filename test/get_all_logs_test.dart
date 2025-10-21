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
     sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    SqHelper();
  });

  test('Insert log test', () async {
    // 1️⃣ Get db instance
    final db = await SqHelper().getLogsDbInstance();


    // 3️⃣ Call your insertLog function
    await Crud.instance.getUserLogs(userId: 1);
    // await insertLog(logModel);

    // 4️⃣ Query the DB to verify it’s inserted
    final result = await db.query(LogsTable.tableName);
    print(' All Logs: $result');

    expect(result.isNotEmpty, true);
    expect(result.first[LogsTable.logStatus], equals(StatusValues.taken));
  });
}
