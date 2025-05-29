import 'dart:developer';
import 'package:midmate/core/helpers/show_snak_bar.dart';
import 'package:midmate/features/home/data/local_data_base/sq_helper.dart';
import 'package:midmate/utils/models/med_model.dart';
import 'package:midmate/utils/models/user_model.dart';
import 'package:sqflite/sqflite.dart';
import 'db_constants.dart';

class Crud {
  const Crud._();
  static const Crud instance = Crud._();

  // Future<MedModel> insertMed(MedModel med, int userId) async {
  //   Database db = await SqHelper().getMedsDbInstance();

  //   await db.insert(
  //     DbConstants.medTableName,
  //     med.toMap().putIfAbsent(med.id.toString(), () {
  //       return userId;
  //     }),
  //   );
  //   log(med.toString());
  //   return med;
  // }

  Future<MedModel> insertMed(MedModel med, int userId) async {
    final db = await SqHelper().getMedsDbInstance();

    // Check if the med already exists
    final existing = await db.query(
      DbConstants.medTableName,
      where: 'id = ? AND userId = ?',
      whereArgs: [med.id, userId],
    );

    if (existing.isNotEmpty) {
      log('Med with id ${med.id} already exists for user $userId');
      return med; // Don't insert again
    }

    // Insert only if it doesn't exist
    final medMap = med.toMap();
    medMap['userId'] = userId;

    await db.insert(DbConstants.medTableName, medMap);
    log('Inserted: $med');
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
  Future<List<MedModel>> getAUserMeds({required int id}) async {
    Database db = await SqHelper().getMedsDbInstance();
    List<Map<String, dynamic>> maps = await db.query(
      DbConstants.medTableName,
      where: "${DbConstants.usersColumnId}==$id",
    );
    return List.generate(maps.length, (i) {
      log(maps[i].toString());
      return MedModel.fromMap(maps[i]);
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

  Future closeUsersDb() async {
    Database db = await SqHelper().getUsersDbInstance();

    db.close();
  }
}
