import 'dart:developer';
import 'package:midmate/core/models/logs_model.dart';
import 'package:midmate/features/chart/doman/repository/logs_repo.dart';
import 'package:midmate/features/home/data/local_data_base/sq_helper.dart';
import 'package:midmate/utils/models/med_model.dart';
import 'package:midmate/utils/models/user_model.dart';
import 'package:midmate/utils/service_locator.dart';
import 'package:sqflite/sqflite.dart';
import 'db_constants.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class Crud {
  const Crud._();
  static const Crud instance = Crud._();

  Future<MedModel> insertMed(MedModel med, int userId) async {
    final db = await SqHelper().getMedsDbInstance();

    // Check if the med already exists
    final existing = await db.query(
      MedsTable.tableName,
      where:
          '${MedsTable.medId} = ? AND ${UsersTable.userId} = ?AND ${MedsTable.medName} = ?',
      whereArgs: [med.id, userId, med.name],
    );

    if (existing.isNotEmpty) {
      log('Med with id ${med.id} already exists for user $userId');
      return med; // Don't insert again
    }

    // Insert only if it doesn't exist
    final medMap = med.toMap();
    medMap[UsersTable.userId] = userId;

    await db.insert(MedsTable.tableName, medMap);
    log('Inserted: $med for user $userId');
    return med;
  }

  Future<bool> doesUserExist(Person user) async {
    Database db = await SqHelper().getUsersDbInstance();
    final result = await db.query(
      UsersTable.tableName,
      where: 'name = ? AND age = ?',
      whereArgs: [user.name, user.age],
    );
    return result.isNotEmpty;
  }

  Future<void> insertUser(Person user) async {
    Database db = await SqHelper().getUsersDbInstance();
    bool exist = await doesUserExist(user);
    if (!exist) {
      await db.insert(UsersTable.tableName, user.toMap());
    } else {
      log('This User is already exist');
    }
    // return user;
  }

  // change the id to required
  Future<List<MedModel>> getUserAllMeds({required int userId}) async {
    log('getUserAllMeds called with userId: $userId');
    Database db = await SqHelper().getMedsDbInstance();
    List<Map<String, dynamic>> maps = await db.query(
      MedsTable.tableName,
      where: "${UsersTable.userId}= ?",
      whereArgs: [userId],
    );

    return List.generate(maps.length, (i) {
      log(maps[i].toString());
      return MedModel.fromMap(maps[i]);
    });
  }

  // Future<List<MedModel>?> getUserTodayMeds({required int userId}) async {}
  Future<List<MedModel>> getUserTodayMeds({required int userId}) async {
    List<MedModel> todayMeds = [];
    Database db = await SqHelper().getMedsDbInstance();
    List<Map<String, dynamic>> maps = await db.query(
      MedsTable.tableName,
      where: "${UsersTable.userId}= ?",
      whereArgs: [userId],
    );

    DateTime todayDate = DateTime.now();
    var logs = await getIt<LogsRepo>().getTodayLogs(userId);
    for (var med in maps) {
      MedModel temp = MedModel.fromMap(med);
      if (temp.getNextTime()?.day == todayDate.day)
      {  if (logs.any((l) {
          if (l.status != StatusValues.taken) {
            return temp.id == l.medicationId;
          }
          return false;
        })) {
          todayMeds.add(temp);
        }}
    }

    return todayMeds;
  }

  Future<void> insertLog(LogModel medLog, int userId) async {
    final db = await SqHelper().getLogsDbInstance();
    final List<Map<String, dynamic>> isExist = await db.query(
      LogsTable.tableName,
      where:
          '${UsersTable.userId} = ? AND  ${LogsTable.logId} = ? AND ${MedsTable.medId} = ? AND ${LogsTable.logDateTime} = ?',
      whereArgs: [userId, medLog.id, medLog.medicationId, medLog.date],
    );
    Map<String, dynamic> medMap = medLog.toMap();
    medMap[UsersTable.userId] = userId;
    if (isExist.isEmpty) {
      await db.insert(LogsTable.tableName, medMap);
    }
    log('Inserted log: ${medLog.toMap()}');
  }

  Future<List<LogModel>> getUserLogs({required int userId}) async {
    List<LogModel> logs = [];
    Database db = await SqHelper().getLogsDbInstance();
    List<Map<String, dynamic>> maps = await db.query(
      LogsTable.tableName,
      where: "${UsersTable.userId}= ?",
      whereArgs: [userId],
    );

    // log(LogModel.fromMap(maps[0]).toString());
    for (var logItem in maps) {
      logs.add(LogModel.fromMap(logItem));
    }
    return logs;
  }

  Future<LogModel?> getLog({required int logId}) async {
    Database db = await SqHelper().getLogsDbInstance();
    Person? user = await getCurrentUser();
    List<LogModel> logs = await getUserLogs(userId: user!.id!);

    LogModel log = logs.firstWhere((log) => log.id == logId);
    return log;
  }

  Future<LogModel?> getLogByMed({required MedModel med}) async {
    Database db = await SqHelper().getLogsDbInstance();
    Person? user = await getCurrentUser();
    List<LogModel> logs = await getUserLogs(userId: user!.id!);

    LogModel log = logs.firstWhere(
      (log) =>
          log.medicationId == med.id &&
          DateTime.parse(log.date).isBefore(med.nextTime!),
    );
    return log;
  }

  Future<int> updateLog({required int logId, required String newStatus}) async {
    final db = await SqHelper().getLogsDbInstance();

    int done;

    done = await db.update(
      LogsTable.tableName,
      {LogsTable.logStatus: newStatus},
      where: '$logId = ? ',
      whereArgs: [logId],
    );

    return done;
  }

  Future<void> deleteLog(int medId) async {
    Database db = await SqHelper().getLogsDbInstance();
    await db.delete(
      LogsTable.tableName,
      where: '${MedsTable.medId} = ?',
      whereArgs: [medId],
    );
  }

  Future<List<Person>> getAllusers() async {
    Database db = await SqHelper().getUsersDbInstance();
    List<Map<String, dynamic>> maps = await db.query(UsersTable.tableName);
    log(maps.toList().toString());
    return List.generate(maps.length, (i) {
      return Person.fromMap(maps[i]);
    });
  }

  Future<MedModel?> getMed(int id) async {
    Database db = await SqHelper().getMedsDbInstance();

    List<Map<String, dynamic>> maps = await db.query(
      MedsTable.tableName,
      columns: [
        MedsTable.medId,
        MedsTable.medName,
        MedsTable.medDescription,
        MedsTable.medType,
        MedsTable.medAmount,
        MedsTable.medFrequency,
        MedsTable.medStartDate,
        MedsTable.medCreatedAt,
      ],
      where: '${MedsTable.medId} = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return MedModel.fromMap(maps.first);
    }
    return null;
  }

  Future<Person?> getUser(int id) async {
    Database db = await SqHelper().getUsersDbInstance();

    List<Map<String, dynamic>> maps = await db.query(
      UsersTable.tableName,
      columns: [UsersTable.userId, UsersTable.userName, UsersTable.userAge],
      where: '${UsersTable.userId} = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Person.fromMap(maps.first);
    }
    return null;
  }

  Future<void> setCurrentUser(Person user) async {
    final db = await SqHelper().getUsersDbInstance();

    await db.update(
      UsersTable.tableName,
      {UsersTable.isCurrentUser: 0},
      where: '${UsersTable.isCurrentUser} = ?',
      whereArgs: [1],
    );
    await db.update(
      UsersTable.tableName,
      {UsersTable.isCurrentUser: 1},
      where: '${UsersTable.userId} = ?',
      whereArgs: [user.id],
    );
  }

  Future<Person?> getCurrentUser() async {
    final db = await SqHelper().getUsersDbInstance();

    final maps = await db.query(
      UsersTable.tableName,
      where: '${UsersTable.isCurrentUser} = ?',
      whereArgs: [1],
    );

    Person? user;
    if (maps.isNotEmpty) {
      log('Query result: ${maps.first}');
      user = Person.fromMap(maps.first);
      // return Person.fromMap(maps.first);
    }
    return user;
  }

  Future<int> deleteUser(int id) async {
    Database db = await SqHelper().getUsersDbInstance();

    return await db.delete(
      UsersTable.tableName,
      where: '${UsersTable.userId} = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteAllusers() async {
    Database db = await SqHelper().getUsersDbInstance();

    db.delete(UsersTable.tableName);
  }

  Future<void> deleteAllLogs() async {
    Database db = await SqHelper().getLogsDbInstance();

    db.delete(LogsTable.tableName);
  }

  Future<int> deleteMedFrom({
    required int id,
    required String tableName,
  }) async {
    Database db = await SqHelper().getMedsDbInstance();

    return await db.delete(
      tableName,
      where: '${MedsTable.medId} = ?',
      whereArgs: [id],
    );
  }

  Future<int> updateMed(MedModel med) async {
    Database db = await SqHelper().getMedsDbInstance();

    return await db.update(
      MedsTable.tableName,
      med.toMap(),
      where: '${MedsTable.medId} = ?',
      whereArgs: [MedModel.newMed().id],
    );
  }

  Future<int> updateUserInfo(MedModel todo) async {
    Database db = await SqHelper().getUsersDbInstance();

    return await db.update(
      UsersTable.tableName,
      todo.toMap(),
      where: '${UsersTable.userId} = ?',
      whereArgs: [Person().id],
    );
  }

  Future<void> deleteAllMeds() async {
    Database db = await SqHelper().getMedsDbInstance();

    db.delete(MedsTable.tableName);
  }

  Future closeMedsDb() async {
    Database db = await SqHelper().getMedsDbInstance();

    db.close();
  }

  Future<void> closeLogsDb() async {
    Database db = await SqHelper().getLogsDbInstance();

    db.close();
  }

  Future<void> deleteMedsDatabaseFile() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, MedsTable.path);

    if (await databaseExists(path)) {
      await deleteDatabase(path);
      log('Database deleted!');
    } else {
      log('Database does not exist!');
    }
  }

  Future<void> deleteUsersDatabaseFile() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, UsersTable.path);

    if (await databaseExists(path)) {
      await deleteDatabase(path);
      log('Database deleted!');
    } else {
      log('Database does not exist!');
    }
  }

  Future closeUsersDb() async {
    Database db = await SqHelper().getUsersDbInstance();

    db.close();
  }
}
