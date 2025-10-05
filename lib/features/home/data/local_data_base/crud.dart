import 'dart:developer'; 
import 'package:midmate/core/models/logs_model.dart';
import 'package:midmate/features/home/data/local_data_base/sq_helper.dart';
import 'package:midmate/utils/models/med_model.dart';
import 'package:midmate/utils/models/user_model.dart';
import 'package:sqflite/sqflite.dart';
import 'db_constants.dart';
import 'package:path/path.dart';

class Crud {
  const Crud._();
  static const Crud instance = Crud._();

  Future<MedModel> insertMed(MedModel med, int userId) async {
    final db = await SqHelper().getMedsDbInstance();

    // Check if the med already exists
    final existing = await db.query(
      MedsTable.tableName,
      where: '${MedsTable.medId} = ? AND ${UsersTable.userId} = ?',
      whereArgs: [med.id, userId],
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
    List<MedModel> todayMeds = [];
    print('getUserAllMeds called with userId: $userId');
    Database db = await SqHelper().getMedsDbInstance();
    List<Map<String, dynamic>> maps = await db.query(
      MedsTable.tableName,
      where: "${UsersTable.userId}= ?",
      whereArgs: [userId],
    );

    DateTime todayDate = DateTime.now();
    maps.asMap().entries.map((e) {
      MedModel temp = MedModel.fromMap(e.value);
      if (temp.getNextTime() == todayDate) {
        todayMeds.add(temp);
      }
    });

    return List.generate(maps.length, (i) {
      log(maps[i].toString());
      return MedModel.fromMap(maps[i]);
    });
  }

  // Future<List<MedModel>?> getUserTodayMeds({required int userId}) async {}
  Future<List<MedModel>> getUserTodayMeds({required int userId}) async {
    List<MedModel> todayMeds = [];
    log('getUserAllMeds called with userId: $userId');
    Database db = await SqHelper().getMedsDbInstance();
    List<Map<String, dynamic>> maps = await db.query(
      MedsTable.tableName,
      where: "${UsersTable.userId}= ?",
      whereArgs: [userId],
    );

    DateTime todayDate = DateTime.now();
    log(maps.toList().toString());

    for (var med in maps) {
      MedModel temp = MedModel.fromMap(med);
      log(temp.toString());
      if (temp.getNextTime()!.day == todayDate.day) {
        todayMeds.add(temp);
      }
    }
    // maps.forEach((med) {
    //   MedModel temp = MedModel.fromMap(med);
    //   log(temp.toString());
    //   if (temp.getNextTime()!.day == todayDate.day) {
    //     todayMeds.add(temp);
    //   }
    // });
    // maps.asMap().entries.map((e) {
    //   MedModel temp = MedModel.fromMap(e.value);
    //   log(temp.toString());
    //   if (temp.getNextTime()!.day == todayDate.day) {
    //     todayMeds.add(temp);
    //   }
    // });

    return todayMeds;
  }

  Future<void> insertLog(LogsModel medLog) async {
    final db = await SqHelper().getLogsDbInstance();
    final bool isExist = await db
        .query(
          LogsTable.tableName,
          where: '${LogsTable.logId} = ? AND ${MedsTable.medId} = ? AND ${LogsTable.logDateTime} = ?',
          whereArgs: [medLog.id, medLog.medicationId, medLog.date],
        )
        .then((value) => value.isNotEmpty);

    if (!isExist) {
      await db.insert(LogsTable.tableName, medLog.toMap());
    }
    log('Inserted log: ${medLog.toMap()}');
  }

  Future<List<LogsModel>> getUserLogs({required int userId}) async {
    List<LogsModel> logs = [];
    Database db = await SqHelper().getLogsDbInstance();
    List<Map<String, dynamic>> maps = await db.query(
      LogsTable.tableName,
      where: "${UsersTable.userId}= ?",
      whereArgs: [userId],
    );
    logs = List.generate(maps.length, (i) {
      return LogsModel.fromMap(maps[i]);
    });
    log("all logs are :" + logs.toString());
    return logs;
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

  // Future<void> setCurrentUser(Person user) async {
  //   Database db = await SqHelper().getCurrentUserInstance();
  //   // First, delete any existing current user
  //   await db.delete(DbConstants.currentUserTableName);
  //   // Then, insert the new current user
  //   await db.insert(
  //     DbConstants.currentUserTableName,
  //     user.toMap(),
  //     conflictAlgorithm: ConflictAlgorithm.replace,
  //   );
  //   log('Set current user: ${user.toString()} to db  ');
  // }

  // Future<Person?> getCurrentUser() async {
  //   log('getting the current user ');
  //   Database db = await SqHelper().getCurrentUserInstance();
  //   List<Map<String, dynamic>> maps = await db.query(
  //     DbConstants.currentUserTableName,
  //     limit: 1,
  //   );
  //   if (maps.isNotEmpty) {
  //     log('the current user is ' + maps.first.toString());
  //     return Person.fromMap(maps.first);
  //   } else {
  //     log('No current user found in the database.');
  //   }
  //   return null;
  // }

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

  Future<int> deleteMed(int id) async {
    Database db = await SqHelper().getMedsDbInstance();

    return await db.delete(
      MedsTable.tableName,
      where: '${MedsTable.medId} = ?',
      whereArgs: [id],
    );
  }

  Future<int> updateMed(MedModel todo) async {
    Database db = await SqHelper().getMedsDbInstance();

    return await db.update(
      MedsTable.tableName,
      todo.toMap(),
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

  Future<void> deleteMedsDatabaseFile() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, MedsTable.path);

    if (await databaseExists(path)) {
      await deleteDatabase(path);
      print('Database deleted!');
    } else {
      print('Database does not exist!');
    }
  }

  Future<void> deleteUsersDatabaseFile() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, UsersTable.path);

    if (await databaseExists(path)) {
      await deleteDatabase(path);
      print('Database deleted!');
    } else {
      print('Database does not exist!');
    }
  }

  Future closeUsersDb() async {
    Database db = await SqHelper().getUsersDbInstance();

    db.close();
  }
}
