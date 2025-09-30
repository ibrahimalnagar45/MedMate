import 'dart:developer';
import 'package:midmate/core/helpers/show_snak_bar.dart';
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
      DbConstants.medTableName,
      where:
          '${DbConstants.medsColumnId} = ? AND ${DbConstants.usersColumnId} = ?',
      whereArgs: [med.id, userId],
    );

    if (existing.isNotEmpty) {
      log('Med with id ${med.id} already exists for user $userId');
      return med; // Don't insert again
    }

    // Insert only if it doesn't exist
    final medMap = med.toMap();
    medMap[DbConstants.usersColumnId] = userId;

    await db.insert(DbConstants.medTableName, medMap);
    log('Inserted: $med for user $userId');
    return med;
  }

  Future<bool> doesUserExist(Person user) async {
    Database db = await SqHelper().getUsersDbInstance();
    final result = await db.query(
      DbConstants.usersTableName,
      where: 'name = ? AND age = ?',
      whereArgs: [user.name, user.age],
    );
    return result.isNotEmpty;
  }

  Future<Person> insertUser(Person user) async {
    Database db = await SqHelper().getUsersDbInstance();
    bool exist = await doesUserExist(user);
    if (!exist) {
      await db.insert(DbConstants.usersTableName, user.toMap());
    } else {
      showSnakBar('This User is already exist');
    }
    return user;
  }

  // change the id to required
  Future<List<MedModel>> getUserAllMeds({required int userId}) async {
    List<MedModel> todayMeds = [];
    print('getUserAllMeds called with userId: $userId');
    Database db = await SqHelper().getMedsDbInstance();
    List<Map<String, dynamic>> maps = await db.query(
      DbConstants.medTableName,
      where: "${DbConstants.usersColumnId}= ?",
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
      DbConstants.medTableName,
      where: "${DbConstants.usersColumnId}= ?",
      whereArgs: [userId],
    );

    DateTime todayDate = DateTime.now().add(Duration(days: 1));
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
          DbConstants.logsTableName,
          where: 'id = ? AND ${DbConstants.medsColumnId} = ? AND date = ?',
          whereArgs: [medLog.id, medLog.medicationId, medLog.date],
        )
        .then((value) => value.isNotEmpty);

    if (!isExist) {
      await db.insert(DbConstants.logsTableName, medLog.toMap());
      log('Inserted log: $medLog');
    }
  }

  Future<List<LogsModel>> getUserLogs({required int userId}) async {
    Database db = await SqHelper().getLogsDbInstance();
    List<Map<String, dynamic>> maps = await db.query(
      DbConstants.logsTableName,
      where: "${DbConstants.usersColumnId}= ?",
      whereArgs: [userId],
    );
    return List.generate(maps.length, (i) {
      return LogsModel.fromMap(maps[i]);
    });
  }

  Future<List<Person>> getAllusers() async {
    Database db = await SqHelper().getUsersDbInstance();
    List<Map<String, dynamic>> maps = await db.query(
      DbConstants.usersTableName,
    );
    log(maps.toList().toString());
    return List.generate(maps.length, (i) {
      return Person.fromMap(maps[i]);
    });
  }

  Future<MedModel?> getMed(int id) async {
    Database db = await SqHelper().getMedsDbInstance();

    List<Map<String, dynamic>> maps = await db.query(
      DbConstants.medTableName,
      columns: [
        DbConstants.medsColumnId,
        DbConstants.medsColumnName,
        DbConstants.medsColumnDescription,
        DbConstants.medsColumnType,
        DbConstants.medsColumnAmount,
        DbConstants.medsColumnFrequency,
        DbConstants.medsColumnStartDate,
        DbConstants.medsColumnCreatedAt,
      ],
      where: '${DbConstants.medsColumnId} = ?',
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
      DbConstants.usersTableName,
      columns: [
        DbConstants.usersColumnId,
        DbConstants.usersColumnName,
        DbConstants.usersColumnAge,
      ],
      where: '${DbConstants.usersColumnId} = ?',
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
      DbConstants.usersTableName,
      {DbConstants.isCurrentUser: 0},
      where: '${DbConstants.isCurrentUser} = ?',
      whereArgs: [1],
    );
    await db.update(
      DbConstants.usersTableName,
      {DbConstants.isCurrentUser: 1},
      where: '${DbConstants.usersColumnId} = ?',
      whereArgs: [user.id],
    );
  }

  Future<Person?> getCurrentUser() async {
    final db = await SqHelper().getUsersDbInstance();

    final maps = await db.query(
      DbConstants.usersTableName,
      where: '${DbConstants.isCurrentUser} = ?',
      whereArgs: [1],
    );

    if (maps.isNotEmpty) {
      log('Query result: ${maps.first}');

      return Person.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> deleteUser(int id) async {
    Database db = await SqHelper().getUsersDbInstance();

    return await db.delete(
      DbConstants.usersTableName,
      where: '${DbConstants.usersColumnId} = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteAllusers() async {
    Database db = await SqHelper().getUsersDbInstance();

    db.delete(DbConstants.usersTableName);
  }

  Future<int> deleteMed(int id) async {
    Database db = await SqHelper().getMedsDbInstance();

    return await db.delete(
      DbConstants.medTableName,
      where: '${DbConstants.medsColumnId} = ?',
      whereArgs: [id],
    );
  }

  Future<int> updateMed(MedModel todo) async {
    Database db = await SqHelper().getMedsDbInstance();

    return await db.update(
      DbConstants.medTableName,
      todo.toMap(),
      where: '${DbConstants.medsColumnId} = ?',
      whereArgs: [MedModel.newMed().id],
    );
  }

  Future<int> updateUserInfo(MedModel todo) async {
    Database db = await SqHelper().getUsersDbInstance();

    return await db.update(
      DbConstants.usersTableName,
      todo.toMap(),
      where: '${DbConstants.usersColumnId} = ?',
      whereArgs: [Person().id],
    );
  }

  Future<void> deleteAllMeds() async {
    Database db = await SqHelper().getMedsDbInstance();

    db.delete(DbConstants.medTableName);
  }

  Future closeMedsDb() async {
    Database db = await SqHelper().getMedsDbInstance();

    db.close();
  }

  Future<void> deleteMedsDatabaseFile() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, DbConstants.medsDbPath);

    if (await databaseExists(path)) {
      await deleteDatabase(path);
      print('Database deleted!');
    } else {
      print('Database does not exist!');
    }
  }

  Future<void> deleteUsersDatabaseFile() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, DbConstants.usersDbPath);

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
