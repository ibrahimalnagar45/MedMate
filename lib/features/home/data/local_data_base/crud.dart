import 'dart:developer';

import 'package:midmate/features/home/data/local_data_base/sq_helper.dart';
import 'package:midmate/utils/models/med_model.dart';
import 'package:sqflite/sqflite.dart';
import 'db_constants.dart';

class Crud {
  const Crud._();
  static const Crud instance = Crud._();

  Future<MedModel> insert(MedModel med) async {
    Database db = await SqHelper().getDbInstance();

    await db.insert(DbConstants.tableName, med.toMap());
    log(med.toString());
    return med;
  }

  Future<List<MedModel>> getAllMeds() async {
    Database db = await SqHelper().getDbInstance();
    List<Map<String, dynamic>> maps = await db.query(DbConstants.tableName);
    return List.generate(maps.length, (i) {
      return MedModel.fromMap(maps[i]);
    });
  }

  Future<MedModel?> getMed(int id) async {
    Database db = await SqHelper().getDbInstance();

    List<Map<String, dynamic>> maps = await db.query(
      DbConstants.tableName,
      columns: [
        DbConstants.columnId,
        DbConstants.columnName,
        DbConstants.columnDescription,
        DbConstants.columnType,
        DbConstants.columnAmount,
        DbConstants.columnFrequency,
        DbConstants.columnStartDate,
        DbConstants.columnCreatedAt,
      ],
      where: '${DbConstants.columnId} = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return MedModel.fromMap(maps.first);
    }
    return null;
  }

  Future<int> delete(int id) async {
    Database db = await SqHelper().getDbInstance();

    return await db.delete(
      DbConstants.tableName,
      where: '${DbConstants.columnId} = ?',
      whereArgs: [id],
    );
  }

  Future<int> update(MedModel todo) async {
    Database db = await SqHelper().getDbInstance();

    return await db.update(
      DbConstants.tableName,
      todo.toMap(),
      where: '${DbConstants.columnId} = ?',
      whereArgs: [MedModel.newMed().id],
    );
  }

  Future<void> deleteAll() async {
    Database db = await SqHelper().getDbInstance();

    db.delete(DbConstants.tableName);
  }

  Future close() async {
    Database db = await SqHelper().getDbInstance();

    db.close();
  }
}
