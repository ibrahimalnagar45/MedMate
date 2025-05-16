class DbConstants {
  // name of the database
  static const String medTableName = 'meds';

   static const String usersTableName = 'users';


  // path of the database

  //meds database
  static const String medsDbPath = 'meds.db';
  // users database
  static const String usersDbPath = 'users.db';

  // column names
  // meds column names
  static const String medsColumnId = 'id';
  static const String medsColumnName = 'name';
  static const String medsColumnDescription = 'description';
  static const String medsColumnType = 'type';
  static const String medsColumnAmount = 'amount';
  static const String medsColumnFrequency = 'frequency';
  static const String medsColumnStartDate = 'startDate';
  static const String medsColumnCreatedAt = 'createdAt';

  // users column names
  static const String usersColumnId = 'id';
  static const String usersColumnName = 'name';
  static const String usersColumnAge = 'age';
}
