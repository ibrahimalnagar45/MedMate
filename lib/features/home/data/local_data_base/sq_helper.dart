

import 'dart:developer';
import 'package:midmate/features/home/data/local_data_base/db_constants.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqHelper {
  Database? db;

  Future<String> _getDbPath(String dbTableName) async {
    String dbPath = await getDatabasesPath();
    return join(dbPath, dbTableName);
  }

  // ✅ MEDS DB
  Future<Database> getMedsDbInstance() async {
    String path = await _getDbPath(MedsTable.path);
    return openDatabase(
      path,
      version: 5,
      onCreate: (Database db, int version) async {
        await db.execute('''
CREATE TABLE ${MedsTable.tableName} ( 
  ${MedsTable.medId} INTEGER PRIMARY KEY AUTOINCREMENT, 
  ${MedsTable.medName} TEXT NOT NULL,
  ${MedsTable.medDescription} TEXT,
  ${MedsTable.medType} TEXT,
  ${MedsTable.medAmount} REAL,
  ${MedsTable.medFrequency} INTEGER,
  ${MedsTable.medStartDate} TEXT,
  ${MedsTable.medCreatedAt} TEXT,
  ${UsersTable.userId} INTEGER,
  FOREIGN KEY (${UsersTable.userId}) REFERENCES ${UsersTable.tableName} (${UsersTable.userId})
);
''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 5) {
          await db.execute('DROP TABLE IF EXISTS ${MedsTable.tableName}');
          await db.execute('''
CREATE TABLE ${MedsTable.tableName} ( 
  ${MedsTable.medId} INTEGER PRIMARY KEY AUTOINCREMENT, 
  ${MedsTable.medName} TEXT NOT NULL,
  ${MedsTable.medDescription} TEXT,
  ${MedsTable.medType} TEXT,
  ${MedsTable.medAmount} REAL,
  ${MedsTable.medFrequency} INTEGER,
  ${MedsTable.medStartDate} TEXT,
  ${MedsTable.medCreatedAt} TEXT,
  ${MedsTable.mednextTime} TEXT,

  ${UsersTable.userId} INTEGER,
  FOREIGN KEY (${UsersTable.userId}) REFERENCES ${UsersTable.tableName} (${UsersTable.userId})
);
''');
        }
      },
      onOpen: _onOpen,
      onConfigure: _onConfig,
      );
  }

  // ✅ LOGS DB
  Future<Database> getLogsDbInstance() async {
    String path = await _getDbPath(LogsTable.path);
    return openDatabase(
      path,
      version: 5,
      onCreate: (Database db, int version) async {
        await db.execute('''
CREATE TABLE ${LogsTable.tableName} (
  ${LogsTable.logId} INTEGER PRIMARY KEY AUTOINCREMENT,
  ${LogsTable.logDateTime} TEXT NOT NULL,       -- YYYY-MM-DD
  ${LogsTable.logTakenTime} TEXT,               -- actual time user confirmed
  ${LogsTable.logStatus} TEXT NOT NULL,         -- taken, missed, skipped
  ${UsersTable.userId} INTEGER,
  ${MedsTable.medId} INTEGER,
  FOREIGN KEY (${UsersTable.userId}) REFERENCES ${UsersTable.tableName} (${UsersTable.userId}),
  FOREIGN KEY (${MedsTable.medId}) REFERENCES ${MedsTable.tableName} (${MedsTable.medId})
);
''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 5) {
          await db.execute('DROP TABLE IF EXISTS ${LogsTable.tableName}');
          await db.execute('''
CREATE TABLE ${LogsTable.tableName} (
  ${LogsTable.logId} INTEGER PRIMARY KEY AUTOINCREMENT,
  ${LogsTable.logDateTime} TEXT NOT NULL,
  ${LogsTable.logTakenTime} TEXT,
  ${LogsTable.logStatus} TEXT NOT NULL,
  ${UsersTable.userId} INTEGER,
  ${MedsTable.medId} INTEGER,
  FOREIGN KEY (${UsersTable.userId}) REFERENCES ${UsersTable.tableName} (${UsersTable.userId}),
  FOREIGN KEY (${MedsTable.medId}) REFERENCES ${MedsTable.tableName} (${MedsTable.medId})
);
''');
        }
      },
      onOpen: _onOpen,
      onConfigure: _onConfig,
    );
  }

  // ✅ USERS DB
  Future<Database> getUsersDbInstance() async {
    String path = await _getDbPath(UsersTable.path);
    return openDatabase(
      path,
      version: 6,
      onCreate: (Database db, int version) async {
        await db.execute('''
CREATE TABLE ${UsersTable.tableName} ( 
  ${UsersTable.userId} INTEGER PRIMARY KEY AUTOINCREMENT, 
  ${UsersTable.isCurrentUser} INTEGER NOT NULL DEFAULT 0,
  ${UsersTable.userName} TEXT NOT NULL,
  ${UsersTable.userAge} TEXT NOT NULL
);
''');
      },
      onOpen: _onOpen,
      onConfigure: _onConfig,
    );
  }

  void _onOpen(Database db) => log('Database opened');
  void _onConfig(Database db) => log('Database configured');
}
