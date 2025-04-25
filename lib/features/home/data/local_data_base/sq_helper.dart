import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:midmate/features/home/data/local_data_base/db_constants.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqHelper {
  Database? db;

  SqHelper() {
    getDbInstance();
    // Future.sync(() async => getDbInstance());
  }

  Future<String> _getDbPath() async {
    databaseFactory = databaseFactorySqflitePlugin;
    String dbPath = await getDatabasesPath();
    return join(dbPath, DbConstants.tableName);
  }

  // create db or open it
  Future<Database> getDbInstance() async {
    String path = await _getDbPath();
    try {
      // await deleteDatabase(path);

      db = await openDatabase(
        path,
        version: 1,
        onCreate: (Database db, int version) async {
          await db.execute('''
create table ${DbConstants.tableName} ( 
  ${DbConstants.columnId} integer primary key autoincrement, 
  ${DbConstants.columnName} text not null,
  ${DbConstants.columnDescription} text ,
  ${DbConstants.columnType} text ,
  ${DbConstants.columnAmount} double,
  ${DbConstants.columnFrequency} integer,
  ${DbConstants.columnStartDate} text ,
  ${DbConstants.columnCreatedAt} text )
''');
        },
        onOpen: _onOpen,
        onConfigure: _onConfig,
        onUpgrade: _onUpgrade, // Fix: Add proper upgrade logic
        onDowngrade: _onDowngrade,
      );
    } catch (e) {
      log(e.toString());
    }

    log('from onCreate  :  ${db == null}');

    return db!;
  }

  void _onOpen(Database db) {
    debugPrint('Database opened');
  }

  void _onConfig(Database db) {
    debugPrint('Database configured');
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) async {
    debugPrint('Database upgraded from $oldVersion to $newVersion');
  }

  void _onDowngrade(Database db, int oldVersion, int newVersion) {
    debugPrint('Database downgraded from $oldVersion to $newVersion');
  }

  //   Future open(String path) async {
  //     db = await openDatabase(
  //       path,
  //       version: 1,
  //       onCreate: (Database db, int version) async {
  //         await db.execute('''
  // create table ${DbConstants.tableName} (
  //   ${DbConstants.columnId} integer primary key autoincrement,
  //   ${DbConstants.columnName} text not null,
  //   ${DbConstants.columnDescription} text ,
  //   ${DbConstants.columnType} text ,
  //   ${DbConstants.columnAmount} double,
  //   ${DbConstants.columnFrequency} inetger,
  //   ${DbConstants.columnStartDate} text )
  // ''');
  //       },
  //     );
  //   }
}
