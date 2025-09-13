import 'dart:developer';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:sqflite/sqflite.dart';
import '../../features/home/data/local_data_base/db_constants.dart';

Future<void> exportDatabaseToDownloads() async {
  final dbPath = join(await getDatabasesPath(), DbConstants.medTableName);
  final dbFile = File(dbPath);

  
  
  final directory = await getExternalStorageDirectory(); 
  final downloadPath = join(directory!.path, '${DbConstants.medTableName}.db');

  // final downloadPath =
  //     '/storage/emulated/0/Download/${DbConstants.medTableName}.db';

  await dbFile.copy(downloadPath);
  log('✅ Database copied to: $downloadPath');
}
