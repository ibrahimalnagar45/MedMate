class MedsTable {
  static const String tableName = 'meds';
  static const String path = 'meds.db';
  static const String medId = 'MedId';
  static const String medName = 'name';
  static const String medDescription = 'description';
  static const String medType = 'type';
  static const String medAmount = 'amount';
  static const String medFrequency = 'frequency';
  static const String medStartDate = 'startDate';
  static const String medCreatedAt = 'createdAt';
}

class UsersTable {
  static const String tableName = 'users';
  static const String path = 'users.db';
  static const String userId = 'userId';
  static const String userName = 'name';
  static const String userAge = 'age';
  static const String isCurrentUser = 'isCurrentUser';
}

class LogsTable {
  static const String tableName = 'logs';
  static const String path = 'logs.db';

  static const String logId = 'LogId';
  static const String logDateTime = 'dateTime';
  static const String logStatus = 'status';
  static const String logTakenTime = 'takenTime';
}
