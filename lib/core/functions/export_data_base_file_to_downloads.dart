import 'dart:developer';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:sqflite/sqflite.dart';
import '../../features/home/data/local_data_base/db_constants.dart';

Future<void> exportMedsDatabaseToDownloads() async {
  final dbPath = join(await getDatabasesPath(), MedsTable.tableName);
  final dbFile = File(dbPath);

  final directory = await getExternalStorageDirectory();
  final downloadPath = join(directory!.path, '${MedsTable.tableName}.db');

  // final downloadPath =
  //     '/storage/emulated/0/Download/${DbConstants.tableName}.db';

  await dbFile.copy(downloadPath);
  log('✅ Database copied to: $downloadPath');
}

Future<void> exportLogsDatabaseToDownloads() async {
  final dbPath = join(await getDatabasesPath(), LogsTable.tableName);
  final dbFile = File(dbPath);

  final directory = await getExternalStorageDirectory();
  final downloadPath = join(directory!.path, '${LogsTable.tableName}.db');

  // final downloadPath =
  //     '/storage/emulated/0/Download/${DbConstants.tableName}.db';

  await dbFile.copy(downloadPath);
  log('✅ Database copied to: $downloadPath');
}
