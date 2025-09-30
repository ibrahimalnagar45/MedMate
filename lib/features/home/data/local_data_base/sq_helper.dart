import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:midmate/features/home/data/local_data_base/db_constants.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class SqHelper {
  Database? db;

  SqHelper() {
    getMedsDbInstance();
    getUsersDbInstance();
    getCurrentUserInstance();
  }

  Future<String> _getDbPath(String dbTableName) async {
    
    String dbPath = await getDatabasesPath();
    return join(dbPath, dbTableName);
  }

  // create db or open it
  Future<Database> getMedsDbInstance() async {
    String path = await _getDbPath(DbConstants.medTableName);
    try {
      db = await openDatabase(
        path,
        version: 3,
        onCreate: (Database db, int version) async {
          await db.execute('''
create table ${DbConstants.medTableName} ( 
  ${DbConstants.medsColumnId} integer primary key autoincrement, 
  ${DbConstants.usersColumnId} integer, 
  ${DbConstants.medsColumnName} text not null,
  ${DbConstants.medsColumnDescription} text ,
  ${DbConstants.medsColumnType} text ,
  ${DbConstants.medsColumnAmount} double,
  ${DbConstants.medsColumnFrequency} integer,
  ${DbConstants.medsColumnStartDate} text ,
  ${DbConstants.medsColumnCreatedAt} text )
''');
        },
        onOpen: _onOpen,
        onConfigure: _onConfig,
        onUpgrade: (db, oldVersion, newVersion) async {
          if (oldVersion < 3) {
            // Modify schema here
            await db.execute(
              "ALTER TABLE ${DbConstants.medTableName} ADD COLUMN ${DbConstants.usersColumnId} TEXT",
            );
          }
        }, // Fix: Add proper upgrade logic
        onDowngrade: _onDowngrade,
      );
    } catch (e) {
      log(e.toString());
    }

    log('from onCreate  :  ${db == null}');

    return db!;
  }

  Future<Database> getLogsDbInstance() async {
    String path = await _getDbPath(DbConstants.logsTableName);
    try {
      db = await openDatabase(
        path,
        version: 1,
        onCreate: (Database db, int version) async {
          await db.execute(''' create table ${DbConstants.logsTableName} (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  medication_id INTEGER NOT NULL,
  date TEXT NOT NULL,          -- YYYY-MM-DD
  taken_time TEXT,             -- actual time user confirmed
  status TEXT NOT NULL,        -- "taken", "missed", "skipped"
  FOREIGN KEY (medication_id) REFERENCES ${DbConstants.medTableName} (${DbConstants.medsColumnId})
         
       )''');
        },
      );
    } catch (e) {
      log(e.toString());
    }
    return db!;
  }

  /*
  THE SQL FOR THE LOGS TABLE

  id INTEGER PRIMARY KEY AUTOINCREMENT,
  medication_id INTEGER NOT NULL,
  date TEXT NOT NULL,          -- YYYY-MM-DD
  taken_time TEXT,             -- actual time user confirmed
  status TEXT NOT NULL,        -- "taken", "missed", "skipped"
  FOREIGN KEY (medication_id) REFERENCES medications (id)
 
 */
  Future<Database> getCurrentUserInstance() async {
    String path = await _getDbPath(DbConstants.currentUserTableName);
    try {
      // await deleteDatabase(path);

      db = await openDatabase(
        path,
        version: 5,
        onCreate: (Database db, int version) async {
          await db.execute('''
                          create table ${DbConstants.currentUserTableName}( 
                            ${DbConstants.usersColumnId} integer primary key autoincrement, 
                            ${DbConstants.isCurrentUser} integer,
                            ${DbConstants.usersColumnName} text not null,
                            ${DbConstants.usersColumnAge} text not null )
                          ''');
        },
        onOpen: _onOpen,
        onConfigure: _onConfig,
        // onUpgrade: (db, oldVersion, newVersion) async {
        //   if (oldVersion < 6) {
        //     // Modify schema here
        //     await db.execute(
        //       "ALTER TABLE ${DbConstants.currentUserTableName} ADD COLUMN ${"UserInsertedId"} TEXT",
        //     );
        //   }
        // }, // Fix: Add proper upgrade logic
        onDowngrade: _onDowngrade,
      );
    } catch (e) {
      log(e.toString());
    }

    log('from onCreate  :  ${db == null}');

    return db!;
  }

  Future<Database> getUsersDbInstance() async {
    String path = await _getDbPath(DbConstants.usersTableName);
    try {
      db = await openDatabase(
        path,
        version: 6,
        onCreate: (Database db, int version) async {
          await db.execute('''
                          create table ${DbConstants.usersTableName} ( 
                          ${DbConstants.usersColumnId} integer primary key autoincrement, 
                          ${DbConstants.isCurrentUser} integer Not NULL DEFAULT 0,
                          ${DbConstants.usersColumnName} text not null,
                          ${DbConstants.usersColumnAge} text not null )
                          ''');
        },
        onOpen: _onOpen,
        onConfigure: _onConfig,
        onUpgrade: (db, oldVersion, newVersion) async {
          if (oldVersion <= 6) {
            // Modify schema here
            await db.execute(
              "ALTER TABLE ${DbConstants.usersTableName} ADD COLUMN ${DbConstants.isCurrentUser}  integer Not NULL DEFAULT 0",
            );
          }
        },
        // / Fix: Add proper upgrade logic
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
