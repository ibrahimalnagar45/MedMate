import 'dart:developer';
import 'dart:io';
import 'package:path/path.dart';

import 'package:sqflite/sqflite.dart';
import '../../features/home/data/local_data_base/db_constants.dart';

Future<void> exportDatabaseToDownloads() async {
  final dbPath = join(await getDatabasesPath(), DbConstants.medTableName);
  final dbFile = File(dbPath);
  final downloadPath = '/sdcard/Download/${DbConstants.medTableName}.db';

  await dbFile.copy(downloadPath);
  log('✅ Database copied to: $downloadPath');
}
